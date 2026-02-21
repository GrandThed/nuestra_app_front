import 'dart:async';

/// A utility class to debounce function calls.
/// Delays execution until a specified idle period has passed.
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 300)});

  /// Run the [action] after [delay] has passed without another call.
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel any pending debounced action.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Whether a debounced action is currently pending.
  bool get isPending => _timer?.isActive ?? false;

  /// Dispose of the debouncer and cancel any pending actions.
  void dispose() {
    cancel();
  }
}
