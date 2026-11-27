import 'dart:async';
import 'dart:io';

/// The download was cancelled. What was downloaded stays on disk.
class DownloadCancelled implements Exception {
  const DownloadCancelled();
}

/// The server refused the file (401/403/404): retrying won't help.
class DownloadRefused implements Exception {
  final int statusCode;
  const DownloadRefused(this.statusCode);

  @override
  String toString() => 'El servidor rechazó la descarga (HTTP $statusCode)';
}

/// Downloads a big file so that an error never starts it over.
///
/// Bytes go to `<target>.part`. Every attempt asks the server only for what
/// is missing (HTTP `Range: bytes=<what we have>-`), so a dropped
/// connection, a timeout or the app being closed only costs the last few
/// kilobytes. Network errors are retried on their own with a growing pause;
/// the retry budget counts failures in a row, and any progress resets it.
/// When it runs out the partial file stays, and the next [run] continues
/// from it. On success the partial file is renamed to [target].
///
/// Redirects are followed by hand so the Range header reaches the final
/// host (Hugging Face answers with a 302 to a signed CDN URL that expires,
/// so every attempt starts again from [url]).
class ResumableDownload {
  final Uri url;
  final File target;
  final int expectedBytes;

  /// Failures in a row (without any progress) before giving up.
  final int maxFailuresInARow;

  /// A connection that sends nothing for this long is dropped and retried.
  final Duration idleTimeout;

  /// Pause before retry number [failures] (1, 2, ...).
  final Duration Function(int failures) backoff;

  final HttpClient Function() _clientFactory;

  ResumableDownload({
    required this.url,
    required this.target,
    required this.expectedBytes,
    this.maxFailuresInARow = 8,
    this.idleTimeout = const Duration(seconds: 30),
    Duration Function(int failures)? backoff,
    HttpClient Function()? clientFactory,
  })  : backoff = backoff ?? _defaultBackoff,
        _clientFactory = clientFactory ?? HttpClient.new;

  static Duration _defaultBackoff(int failures) =>
      Duration(seconds: [2, 4, 8, 15, 30][(failures - 1).clamp(0, 4)]);

  File get partial => File('${target.path}.part');

  /// Bytes already downloaded (0 if nothing yet, [expectedBytes] if done).
  Future<int> downloadedBytes() async {
    if (await target.exists()) return await target.length();
    if (await partial.exists()) return await partial.length();
    return 0;
  }

  /// Delete the finished file and any partial download.
  Future<void> delete() async {
    for (final f in [target, partial]) {
      if (await f.exists()) await f.delete();
    }
  }

  /// Download what is missing. [onProgress] gets the bytes on disk so far.
  /// Completing [cancelled] stops it with [DownloadCancelled].
  Future<void> run({
    required void Function(int received, int total) onProgress,
    Future<void>? cancelled,
  }) async {
    if (await target.exists() && await target.length() == expectedBytes) return;
    await target.parent.create(recursive: true);

    var isCancelled = false;
    HttpClient? client;
    unawaited(cancelled?.then((_) {
      isCancelled = true;
      client?.close(force: true);
    }));

    var failuresInARow = 0;
    while (true) {
      if (isCancelled) throw const DownloadCancelled();
      final start = await partial.exists() ? await partial.length() : 0;
      if (start > expectedBytes) {
        await partial.delete();
        continue;
      }
      if (start == expectedBytes) {
        await partial.rename(target.path);
        return;
      }
      onProgress(start, expectedBytes);

      client = _clientFactory()..connectionTimeout = idleTimeout;
      Object? error;
      try {
        await _fetch(client, start, onProgress, () => isCancelled);
      } on DownloadRefused {
        rethrow;
      } catch (e) {
        error = e;
      } finally {
        client.close(force: true);
      }
      if (isCancelled) throw const DownloadCancelled();

      // Any bytes written count as progress, even if the attempt then failed
      final now = await partial.exists() ? await partial.length() : 0;
      if (now != start) {
        failuresInARow = 0;
        continue; // the loop checks whether it is complete
      }
      failuresInARow++;
      if (failuresInARow >= maxFailuresInARow) {
        throw error ?? const HttpException('La descarga no avanza');
      }
      await Future<void>.delayed(backoff(failuresInARow));
    }
  }

  /// One request from byte [start], appending to the partial file.
  Future<void> _fetch(
    HttpClient client,
    int start,
    void Function(int, int) onProgress,
    bool Function() isCancelled,
  ) async {
    var uri = url;
    late HttpClientResponse response;
    for (var hops = 0; ; hops++) {
      final request = await client.getUrl(uri).timeout(idleTimeout);
      request.followRedirects = false;
      if (start > 0) request.headers.set(HttpHeaders.rangeHeader, 'bytes=$start-');
      response = await request.close().timeout(idleTimeout);
      final location = response.headers.value(HttpHeaders.locationHeader);
      if (response.isRedirect && location != null && hops < 8) {
        await response.drain<void>();
        uri = uri.resolve(location);
        continue;
      }
      break;
    }

    var offset = start;
    switch (response.statusCode) {
      case 206:
        final range = RegExp(r'bytes (\d+)-').firstMatch(response.headers.value('content-range') ?? '');
        if (range == null || int.parse(range[1]!) != start) {
          await response.drain<void>();
          throw const HttpException('El servidor devolvió otra parte del archivo');
        }
      case 200:
        offset = 0; // the server ignored the range: start this file over
      case 416:
        // Asked past the end: what we have is wrong, start over
        await response.drain<void>();
        await partial.delete();
        throw const HttpException('Rango inválido, se reinicia la descarga');
      case 401 || 403 || 404:
        await response.drain<void>();
        throw DownloadRefused(response.statusCode);
      default:
        await response.drain<void>();
        throw HttpException('HTTP ${response.statusCode}');
    }

    final sink = partial.openWrite(mode: offset == 0 ? FileMode.write : FileMode.append);
    var received = offset;
    try {
      await for (final chunk in response.timeout(idleTimeout)) {
        if (isCancelled()) break;
        sink.add(chunk);
        received += chunk.length;
        onProgress(received, expectedBytes);
      }
    } finally {
      await sink.flush();
      await sink.close();
    }
  }
}
