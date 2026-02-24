import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/data/models/user_model.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';

/// Screen for managing household settings
class HouseholdSettingsScreen extends ConsumerStatefulWidget {
  const HouseholdSettingsScreen({super.key});

  @override
  ConsumerState<HouseholdSettingsScreen> createState() =>
      _HouseholdSettingsScreenState();
}

class _HouseholdSettingsScreenState
    extends ConsumerState<HouseholdSettingsScreen> {
  bool _isGeneratingInvite = false;

  @override
  void initState() {
    super.initState();
    // Use microtask to avoid modifying provider during build
    Future.microtask(() => _loadData());
  }

  void _loadData() {
    final authState = ref.read(authProvider);
    if (authState is AuthStateAuthenticated) {
      final householdId = authState.user.households?.firstOrNull?.id;
      if (householdId != null) {
        ref.read(householdProvider.notifier).loadHouseholdIfNeeded(householdId);
        ref
            .read(activeInviteProvider.notifier)
            .loadActiveInviteIfNeeded(householdId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final householdState = ref.watch(householdProvider);
    final inviteState = ref.watch(activeInviteProvider);

    final currentUser = authState is AuthStateAuthenticated
        ? authState.user
        : null;
    final household = householdState is HouseholdStateLoaded
        ? householdState.household
        : null;
    final activeInvite = inviteState is ActiveInviteStateLoaded
        ? inviteState.invite
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(household?.name ?? 'Configuración del Hogar'),
      ),
      body: householdState is HouseholdStateLoading
          ? const Center(child: CircularProgressIndicator())
          : householdState is HouseholdStateError
          ? _buildErrorState(householdState.message)
          : household != null
          ? _buildContent(context, household, currentUser, activeInvite)
          : const Center(child: Text('No hay hogar configurado')),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSizes.avatarXl,
              height: AppSizes.avatarXl,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: AppSizes.iconXl,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            FilledButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HouseholdModel household,
    UserModel? currentUser,
    HouseholdInviteModel? activeInvite,
  ) {
    final isOwner =
        household.members?.any(
          (m) => m.userId == currentUser?.id && m.role == 'owner',
        ) ??
        false;

    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      children: [
        // Members section
        _buildSectionHeader(
          context,
          icon: Icons.people_rounded,
          label: AppStrings.members,
          iconColor: AppColors.primary,
        ),
        const SizedBox(height: AppSizes.sm),
        _buildMembersSection(context, household, currentUser),
        const SizedBox(height: AppSizes.lg),

        // Expense split mode — owner only
        if (isOwner) ...[
          _buildSectionHeader(
            context,
            icon: Icons.account_balance_wallet_rounded,
            label: 'Gastos',
            iconColor: AppColors.expenses,
          ),
          const SizedBox(height: AppSizes.sm),
          _buildSplitModeCard(context, household),
          const SizedBox(height: AppSizes.lg),
        ],

        // Invite section — owner only
        if (isOwner) ...[
          _buildSectionHeader(
            context,
            icon: Icons.link_rounded,
            label: 'Invitar miembros',
            iconColor: AppColors.secondary,
          ),
          const SizedBox(height: AppSizes.sm),
          _buildInviteCard(context, household, activeInvite),
          const SizedBox(height: AppSizes.lg),
        ],

        // Danger zone
        _buildDangerZone(context, household, currentUser, isOwner),

        const SizedBox(height: AppSizes.xxl),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section header
  // ---------------------------------------------------------------------------

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          width: 3,
          height: AppSizes.lg,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
        ),
        const SizedBox(width: AppSizes.sm),
        Container(
          width: AppSizes.iconSm + AppSizes.sm,
          height: AppSizes.iconSm + AppSizes.sm,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          ),
          child: Icon(icon, size: AppSizes.iconSm, color: iconColor),
        ),
        const SizedBox(width: AppSizes.sm),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Members section
  // ---------------------------------------------------------------------------

  Widget _buildMembersSection(
    BuildContext context,
    HouseholdModel household,
    UserModel? currentUser,
  ) {
    if (household.members == null || household.members!.isEmpty) {
      return _buildEmptyMembersCard(context);
    }

    return Column(
      children: household.members!
          .map(
            (member) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.sm),
              child: _buildMemberCard(context, member, currentUser),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEmptyMembersCard(BuildContext context) {
    return _buildCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Center(
          child: Text(
            'Sin miembros',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context,
    MemberModel member,
    UserModel? currentUser,
  ) {
    final isCurrentUser = member.userId == currentUser?.id;
    final isOwner = member.role == 'owner';
    final avatarColor = _colorFromHex(member.colorHex);

    return _buildCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: AppSizes.avatarMd,
                  height: AppSizes.avatarMd,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: avatarColor,
                  ),
                  child: Center(
                    child: Text(
                      member.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.fontMd,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                // Name and role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              member.name,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      _buildRoleBadge(context, isOwner),
                    ],
                  ),
                ),
                // Income chip
                _buildIncomeChip(context, member, isCurrentUser),
              ],
            ),
            // Pays expenses toggle — only for the current user
            if (isCurrentUser) ...[
              const SizedBox(height: AppSizes.sm),
              Divider(
                height: 1,
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppSizes.xs),
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    size: AppSizes.iconSm,
                    color: AppColors.expenses,
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: Text(
                      'Responsable de pagar gastos',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Switch(
                    value: member.paysExpenses,
                    onChanged: (value) => _updatePaysExpenses(member, value),
                    activeTrackColor: AppColors.expenses.withValues(alpha: 0.4),
                    activeThumbColor: AppColors.expenses,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBadge(BuildContext context, bool isOwner) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isOwner ? Icons.shield_rounded : Icons.person_rounded,
          size: AppSizes.iconXs,
          color: isOwner
              ? AppColors.warning
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 3),
        Text(
          isOwner ? 'Propietario' : 'Miembro',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isOwner
                ? AppColors.warning
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: isOwner ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeChip(
    BuildContext context,
    MemberModel member,
    bool isCurrentUser,
  ) {
    if (isCurrentUser) {
      return GestureDetector(
        onTap: () => _showIncomeDialog(context, member),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
            vertical: AppSizes.xs,
          ),
          decoration: BoxDecoration(
            color: member.income != null
                ? AppColors.success.withValues(alpha: 0.1)
                : Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            border: Border.all(
              color: member.income != null
                  ? AppColors.success.withValues(alpha: 0.3)
                  : Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (member.income != null) ...[
                Text(
                  '\$${NumberFormat.decimalPattern('es').format(member.income!.toInt())}',
                  style: TextStyle(
                    fontSize: AppSizes.fontSm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: AppSizes.xs),
                Icon(
                  Icons.edit_rounded,
                  size: 12,
                  color: AppColors.success.withValues(alpha: 0.7),
                ),
              ] else ...[
                Icon(
                  Icons.add_rounded,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 2),
                Text(
                  'Ingreso',
                  style: TextStyle(
                    fontSize: AppSizes.fontSm,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (member.income != null) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.sm,
          vertical: AppSizes.xs,
        ),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        child: Text(
          '\$${NumberFormat.decimalPattern('es').format(member.income!.toInt())}',
          style: TextStyle(
            fontSize: AppSizes.fontSm,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  // ---------------------------------------------------------------------------
  // Split mode card
  // ---------------------------------------------------------------------------

  Widget _buildSplitModeCard(BuildContext context, HouseholdModel household) {
    final isProportional = household.splitMode == 'proportional';

    return _buildCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'División proporcional por ingreso',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Text(
                        isProportional
                            ? 'Quien gana más paga más.'
                            : 'Gastos divididos en partes iguales.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Switch(
                  value: isProportional,
                  onChanged: (value) => _updateSplitMode(
                    household,
                    value ? 'proportional' : 'equal',
                  ),
                  activeTrackColor: AppColors.expenses.withValues(alpha: 0.4),
                  activeThumbColor: AppColors.expenses,
                ),
              ],
            ),
            if (!isProportional) ...[
              const SizedBox(height: AppSizes.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: AppSizes.iconXs,
                      color: AppColors.info,
                    ),
                    const SizedBox(width: AppSizes.xs),
                    Expanded(
                      child: Text(
                        'Activá la división proporcional para que quienes ganen más aporten más.',
                        style: TextStyle(
                          fontSize: AppSizes.fontXs,
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Invite card
  // ---------------------------------------------------------------------------

  Widget _buildInviteCard(
    BuildContext context,
    HouseholdModel household,
    HouseholdInviteModel? activeInvite,
  ) {
    return _buildCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (activeInvite != null) ...[
              // Active code display
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMd,
                  vertical: AppSizes.paddingMd,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.secondary.withValues(alpha: 0.08),
                      AppColors.primary.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Código activo',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSizes.sm),
                    Text(
                      activeInvite.code,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 6,
                        fontSize: AppSizes.fontXxl,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Expira el ${_formatDate(activeInvite.expiresAt)}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _copyInviteCode(activeInvite.code),
                      icon: const Icon(
                        Icons.copy_rounded,
                        size: AppSizes.iconSm,
                      ),
                      label: const Text('Copiar'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, AppSizes.buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMd,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () =>
                          _shareInvite(activeInvite.code, household.name),
                      icon: const Icon(
                        Icons.share_rounded,
                        size: AppSizes.iconSm,
                      ),
                      label: const Text('Compartir'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, AppSizes.buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMd,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              Divider(
                height: 1,
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppSizes.md),
            ],
            // Generate button
            OutlinedButton.icon(
              onPressed: _isGeneratingInvite
                  ? null
                  : () => _generateInvite(household.id),
              icon: _isGeneratingInvite
                  ? const SizedBox(
                      width: AppSizes.iconSm,
                      height: AppSizes.iconSm,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add_link_rounded),
              label: Text(
                activeInvite == null
                    ? 'Generar código de invitación'
                    : 'Generar nuevo código',
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, AppSizes.buttonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
            ),
            if (activeInvite != null) ...[
              const SizedBox(height: AppSizes.xs),
              Text(
                'Generar un nuevo código invalidará el actual.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Danger zone
  // ---------------------------------------------------------------------------

  Widget _buildDangerZone(
    BuildContext context,
    HouseholdModel household,
    UserModel? currentUser,
    bool isOwner,
  ) {
    final showLeave = !isOwner && currentUser != null;
    final showDelete = isOwner;
    // Promote currentUser to non-nullable for use in closures below.
    final nonNullUser = currentUser;

    if (!showLeave && !showDelete) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.paddingMd,
              AppSizes.paddingMd,
              AppSizes.paddingMd,
              AppSizes.paddingSm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.error.withValues(alpha: 0.8),
                ),
                const SizedBox(width: AppSizes.xs),
                Text(
                  'Zona de peligro',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.error.withValues(alpha: 0.8),
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.error.withValues(alpha: 0.15)),
          if (showLeave)
            _buildDangerAction(
              context,
              icon: Icons.exit_to_app_rounded,
              label: 'Abandonar hogar',
              description: 'Perderás acceso a todos los datos compartidos.',
              onTap: () => _showLeaveDialog(context, household, nonNullUser!),
            ),
          if (showDelete)
            _buildDangerAction(
              context,
              icon: Icons.delete_forever_rounded,
              label: 'Eliminar hogar',
              description:
                  'Se borrarán permanentemente todos los datos del hogar. Esta acción no se puede deshacer.',
              onTap: () => _showDeleteDialog(context, household),
            ),
        ],
      ),
    );
  }

  Widget _buildDangerAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Row(
          children: [
            Container(
              width: AppSizes.avatarSm,
              height: AppSizes.avatarSm,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Icon(icon, size: AppSizes.iconSm, color: AppColors.error),
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.error.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: AppSizes.iconMd,
              color: AppColors.error.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared card wrapper
  // ---------------------------------------------------------------------------

  Widget _buildCard({required Widget child}) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        child: child,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dialogs
  // ---------------------------------------------------------------------------

  void _showIncomeDialog(BuildContext context, MemberModel member) {
    final controller = TextEditingController(
      text: member.income?.toStringAsFixed(0) ?? '',
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Actualizar ingreso'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tu ingreso mensual se usa para calcular la división proporcional de gastos.',
            ),
            const SizedBox(height: AppSizes.md),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: AppStrings.income,
                prefixText: '\$ ',
                hintText: '0',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final income = double.tryParse(controller.text) ?? 0;
              Navigator.pop(dialogContext);
              _updateIncome(member, income);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, AppSizes.buttonHeight),
            ),
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  void _showLeaveDialog(
    BuildContext context,
    HouseholdModel household,
    UserModel currentUser,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Abandonar hogar'),
        content: Text(
          '¿Estás seguro que deseas abandonar "${household.name}"? '
          'Ya no tendrás acceso a los datos compartidos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _leaveHousehold(household.id, currentUser.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, AppSizes.buttonHeight),
            ),
            child: const Text('Abandonar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, HouseholdModel household) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar hogar'),
        content: Text(
          '¿Estás seguro que deseas eliminar "${household.name}"? '
          'Se borrarán permanentemente todos los tableros, recetas, menús, '
          'gastos, listas de deseos y eventos del calendario. '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _deleteHousehold(household.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, AppSizes.buttonHeight),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  Future<void> _updateSplitMode(
    HouseholdModel household,
    String splitMode,
  ) async {
    final success = await ref
        .read(householdProvider.notifier)
        .updateHousehold(householdId: household.id, splitMode: splitMode);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? (splitMode == 'proportional'
                      ? 'División proporcional activada'
                      : 'División igualitaria activada')
                : 'Error al actualizar configuración',
          ),
          backgroundColor: success ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _updateIncome(MemberModel member, double income) async {
    final householdState = ref.read(householdProvider);
    if (householdState is HouseholdStateLoaded) {
      final success = await ref
          .read(householdProvider.notifier)
          .updateMember(
            householdId: householdState.household.id,
            userId: member.userId,
            income: income,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Ingreso actualizado' : 'Error al actualizar ingreso',
            ),
            backgroundColor: success ? AppColors.success : AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _updatePaysExpenses(
    MemberModel member,
    bool paysExpenses,
  ) async {
    final householdState = ref.read(householdProvider);
    if (householdState is HouseholdStateLoaded) {
      final success = await ref
          .read(householdProvider.notifier)
          .updateMember(
            householdId: householdState.household.id,
            userId: member.userId,
            paysExpenses: paysExpenses,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Configuración actualizada'
                  : 'Error al actualizar configuración',
            ),
            backgroundColor: success ? AppColors.success : AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _generateInvite(String householdId) async {
    setState(() => _isGeneratingInvite = true);

    final invite = await ref
        .read(activeInviteProvider.notifier)
        .generateInvite(householdId: householdId);

    if (mounted) {
      setState(() => _isGeneratingInvite = false);

      if (invite != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código de invitación generado'),
            backgroundColor: AppColors.success,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al generar código'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _copyInviteCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Código copiado al portapapeles'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _shareInvite(String code, String householdName) async {
    final inviteLink = 'https://nuestra-app.benja.ar/join/$code';
    final message =
        '''
Te invito a unirte a "$householdName" en Nuestra App!

Usa este enlace para unirte:
$inviteLink

O ingresa el código manualmente: $code
''';

    await Share.share(
      message,
      subject: 'Invitación a $householdName - Nuestra App',
    );
  }

  Future<void> _leaveHousehold(String householdId, String userId) async {
    final success = await ref
        .read(householdProvider.notifier)
        .leaveHousehold(householdId: householdId, userId: userId);

    if (mounted) {
      if (success) {
        context.go(AppRoutes.householdSetup);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al abandonar el hogar'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _deleteHousehold(String householdId) async {
    final success = await ref
        .read(householdProvider.notifier)
        .deleteHousehold(householdId: householdId);

    if (mounted) {
      if (success) {
        context.go(AppRoutes.householdSetup);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al eliminar el hogar'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Utilities
  // ---------------------------------------------------------------------------

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Converts a hex color string (e.g. "#667eea" or "667eea") to a [Color].
  Color _colorFromHex(String hex) {
    final sanitized = hex.replaceFirst('#', '');
    final fullHex = sanitized.length == 6 ? 'FF$sanitized' : sanitized;
    return Color(int.tryParse(fullHex, radix: 16) ?? 0xFF6366F1);
  }
}
