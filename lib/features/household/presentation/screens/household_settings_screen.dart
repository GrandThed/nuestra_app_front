import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  HouseholdInviteModel? _currentInvite;
  bool _isGeneratingInvite = false;

  @override
  void initState() {
    super.initState();
    _loadHousehold();
  }

  void _loadHousehold() {
    final authState = ref.read(authNotifierProvider);
    if (authState is AuthStateAuthenticated) {
      final householdId = authState.user.households?.firstOrNull?.id;
      if (householdId != null) {
        ref.read(householdNotifierProvider.notifier).loadHousehold(householdId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final householdState = ref.watch(householdNotifierProvider);

    final currentUser = authState is AuthStateAuthenticated ? authState.user : null;
    final household =
        householdState is HouseholdStateLoaded ? householdState.household : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración del Hogar'),
      ),
      body: householdState is HouseholdStateLoading
          ? const Center(child: CircularProgressIndicator())
          : householdState is HouseholdStateError
              ? _buildErrorState(householdState.message)
              : household != null
                  ? _buildContent(context, household, currentUser)
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
            onPressed: _loadHousehold,
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
  ) {
    final isOwner = household.members?.any(
          (m) => m.id == currentUser?.id && m.role == 'owner',
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
                  'Hemisferio: ${household.hemisphere == 'southern' ? 'Sur' : 'Norte'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_currentInvite != null) ...[
                    Text(
                      'Código de invitación:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.md,
                              vertical: AppSizes.sm,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusSm),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              _currentInvite!.code,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.sm),
                        IconButton(
                          onPressed: () => _copyInviteCode(_currentInvite!.code),
                          icon: const Icon(Icons.copy),
                          tooltip: 'Copiar código',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      'Expira: ${_formatDate(_currentInvite!.expiresAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: AppSizes.md),
                  ],
                  ElevatedButton.icon(
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
                    label: Text(_currentInvite == null
                        ? 'Generar código de invitación'
                        : 'Generar nuevo código'),
                  ),
                ],
              ),
            ),
          ),
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
      ],
    );
  }

  Widget _buildMemberTile(
    BuildContext context,
    MemberModel member,
    UserModel? currentUser,
  ) {
    final isCurrentUser = member.id == currentUser?.id;

    return ListTile(
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
            const Padding(
              padding: EdgeInsets.only(left: AppSizes.xs),
              child: Text('(tú)', style: TextStyle(color: AppColors.textSecondary)),
            ),
        ],
      ),
      subtitle: Text(member.role == 'owner' ? 'Propietario' : 'Miembro'),
      trailing: isCurrentUser
          ? TextButton(
              onPressed: () => _showIncomeDialog(context, member),
              child: Text(
                member.income != null
                    ? '\$${member.income!.toStringAsFixed(0)}'
                    : 'Agregar ingreso',
              ),
            )
          : member.income != null
              ? Text('\$${member.income!.toStringAsFixed(0)}')
              : null,
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
          await ref.read(householdNotifierProvider.notifier).updateMemberIncome(
                householdId: householdState.household.id,
                userId: member.id,
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

  Future<void> _generateInvite(String householdId) async {
    setState(() => _isGeneratingInvite = true);

    final invite =
        await ref.read(householdNotifierProvider.notifier).generateInvite(
              householdId: householdId,
            );

    if (mounted) {
      setState(() {
        _isGeneratingInvite = false;
        _currentInvite = invite;
      });

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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
