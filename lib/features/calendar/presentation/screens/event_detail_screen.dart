import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/calendar/data/models/calendar_model.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_notifier.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_state.dart';

/// Screen for viewing and managing event details
class EventDetailScreen extends ConsumerStatefulWidget {
  final String eventId;

  const EventDetailScreen({
    super.key,
    required this.eventId,
  });

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  final _dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es');
  final _timeFormat = DateFormat('HH:mm', 'es');

  CalendarEventModel? _getEvent() {
    final state = ref.read(calendarNotifierProvider);
    if (state is CalendarStateLoaded) {
      try {
        return state.events.firstWhere((e) => e.id == widget.eventId);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> _deleteEvent(CalendarEventModel event) async {
    // Check if this is a recurring event
    if (event.recurrence != RecurrenceType.none || event.isOccurrence) {
      final deleteOption = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar evento'),
          content: const Text('Este es un evento recurrente. ¿Que deseas eliminar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'this'),
              child: const Text('Solo este'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'all'),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Todos'),
            ),
          ],
        ),
      );

      if (deleteOption == null) return;

      final success = await ref.read(calendarNotifierProvider.notifier).deleteEvent(
            widget.eventId,
            deleteRecurring: deleteOption,
            occurrenceDate: event.occurrenceDate,
          );

      if (mounted && success) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento eliminado')),
        );
      }
    } else {
      // Non-recurring event
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar evento'),
          content: Text('¿Eliminar "${event.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final success = await ref.read(calendarNotifierProvider.notifier).deleteEvent(
              widget.eventId,
            );

        if (mounted && success) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Evento eliminado')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes
    ref.watch(calendarNotifierProvider);
    final event = _getEvent();
    final colorScheme = Theme.of(context).colorScheme;

    if (event == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de evento'),
          backgroundColor: AppColors.calendar,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Evento no encontrado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de evento'),
        backgroundColor: AppColors.calendar,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Eliminar',
            onPressed: () => _deleteEvent(event),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lg),
        children: [
          // Title card
          Card(
            color: AppColors.calendar.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.xl),
              child: Column(
                children: [
                  Icon(
                    _getEventIcon(event),
                    size: 48,
                    color: AppColors.calendar,
                  ),
                  const SizedBox(height: AppSizes.md),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (event.description != null &&
                      event.description!.isNotEmpty) ...[
                    const SizedBox(height: AppSizes.sm),
                    Text(
                      event.description!,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),

          // Date/time info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.calendar_today,
                    label: 'Fecha',
                    value: _dateFormat.format(event.occurrenceDate ?? event.startDate),
                  ),
                  if (!event.allDay) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.access_time,
                      label: 'Hora',
                      value: _timeFormat.format(event.startDate),
                    ),
                  ],
                  if (event.endDate != null) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.event,
                      label: 'Termina',
                      value: event.allDay
                          ? _dateFormat.format(event.endDate!)
                          : '${_dateFormat.format(event.endDate!)} ${_timeFormat.format(event.endDate!)}',
                    ),
                  ],
                  if (event.allDay) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.wb_sunny_outlined,
                      label: 'Duracion',
                      value: 'Todo el dia',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),

          // Recurrence info
          if (event.recurrence != RecurrenceType.none) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.repeat,
                      label: 'Repeticion',
                      value: _getRecurrenceLabel(event.recurrence),
                    ),
                    if (event.recurrenceEndDate != null) ...[
                      const Divider(),
                      _InfoRow(
                        icon: Icons.event_busy,
                        label: 'Hasta',
                        value: _dateFormat.format(event.recurrenceEndDate!),
                      ),
                    ],
                    if (event.isOccurrence) ...[
                      const Divider(),
                      _InfoRow(
                        icon: Icons.info_outline,
                        label: 'Nota',
                        value: 'Esta es una ocurrencia del evento',
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],

          // Linked items
          if (event.linkedBoard != null ||
              event.linkedRecipe != null ||
              event.linkedMenuPlan != null) ...[
            Text(
              'Vinculado a',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  children: [
                    if (event.linkedRecipe != null) ...[
                      _LinkedItemRow(
                        icon: Icons.restaurant,
                        label: 'Receta',
                        value: event.linkedRecipe!.title,
                        color: AppColors.recipes,
                      ),
                    ],
                    if (event.linkedBoard != null) ...[
                      if (event.linkedRecipe != null) const Divider(),
                      _LinkedItemRow(
                        icon: Icons.dashboard,
                        label: 'Tablero',
                        value: event.linkedBoard!.name,
                        color: AppColors.boards,
                      ),
                    ],
                    if (event.linkedMenuPlan != null) ...[
                      if (event.linkedRecipe != null || event.linkedBoard != null)
                        const Divider(),
                      _LinkedItemRow(
                        icon: Icons.calendar_view_week,
                        label: 'Menu',
                        value: event.linkedMenuPlan!.name,
                        color: AppColors.menus,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],

          // Created by
          if (event.createdBy != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: _InfoRow(
                  icon: Icons.person,
                  label: 'Creado por',
                  value: event.createdBy!.name,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getEventIcon(CalendarEventModel event) {
    if (event.linkedRecipe != null) return Icons.restaurant;
    if (event.linkedBoard != null) return Icons.dashboard;
    if (event.linkedMenuPlan != null) return Icons.calendar_view_week;
    if (event.recurrence != RecurrenceType.none) return Icons.repeat;
    return Icons.event;
  }

  String _getRecurrenceLabel(RecurrenceType recurrence) {
    return switch (recurrence) {
      RecurrenceType.daily => 'Diario',
      RecurrenceType.weekly => 'Semanal',
      RecurrenceType.monthly => 'Mensual',
      RecurrenceType.yearly => 'Anual',
      RecurrenceType.none => 'Sin repeticion',
    };
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSizes.md),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkedItemRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _LinkedItemRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: AppSizes.md),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
