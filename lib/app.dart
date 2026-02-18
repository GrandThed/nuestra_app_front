import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/core/theme/app_theme.dart';
import 'package:nuestra_app/features/settings/presentation/providers/settings_notifier.dart';

/// Main application widget
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp.router(
      title: 'Nuestra App',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      // Router
      routerConfig: router,

      // Localization (can be expanded later)
      locale: const Locale('es', 'AR'),
    );
  }
}
