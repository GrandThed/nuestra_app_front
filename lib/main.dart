import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuestra_app/app.dart';

// Conditional import for share intent (mobile only)
import 'main_mobile.dart' if (dart.library.html) 'main_web.dart' as platform_main;

// Log function that works in both debug and release on web
void _log(String message) {
  // ignore: avoid_print
  print(message);
}

void main() async {
  _log('[main] Starting app initialization...');

  // Catch all Flutter errors and display them
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _log('Flutter Error: ${details.exception}');
    _log('Stack trace: ${details.stack}');
  };

  // Catch all async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    _log('Platform Error: $error');
    _log('Stack trace: $stack');
    return true;
  };

  try {
    WidgetsFlutterBinding.ensureInitialized();
    _log('[main] WidgetsFlutterBinding initialized');

    // Initialize Hive for local storage
    await Hive.initFlutter();
    _log('[main] Hive initialized');

    // Initialize date formatting for Spanish
    await initializeDateFormatting('es_AR', null);
    _log('[main] Date formatting initialized');

    // Set preferred orientations (portrait only for now) - skip on web
    if (!kIsWeb) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Set system UI overlay style
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }

    _log('[main] About to create app wrapper');
    final wrappedApp = platform_main.createAppWrapper(const App());
    _log('[main] App wrapper created');

    _log('[main] About to run app');
    runApp(ProviderScope(child: wrappedApp));
    _log('[main] runApp called');
  } catch (e, stack) {
    _log('[main] FATAL ERROR: $e');
    _log('[main] Stack trace: $stack');

    // Show error screen
    runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Error al iniciar la app',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                SelectableText(
                  stack.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
