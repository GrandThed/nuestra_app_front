import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/router/app_router.dart';

/// Android back with the app's dispatcher: close what is open first, then
/// go to the start tab, then let the app close.
void main() {
  late GoRouter router;
  late ShellBackButtonDispatcher dispatcher;

  Future<void> pumpApp(WidgetTester tester) async {
    final shellKey = GlobalKey<NavigatorState>();
    router = GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(path: '/food/recipes/x', builder: (_, _) => const Text('RECIPE')),
        ShellRoute(
          navigatorKey: shellKey,
          builder: (_, _, child) => Scaffold(body: child),
          routes: [
            GoRoute(path: AppRoutes.home, builder: (_, _) => const Text('GASTOS')),
            GoRoute(
              path: AppRoutes.food,
              builder: (_, _) => Builder(
                builder: (c) => Column(children: [
                  const Text('COMIDA'),
                  TextButton(
                    onPressed: () => showModalBottomSheet(context: c, builder: (_) => const Text('SHEET')),
                    child: const Text('open sheet'),
                  ),
                  TextButton(onPressed: () => c.push('/food/recipes/x'), child: const Text('open recipe')),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
    dispatcher = ShellBackButtonDispatcher()..attach(router);
    await tester.pumpWidget(MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      backButtonDispatcher: dispatcher,
    ));
    router.go(AppRoutes.food);
    await tester.pumpAndSettle();
  }

  Future<bool> back(WidgetTester tester) async {
    final handled = await dispatcher.didPopRoute();
    await tester.pumpAndSettle();
    return handled;
  }

  testWidgets('back closes an open sheet and stays on the tab', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('open sheet'));
    await tester.pumpAndSettle();
    expect(find.text('SHEET'), findsOneWidget);

    expect(await back(tester), isTrue);
    expect(find.text('SHEET'), findsNothing);
    expect(find.text('COMIDA'), findsOneWidget);

    expect(await back(tester), isTrue);
    expect(find.text('GASTOS'), findsOneWidget);
    expect(await back(tester), isFalse, reason: 'on the start tab, back closes the app');
  });

  testWidgets('back from a pushed screen returns to the tab it came from', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('open recipe'));
    await tester.pumpAndSettle();
    expect(find.text('RECIPE'), findsOneWidget);

    expect(await back(tester), isTrue);
    expect(find.text('COMIDA'), findsOneWidget);
  });
}
