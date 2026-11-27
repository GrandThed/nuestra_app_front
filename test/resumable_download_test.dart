import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/features/assistant/data/resumable_download.dart';

/// A server like Hugging Face: a redirect, then a file that supports Range.
/// [cutAfter] makes the first N responses drop the connection after that
/// many bytes.
class _FakeHost {
  final Uint8List data;
  final List<int> cutAfter;
  final bool ignoreRange;
  final List<String?> ranges = [];
  late final HttpServer server;

  _FakeHost(this.data, {this.cutAfter = const [], this.ignoreRange = false});

  Uri get url => Uri.parse('http://127.0.0.1:${server.port}/resolve/model.bin');

  Future<void> start() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    var served = 0;
    server.listen((req) async {
      if (req.uri.path.startsWith('/resolve')) {
        req.response
          ..statusCode = 302
          ..headers.set('location', '/cdn/model.bin?sig=1');
        await req.response.close();
        return;
      }
      final range = req.headers.value('range');
      ranges.add(range);
      var start = 0;
      if (range != null && !ignoreRange) {
        start = int.parse(RegExp(r'bytes=(\d+)-').firstMatch(range)![1]!);
        req.response
          ..statusCode = 206
          ..headers.set('content-range', 'bytes $start-${data.length - 1}/${data.length}');
      }
      final body = data.sublist(start);
      final cut = served < cutAfter.length ? cutAfter[served] : null;
      served++;
      req.response.contentLength = body.length;
      if (cut == null) {
        req.response.add(body);
        await req.response.close();
      } else {
        // Send part of it, then kill the connection
        final socket = await req.response.detachSocket(writeHeaders: true);
        socket.add(body.sublist(0, cut));
        await socket.flush();
        socket.destroy();
      }
    });
  }
}

void main() {
  late Directory dir;
  final data = Uint8List.fromList(List.generate(300000, (i) => i * 7 % 251));

  setUp(() async => dir = await Directory.systemTemp.createTemp('resumable'));
  tearDown(() async => dir.delete(recursive: true));

  ResumableDownload download(Uri url) => ResumableDownload(
        url: url,
        target: File('${dir.path}/models/model.bin'),
        expectedBytes: data.length,
        backoff: (_) => Duration.zero,
        idleTimeout: const Duration(seconds: 5),
      );

  test('a dropped connection continues from where it stopped', () async {
    final host = _FakeHost(data, cutAfter: [100000, 50000]);
    await host.start();
    final d = download(host.url);
    await d.run(onProgress: (_, _) {});

    expect(await d.target.readAsBytes(), data);
    expect(await d.partial.exists(), isFalse);
    expect(host.ranges, [null, 'bytes=100000-', 'bytes=150000-']);
    await host.server.close(force: true);
  });

  test('cancel keeps the downloaded part, and the next run continues', () async {
    final host = _FakeHost(data, cutAfter: [120000]);
    await host.start();
    final d = download(host.url);
    final cancel = Completer<void>();
    final run = d.run(
      cancelled: cancel.future,
      onProgress: (received, _) {
        if (received >= 120000 && !cancel.isCompleted) cancel.complete();
      },
    );
    await expectLater(run, throwsA(isA<DownloadCancelled>()));
    expect(await d.downloadedBytes(), 120000);

    await d.run(onProgress: (_, _) {});
    expect(await d.target.readAsBytes(), data);
    expect(host.ranges.last, 'bytes=120000-');
    await host.server.close(force: true);
  });

  test('a server that ignores the range starts the file over cleanly', () async {
    final host = _FakeHost(data, cutAfter: [80000], ignoreRange: true);
    await host.start();
    final d = download(host.url);
    await d.run(onProgress: (_, _) {});
    expect(await d.target.readAsBytes(), data);
    await host.server.close(force: true);
  });

  test('gives up after failures in a row and keeps what it has', () async {
    final d = ResumableDownload(
      url: Uri.parse('http://127.0.0.1:1/none'),
      target: File('${dir.path}/models/model.bin'),
      expectedBytes: data.length,
      maxFailuresInARow: 3,
      backoff: (_) => Duration.zero,
      idleTimeout: const Duration(seconds: 2),
    );
    await d.partial.parent.create(recursive: true);
    await d.partial.writeAsBytes(data.sublist(0, 1000));
    await expectLater(d.run(onProgress: (_, _) {}), throwsA(isA<Exception>()));
    expect(await d.downloadedBytes(), 1000);
  });
}
