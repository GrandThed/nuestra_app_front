import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/calendar/data/models/calendar_model.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_notifier.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_state.dart';

/// Calendar screen - Unified timeline and calendar
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  final _dateFormat = DateFormat('EEEE, d MMMM', 'es');
  final _timeFormat = DateFormat('HH:mm', 'es');

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(calendarNotifierProvider.notifier).loadEventsIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.calendar),
        backgroundColor: AppColors.calendar,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: 'Ir a hoy',
            onPressed: () {
              ref.read(calendarNotifierProvider.notifier).goToToday();
            },
          ),
          if (state is CalendarStateLoaded)
            IconButton(
              icon: Icon(
                state.viewMode == CalendarViewMode.month
                    ? Icons.view_agenda_outlined
                    : Icons.calendar_month_outlined,
              ),
              tooltip: state.viewMode == CalendarViewMode.month
                  ? 'Ver timeline'
                  : 'Ver calendario',
              onPressed: () {
                ref.read(calendarNotifierProvider.notifier).setViewMode(
                      state.viewMode == CalendarViewMode.month
                          ? CalendarViewMode.timeline
                          : CalendarViewMode.month,
                    );
              },
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'logout') {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Cerrar sesion'),
                    content:
                        const Text('¿Estas seguro que deseas cerrar sesion?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(AppStrings.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(
                          AppStrings.signOut,
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                );
                if (shouldLogout == true) {
                  await ref.read(authNotifierProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go(AppRoutes.login);
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Cerrar sesion'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: switch (state) {
        CalendarStateInitial() ||
        CalendarStateLoading() =>
          const Center(child: CircularProgressIndicator()),
        CalendarStateError(message: final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                const SizedBox(height: AppSizes.md),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: AppSizes.md),
                FilledButton.icon(
                  onPressed: () => ref
                      .read(calendarNotifierProvider.notifier)
                      .loadEvents(forceLoading: true),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        CalendarStateLoaded(
          events: final events,
          selectedDate: final selectedDate,
          focusedMonth: final focusedMonth,
          viewMode: final viewMode,
        ) =>
          viewMode == CalendarViewMode.month
              ? _buildMonthView(events, selectedDate, focusedMonth, colorScheme)
              : _buildTimelineView(events, colorScheme),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addEvent),
        backgroundColor: AppColors.calendar,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMonthView(
    List<CalendarEventModel> events,
    DateTime selectedDate,
    DateTime focusedMonth,
    ColorScheme colorScheme,
  ) {
    // Get events for selected date
    final selectedDateEvents = events.where((e) {
      final eventDate = e.occurrenceDate ?? e.startDate;
      return eventDate.year == selectedDate.year &&
          eventDate.month == selectedDate.month &&
          eventDate.day == selectedDate.day;
    }).toList();

    // Create event map for markers
    final eventMap = <DateTime, List<CalendarEventModel>>{};
    for (final event in events) {
      final eventDate = event.occurrenceDate ?? event.startDate;
      final day = DateTime(eventDate.year, eventDate.month, eventDate.day);
      eventMap[day] = [...(eventMap[day] ?? []), event];
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(calendarNotifierProvider.notifier).loadEvents(),
      child: Column(
        children: [
          TableCalendar<CalendarEventModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedMonth,
            selectedDayPredicate: (day) => isSameDay(selectedDate, day),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            locale: 'es_ES',
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: colorScheme.onSurface,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: colorScheme.onSurface,
              ),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.calendar.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.calendar,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              markerDecoration: const BoxDecoration(
                color: AppColors.calendar,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3,
              markerSize: 6,
              markerMargin: const EdgeInsets.symmetric(horizontal: 1),
            ),
            eventLoader: (day) {
              final dateKey = DateTime(day.year, day.month, day.day);
              return eventMap[dateKey] ?? [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              ref.read(calendarNotifierProvider.notifier).setSelectedDate(
                    selectedDay,
                  );
            },
            onPageChanged: (focusedDay) {
              ref.read(calendarNotifierProvider.notifier).setFocusedMonth(
                    focusedDay,
                  );
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: selectedDateEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 48,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          'Sin eventos para este dia',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
                    itemCount: selectedDateEvents.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.lg,
                            vertical: AppSizes.sm,
                          ),
                          child: Text(
                            _dateFormat.format(selectedDate),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }
                      final event = selectedDateEvents[index - 1];
                      return _EventTile(
                        event: event,
                        timeFormat: _timeFormat,
                        onTap: () => context.push(
                          AppRoutes.eventDetail(event.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineView(
    List<CalendarEventModel> events,
    ColorScheme colorScheme,
  ) {
    // Sort events by date
    final sortedEvents = [...events]
      ..sort((a, b) {
        final dateA = a.occurrenceDate ?? a.startDate;
        final dateB = b.occurrenceDate ?? b.startDate;
        return dateA.compareTo(dateB);
      });

    // Group events by date
    final groupedEvents = <DateTime, List<CalendarEventModel>>{};
    for (final event in sortedEvents) {
      final eventDate = event.occurrenceDate ?? event.startDate;
      final day = DateTime(eventDate.year, eventDate.month, eventDate.day);
      groupedEvents[day] = [...(groupedEvents[day] ?? []), event];
    }

    final sortedDays = groupedEvents.keys.toList()..sort();

    if (sortedDays.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 64,
              color: AppColors.calendar,
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              AppStrings.emptyEvents,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSizes.sm),
            const Text('Agrega tu primer evento'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(calendarNotifierProvider.notifier).loadEvents(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        itemCount: sortedDays.length,
        itemBuilder: (context, index) {
          final day = sortedDays[index];
          final dayEvents = groupedEvents[day]!;
          final isToday = isSameDay(day, DateTime.now());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.lg,
                  vertical: AppSizes.sm,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isToday
                            ? AppColors.calendar
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _dateFormat.format(day),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isToday
                              ? Colors.white
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: AppSizes.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.calendar.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Hoy',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.calendar,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Events for this day
              ...dayEvents.map((event) => _EventTile(
                    event: event,
                    timeFormat: _timeFormat,
                    onTap: () => context.push(
                      AppRoutes.eventDetail(event.id),
                    ),
                  )),
              const SizedBox(height: AppSizes.sm),
            ],
          );
        },
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final CalendarEventModel event;
  final DateFormat timeFormat;
  final VoidCallback onTap;

  const _EventTile({
    required this.event,
    required this.timeFormat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasLinks = event.linkedBoard != null ||
        event.linkedRecipe != null ||
        event.linkedMenuPlan != null;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.xs,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              // Time or all-day indicator
              Container(
                width: 56,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.calendar.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event.allDay
                      ? 'Todo\nel dia'
                      : timeFormat.format(event.startDate),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.calendar,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              // Event details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    if (event.description != null &&
                        event.description!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        event.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (hasLinks || event.recurrence != RecurrenceType.none) ...[
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        children: [
                          if (event.recurrence != RecurrenceType.none)
                            _buildChip(
                              Icons.repeat,
                              _getRecurrenceLabel(event.recurrence),
                              colorScheme,
                            ),
                          if (event.linkedRecipe != null)
                            _buildChip(
                              Icons.restaurant,
                              event.linkedRecipe!.title,
                              colorScheme,
                            ),
                          if (event.linkedBoard != null)
                            _buildChip(
                              Icons.dashboard,
                              event.linkedBoard!.name,
                              colorScheme,
                            ),
                          if (event.linkedMenuPlan != null)
                            _buildChip(
                              Icons.calendar_view_week,
                              event.linkedMenuPlan!.name,
                              colorScheme,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String label, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label.length > 15 ? '${label.substring(0, 15)}...' : label,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _getRecurrenceLabel(RecurrenceType recurrence) {
    return switch (recurrence) {
      RecurrenceType.daily => 'Diario',
      RecurrenceType.weekly => 'Semanal',
      RecurrenceType.monthly => 'Mensual',
      RecurrenceType.yearly => 'Anual',
      RecurrenceType.none => '',
    };
  }
}
