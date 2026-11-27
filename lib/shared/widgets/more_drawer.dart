import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/data/models/user_model.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';
import 'package:nuestra_app/features/settings/presentation/providers/settings_notifier.dart';

/// Shown in the drawer. Keep in sync with `version:` in pubspec.yaml.
const appVersion = '0.5.0';

/// "Más": the right-side drawer with the profile, the household, the
/// expense tools, settings and sign out.
class MoreDrawer extends ConsumerStatefulWidget {
  const MoreDrawer({super.key});

  @override
  ConsumerState<MoreDrawer> createState() => _MoreDrawerState();
}

class _MoreDrawerState extends ConsumerState<MoreDrawer> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final id = ref.read(currentHouseholdIdProvider);
      if (id != null) ref.read(householdProvider.notifier).loadHouseholdIfNeeded(id);
    });
  }

  /// Close the drawer, then open [route] on top of the current tab.
  void _open(String route) {
    final router = GoRouter.of(context);
    Navigator.of(context).pop();
    router.push(route);
  }

  Future<void> _signOut() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Cerrar sesión?'),
        content: const Text('Vas a tener que entrar de nuevo con Google.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text(AppStrings.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text(AppStrings.signOut)),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    Navigator.of(context).pop();
    await ref.read(authProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final auth = ref.watch(authProvider);
    final user = auth is AuthStateAuthenticated ? auth.user : null;
    final householdState = ref.watch(householdProvider);
    final household = householdState is HouseholdStateLoaded ? householdState.household : null;
    final householdName = household?.name ?? user?.households?.firstOrNull?.name;

    return Drawer(
      width: 320,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                children: [
                  _ProfileHeader(user: user, onTap: () => _open(AppRoutes.profile)),
                  const SizedBox(height: 12),
                  _HouseholdCard(
                    name: householdName,
                    members: household?.members ?? const [],
                    onTap: () => _open(AppRoutes.householdSettings),
                  ),
                  const _SectionTitle('Hogar'),
                  _Item(
                    icon: Icons.group_outlined,
                    label: 'Miembros e invitaciones',
                    onTap: () => _open(AppRoutes.householdSettings),
                  ),
                  _Item(
                    icon: Icons.history,
                    label: 'Actividad',
                    onTap: () => _open(AppRoutes.activityFeed),
                  ),
                  const _SectionTitle('Gastos'),
                  _Item(
                    icon: Icons.bar_chart_outlined,
                    label: 'Resumen mensual',
                    onTap: () => _open(AppRoutes.expenseSummary),
                  ),
                  _Item(
                    icon: Icons.trending_up,
                    label: 'Tendencias',
                    onTap: () => _open(AppRoutes.expenseTrends),
                  ),
                  _Item(
                    icon: Icons.savings_outlined,
                    label: 'Presupuestos',
                    onTap: () => _open(AppRoutes.budgetSetup),
                  ),
                  _Item(
                    icon: Icons.repeat,
                    label: 'Gastos recurrentes',
                    onTap: () => _open(AppRoutes.recurringExpenses),
                  ),
                  const _SectionTitle('Configuración'),
                  _Item(icon: Icons.contrast, label: 'Apariencia'),
                  const _ThemePicker(),
                  _Item(
                    icon: Icons.info_outline,
                    label: 'Versión',
                    trailing: Text(appVersion,
                        style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _signOut,
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text(AppStrings.signOut),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: scheme.error,
                    side: BorderSide(color: scheme.error.withValues(alpha: 0.6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserModel? user;
  final VoidCallback onTap;
  const _ProfileHeader({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = user?.name ?? 'Usuario';
    final avatar = user?.avatarUrl;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: scheme.primary,
              foregroundImage: avatar == null || avatar.isEmpty ? null : NetworkImage(avatar),
              child: Text(_initials(name),
                  style: theme.textTheme.titleMedium?.copyWith(color: scheme.onPrimary)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: theme.textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (user?.email != null)
                    Text(user!.email,
                        style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  static String _initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _HouseholdCard extends StatelessWidget {
  final String? name;
  final List<MemberModel> members;
  final VoidCallback onTap;
  const _HouseholdCard({required this.name, required this.members, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Material(
      color: scheme.primaryContainer,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.home_rounded, color: scheme.onPrimaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? 'Tu hogar',
                        style: theme.textTheme.titleMedium?.copyWith(color: scheme.onPrimaryContainer),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text(
                      members.isEmpty
                          ? 'Ajustes del hogar'
                          : '${members.length} ${members.length == 1 ? 'miembro' : 'miembros'}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: scheme.onPrimaryContainer.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ),
              if (members.isNotEmpty) _MemberDots(members: members),
            ],
          ),
        ),
      ),
    );
  }
}

/// Overlapping initials of the household members, in their colors.
class _MemberDots extends StatelessWidget {
  final List<MemberModel> members;
  const _MemberDots({required this.members});

  @override
  Widget build(BuildContext context) {
    final shown = members.take(4).toList();
    final ring = Theme.of(context).colorScheme.primaryContainer;
    return SizedBox(
      width: 22.0 * shown.length + 8,
      height: 30,
      child: Stack(
        children: [
          for (final (i, m) in shown.indexed)
            Positioned(
              left: 22.0 * i,
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _color(m.colorHex),
                  shape: BoxShape.circle,
                  border: Border.all(color: ring, width: 2),
                ),
                child: Text(
                  m.name.isEmpty ? '?' : m.name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Color _color(String hex) {
    final value = int.tryParse(hex.replaceFirst('#', ''), radix: 16);
    return value == null ? Colors.blueGrey : Color(0xFF000000 | value);
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 4),
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  const _Item({required this.icon, required this.label, this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Icon(icon, color: scheme.onSurfaceVariant, size: 22),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _ThemePicker extends ConsumerWidget {
  const _ThemePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<ThemeMode>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: ThemeMode.system, label: Text('Sistema')),
            ButtonSegment(value: ThemeMode.light, label: Text('Claro')),
            ButtonSegment(value: ThemeMode.dark, label: Text('Oscuro')),
          ],
          selected: {mode},
          onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).setThemeMode(s.first),
        ),
      ),
    );
  }
}
