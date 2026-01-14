import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuestra_app/app.dart';
import 'package:nuestra_app/core/services/share_intent_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize date formatting for Spanish
  await initializeDateFormatting('es_AR', null);

  // Set preferred orientations (portrait only for now)
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

  runApp(
    ProviderScope(
      child: const ShareIntentInitializer(
        child: App(),
      ),
    ),
  );
}

/// Widget that initializes share intent listening
class ShareIntentInitializer extends ConsumerStatefulWidget {
  final Widget child;

  const ShareIntentInitializer({super.key, required this.child});

  @override
  ConsumerState<ShareIntentInitializer> createState() =>
      _ShareIntentInitializerState();
}

class _ShareIntentInitializerState
    extends ConsumerState<ShareIntentInitializer> {
  @override
  void initState() {
    super.initState();
    // Initialize share intent service after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shareIntentServiceProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
