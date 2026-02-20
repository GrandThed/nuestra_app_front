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
    final authState = ref.read(authNotifierProvider);
    if (authState is AuthStateAuthenticated) {
      final householdId = authState.user.households?.firstOrNull?.id;
      if (householdId != null) {
        ref
            .read(householdNotifierProvider.notifier)
            .loadHouseholdIfNeeded(householdId);
        ref
            .read(activeInviteNotifierProvider.notifier)
            .loadActiveInviteIfNeeded(householdId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final householdState = ref.watch(householdNotifierProvider);
    final inviteState = ref.watch(activeInviteNotifierProvider);

    final currentUser =
        authState is AuthStateAuthenticated ? authState.user : null;
    final household =
        householdState is HouseholdStateLoaded ? householdState.household : null;
    final activeInvite =
        inviteState is ActiveInviteStateLoaded ? inviteState.invite : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración del Hogar'),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: AppSizes.md),
          Text(message),
          const SizedBox(height: AppSizes.md),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    HouseholdModel household,
    UserModel? currentUser,
    HouseholdInviteModel? activeInvite,
  ) {
    final isOwner = household.members?.any(
          (m) => m.userId == currentUser?.id && m.role == 'owner',
        ) ??
        false;

    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      children: [
        // Household info card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.home, color: AppColors.primary),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Text(
                        household.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  'Hemisferio: ${household.hemisphere == 'south' ? 'Sur' : 'Norte'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.lg),

        // Members section
        Text(
          AppStrings.members,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: AppSizes.sm),
        Card(
          child: Column(
            children: [
              if (household.members != null)
                ...household.members!.map(
                  (member) => _buildMemberTile(context, member, currentUser),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.lg),

        // Invite section (only for owners)
        if (isOwner) ...[
          Text(
            'Invitar miembros',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSizes.sm),
          _buildInviteCard(context, household, activeInvite),
          const SizedBox(height: AppSizes.lg),
        ],

        // Leave household (only for non-owners)
        if (!isOwner && currentUser != null) ...[
          const Divider(),
          const SizedBox(height: AppSizes.md),
          OutlinedButton.icon(
            onPressed: () => _showLeaveDialog(context, household, currentUser),
            icon: const Icon(Icons.exit_to_app, color: AppColors.error),
            label: const Text('Abandonar hogar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
          ),
        ],

        // Delete household (only for owners)
        if (isOwner) ...[
          const Divider(),
          const SizedBox(height: AppSizes.md),
          TextButton.icon(
            onPressed: () => _showDeleteDialog(context, household),
            icon: const Icon(Icons.delete_forever),
            label: const Text('Eliminar hogar'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInviteCard(
    BuildContext context,
    HouseholdModel household,
    HouseholdInviteModel? activeInvite,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (activeInvite != null) ...[
              Text(
                'Código de invitación activo:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: AppSizes.sm),
              // Code display
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      activeInvite.code,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: AppColors.primary,
                          ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      'Expira: ${_formatDate(activeInvite.expiresAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
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
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copiar'),
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _shareInvite(activeInvite.code, household.name),
                      icon: const Icon(Icons.share, size: 18),
                      label: const Text('Compartir'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              const Divider(),
              const SizedBox(height: AppSizes.sm),
            ],
            // Generate button
            OutlinedButton.icon(
              onPressed: _isGeneratingInvite
                  ? null
                  : () => _generateInvite(household.id),
              icon: _isGeneratingInvite
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add_link),
              label: Text(activeInvite == null
                  ? 'Generar código de invitación'
                  : 'Generar nuevo código'),
            ),
            if (activeInvite != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.xs),
                child: Text(
                  'Generar un nuevo código invalidará el actual',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile(
    BuildContext context,
    MemberModel member,
    UserModel? currentUser,
  ) {
    final isCurrentUser = member.userId == currentUser?.id;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryLight,
              child: Text(
                member.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Row(
              children: [
                Text(member.name),
                if (isCurrentUser)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSizes.xs),
                    child: Text(
                      '(tú)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Text(member.role == 'owner' ? 'Propietario' : 'Miembro'),
            trailing: isCurrentUser
                ? TextButton(
                    onPressed: () => _showIncomeDialog(context, member),
                    child: Text(
                      member.income != null
                          ? '\$${NumberFormat.decimalPattern('es').format(member.income!.toInt())}'
                          : 'Agregar ingreso',
                    ),
                  )
                : member.income != null
                    ? Text('\$${NumberFormat.decimalPattern('es').format(member.income!.toInt())}')
                    : null,
          ),
          // Pays expenses toggle (only for current user)
          if (isCurrentUser)
            Padding(
              padding: const EdgeInsets.only(left: 72, right: AppSizes.md),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Responsable de pagar gastos',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  Switch(
                    value: member.paysExpenses,
                    onChanged: (value) => _updatePaysExpenses(member, value),
                    activeTrackColor: AppColors.expenses.withValues(alpha: 0.5),
                    activeThumbColor: AppColors.expenses,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

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

  Future<void> _updateIncome(MemberModel member, double income) async {
    final householdState = ref.read(householdNotifierProvider);
    if (householdState is HouseholdStateLoaded) {
      final success =
          await ref.read(householdNotifierProvider.notifier).updateMember(
                householdId: householdState.household.id,
                userId: member.userId,
                income: income,
              );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                success ? 'Ingreso actualizado' : 'Error al actualizar ingreso'),
            backgroundColor: success ? AppColors.success : AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _updatePaysExpenses(MemberModel member, bool paysExpenses) async {
    final householdState = ref.read(householdNotifierProvider);
    if (householdState is HouseholdStateLoaded) {
      final success =
          await ref.read(householdNotifierProvider.notifier).updateMember(
                householdId: householdState.household.id,
                userId: member.userId,
                paysExpenses: paysExpenses,
              );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                success ? 'Configuración actualizada' : 'Error al actualizar configuración'),
            backgroundColor: success ? AppColors.success : AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _generateInvite(String householdId) async {
    setState(() => _isGeneratingInvite = true);

    final invite =
        await ref.read(activeInviteNotifierProvider.notifier).generateInvite(
              householdId: householdId,
            );

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
    final message = '''
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

  Future<void> _leaveHousehold(String householdId, String userId) async {
    final success =
        await ref.read(householdNotifierProvider.notifier).leaveHousehold(
              householdId: householdId,
              userId: userId,
            );

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

  Future<void> _deleteHousehold(String householdId) async {
    final success =
        await ref.read(householdNotifierProvider.notifier).deleteHousehold(
              householdId: householdId,
            );

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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
