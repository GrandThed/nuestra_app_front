// Renders the main screens with fake data in light and dark, using the real
// bundled fonts, and saves PNGs to build/design_preview/ for review.
// Also fails on layout errors (overflows) in those screens.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuestra_app/core/theme/app_theme.dart';
import 'package:nuestra_app/features/assistant/data/a2ui_bridge.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_screen.dart';
import 'package:nuestra_app/features/auth/data/models/user_model.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/add_expense_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';
import 'package:nuestra_app/shared/widgets/main_shell.dart';
import 'package:go_router/go_router.dart';

const _ana = ExpenseUserModel(id: 'u-ana', name: 'Ana');
const _beto = ExpenseUserModel(id: 'u-beto', name: 'Beto');
const _super = ExpenseCategoryModel(id: 'c1', name: 'Supermercado', icon: '🛒');
const _serv = ExpenseCategoryModel(id: 'c2', name: 'Servicios', icon: '💡');
const _hogar = ExpenseCategoryModel(id: 'c3', name: 'Hogar', icon: '🏠');

ExpenseModel _expense(String id, String desc, double amount, int day,
    ExpenseCategoryModel cat, ExpenseUserModel by,
    {bool settled = false, int? n, int? of}) {
  return ExpenseModel(
    id: id,
    householdId: 'h1',
    description: desc,
    amount: amount,
    date: DateTime(2026, 11, day),
    category: cat,
    paidBy: by,
    allSettled: settled,
    installmentNumber: n,
    installmentCount: of,
  );
}

final _expenses = [
  _expense('e1', 'Supermercado Coto', 48210, 23, _super, _ana),
  _expense('e2', 'Heladera (cuota 1/6)', 100000, 20, _hogar, _beto, n: 1, of: 6),
  _expense('e3', 'Luz Edenor', 35000, 12, _serv, _ana, settled: true),
  _expense('e4', 'Verdulería', 12500.5, 12, _super, _beto),
];

class _FakeExpenses extends ExpensesNotifier {
  @override
  ExpensesState build() => ExpensesState.loaded(
        categories: const [_super, _serv, _hogar],
        expenses: _expenses,
        selectedMonth: 11,
        selectedYear: 2026,
      );

  @override
  Future<void> loadExpensesIfNeeded() async {}
}

class _FakeAuth extends AuthNotifier {
  @override
  AuthState build() => const AuthState.authenticated(
        UserModel(id: 'u-ana', email: 'ana@test.local', name: 'Ana'),
      );
}

class _FakeHousehold extends HouseholdNotifier {
  @override
  HouseholdState build() => HouseholdState.loaded(
        HouseholdModel(
          id: 'h1',
          name: 'Casa',
          hemisphere: 'south',
          createdAt: DateTime(2026),
          members: const [
            MemberModel(id: 'm1', userId: 'u-ana', name: 'Ana', email: 'a', role: 'owner'),
            MemberModel(id: 'm2', userId: 'u-beto', name: 'Beto', email: 'b', role: 'member'),
          ],
        ),
      );

  @override
  Future<void> loadHouseholdIfNeeded(String id) async {}
}

class _FakeAssistant extends AssistantController {
  _FakeAssistant(this._state);
  final AssistantState _state;

  @override
  AssistantState build() => _state;
}

AssistantState _assistantState() {
  final bridge = A2uiBridge(onAction: (_) {});
  final instructions = A2uiBridge.compactInstructions;
  final card = bridge
      .parseReply(instructions.substring(instructions.lastIndexOf('<a2ui-json>')))
      .whereType<ReplySurface>()
      .single
      .surface;
  return AssistantState(
    modelStatus: ModelStatus.ready,
    conversationId: 'c1',
    items: [
      const UserItem('¿Cuánto gastamos este mes?'),
      const AssistantTextItem('Van \$ 158.600 en noviembre:'),
      SurfaceItem(card),
      const UserItem('Anotá 15000 de nafta', authorName: 'Beto'),
      ProposalItem(
        1,
        ExpenseProposal(
          description: 'Nafta',
          amount: 15000,
          date: DateTime(2026, 11, 26),
          categoryName: 'Transporte',
        ),
        ProposalStatus.pending,
      ),
    ],
  );
}

Future<void> _loadIconFont() async {
  final flutterRoot = Platform.environment['FLUTTER_ROOT'] ??
      File(Platform.resolvedExecutable).parent.parent.parent.parent.parent.path;
  final file = File(
    '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
  if (!file.existsSync()) return;
  final loader = FontLoader('MaterialIcons')
    ..addFont(Future.value(ByteData.sublistView(file.readAsBytesSync())));
  await loader.load();
}

Future<void> _snapshot(WidgetTester tester, String name) async {
  final boundary =
      tester.renderObject<RenderRepaintBoundary>(find.byKey(const Key('shot')));
  final image = await tester.runAsync(() => boundary.toImage(pixelRatio: 2));
  final bytes = await tester.runAsync(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  File('build/design_preview/$name.png')
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes!.buffer.asUint8List());
}

Future<void> _pumpScreen(
  WidgetTester tester, {
  required Widget child,
  required Brightness brightness,
  bool inShell = false,
  String location = '/expenses',
}) async {
  tester.view.physicalSize = const Size(390 * 2, 844 * 2);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: location,
    routes: [
      ShellRoute(
        builder: (context, state, c) => inShell ? MainShell(child: c) : c,
        routes: [
          GoRoute(path: '/expenses', builder: (_, _) => child),
          GoRoute(path: '/chat', builder: (_, _) => child),
          GoRoute(path: '/new', builder: (_, _) => child),
        ],
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        expensesProvider.overrideWith(_FakeExpenses.new),
        authProvider.overrideWith(_FakeAuth.new),
        householdProvider.overrideWith(_FakeHousehold.new),
        currentHouseholdIdProvider.overrideWithValue('h1'),
        recentExpensesForSuggestionsProvider.overrideWith((ref) async => []),
        expensePredictionsProvider.overrideWith((ref) async => [
              ExpensePredictionModel(
                key: 'internet',
                description: 'Internet',
                suggestedAmount: 22000,
                averageAmount: 21000,
                lastAmount: 22000,
                suggestedDate: DateTime.utc(2026, 11, 5),
                dayOfMonth: 5,
                monthsSeen: 4,
                lookbackMonths: 6,
                confidence: 0.89,
              ),
              ExpensePredictionModel(
                key: 'alquiler',
                description: 'Alquiler',
                suggestedAmount: 480000,
                averageAmount: 460000,
                lastAmount: 480000,
                suggestedDate: DateTime.utc(2026, 11, 1),
                dayOfMonth: 1,
                monthsSeen: 6,
                lookbackMonths: 6,
                confidence: 0.95,
              ),
            ]),
        assistantProvider.overrideWith(() => _FakeAssistant(_assistantState())),
      ],
      child: RepaintBoundary(
        key: const Key('shot'),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
          routerConfig: router,
        ),
      ),
    ),
  );
  // Fonts load from assets asynchronously
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('es');
    await initializeDateFormatting('es_AR');
    await _loadIconFont();
  });

  for (final brightness in Brightness.values) {
    final suffix = brightness.name;

    testWidgets('Gastos ($suffix)', (tester) async {
      await _pumpScreen(
        tester,
        child: const ExpensesScreen(),
        brightness: brightness,
        inShell: true,
      );
      expect(find.text('Total del mes'), findsOneWidget);
      expect(find.text('2 gastos fijos para cargar'), findsOneWidget);
      expect(find.text('cuota 1/6'), findsOneWidget);
      await _snapshot(tester, 'gastos_$suffix');
    });

    testWidgets('Nuevo gasto en cuotas ($suffix)', (tester) async {
      await _pumpScreen(
        tester,
        child: const AddExpenseScreen(),
        brightness: brightness,
        location: '/new',
      );
      await tester.enterText(find.byType(TextFormField).first, '600000');
      await tester.tap(find.byType(Switch));
      await tester.pump();
      for (var i = 0; i < 3; i++) {
        await tester.tap(find.byTooltip('Más cuotas'));
        await tester.pump();
      }
      await tester.pumpAndSettle();
      expect(find.text('Guardar compra en 6 cuotas'), findsOneWidget);
      await _snapshot(tester, 'nuevo_gasto_$suffix');
    });

    testWidgets('Asistente compartido ($suffix)', (tester) async {
      await _pumpScreen(
        tester,
        child: const AssistantScreen(),
        brightness: brightness,
        inShell: true,
        location: '/chat',
      );
      expect(find.text('Beto'), findsWidgets);
      expect(find.text('POR CONFIRMAR'), findsOneWidget);
      await _snapshot(tester, 'asistente_$suffix');
    });
  }
}
