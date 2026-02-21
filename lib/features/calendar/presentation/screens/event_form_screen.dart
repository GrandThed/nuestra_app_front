import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/calendar/data/models/calendar_model.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_notifier.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_state.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_notifier.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_state.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';

/// Screen for adding or editing a calendar event
class EventFormScreen extends ConsumerStatefulWidget {
  final String? eventId;
  final DateTime? initialDate;

  const EventFormScreen({
    super.key,
    this.eventId,
    this.initialDate,
  });

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateFormat = DateFormat('EEE, d MMM yyyy', 'es');
  final _timeFormat = DateFormat('HH:mm', 'es');

  late DateTime _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;
  bool _allDay = false;
  RecurrenceType _recurrence = RecurrenceType.none;
  DateTime? _recurrenceEndDate;
  bool _isSubmitting = false;
  bool _isInitialized = false;
  String? _linkedBoardId;
  String? _linkedRecipeId;
  String? _linkedMenuPlanId;

  bool get isEditing => widget.eventId != null;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialDate ?? DateTime.now();
    _startTime = TimeOfDay.now();
    // Load data for linked item selectors
    Future.microtask(() {
      ref.read(boardsProvider.notifier).loadBoardsIfNeeded();
      ref.read(recipesProvider.notifier).loadRecipesIfNeeded();
      ref.read(menuPlansProvider.notifier).loadMenuPlansIfNeeded();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initializeWithEvent(CalendarEventModel event) {
    if (_isInitialized) return;
    _isInitialized = true;

    _titleController.text = event.title;
    _descriptionController.text = event.description ?? '';
    _startDate = event.startDate;
    _startTime = TimeOfDay.fromDateTime(event.startDate);
    _endDate = event.endDate;
    if (event.endDate != null) {
      _endTime = TimeOfDay.fromDateTime(event.endDate!);
    }
    _allDay = event.allDay;
    _recurrence = event.recurrence;
    _recurrenceEndDate = event.recurrenceEndDate;
    _linkedBoardId = event.linkedBoard?.id;
    _linkedRecipeId = event.linkedRecipe?.id;
    _linkedMenuPlanId = event.linkedMenuPlan?.id;
  }

  CalendarEventModel? _getEvent() {
    if (widget.eventId == null) return null;
    final state = ref.read(calendarProvider);
    if (state is CalendarStateLoaded) {
      try {
        return state.events.firstWhere((e) => e.id == widget.eventId);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> _selectStartDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (result != null) {
      setState(() {
        _startDate = result;
        if (_endDate != null && _endDate!.isBefore(_startDate)) {
          _endDate = _startDate;
        }
      });
    }
  }

  Future<void> _selectStartTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (result != null) {
      setState(() {
        _startTime = result;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate,
      firstDate: _startDate,
      lastDate: DateTime(2030),
    );
    if (result != null) {
      setState(() {
        _endDate = result;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _endTime ?? _startTime ?? TimeOfDay.now(),
    );
    if (result != null) {
      setState(() {
        _endTime = result;
      });
    }
  }

  Future<void> _selectRecurrenceEndDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _recurrenceEndDate ?? _startDate.add(const Duration(days: 30)),
      firstDate: _startDate,
      lastDate: DateTime(2030),
    );
    if (result != null) {
      setState(() {
        _recurrenceEndDate = result;
      });
    }
  }

  DateTime _combineDateTime(DateTime date, TimeOfDay? time) {
    if (time == null) {
      return DateTime(date.year, date.month, date.day);
    }
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final startDateTime = _allDay
        ? DateTime(_startDate.year, _startDate.month, _startDate.day)
        : _combineDateTime(_startDate, _startTime);

    DateTime? endDateTime;
    if (_endDate != null) {
      endDateTime = _allDay
          ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59)
          : _combineDateTime(_endDate!, _endTime);
    }

    final notifier = ref.read(calendarProvider.notifier);
    dynamic result;

    if (isEditing) {
      result = await notifier.updateEvent(
        id: widget.eventId!,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        startDate: startDateTime,
        endDate: endDateTime,
        allDay: _allDay,
        recurrence: _recurrence,
        recurrenceEndDate: _recurrenceEndDate,
        linkedBoardId: _linkedBoardId,
        linkedRecipeId: _linkedRecipeId,
        linkedMenuPlanId: _linkedMenuPlanId,
      );
    } else {
      result = await notifier.createEvent(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        startDate: startDateTime,
        endDate: endDateTime,
        allDay: _allDay,
        recurrence: _recurrence,
        recurrenceEndDate: _recurrenceEndDate,
        linkedBoardId: _linkedBoardId,
        linkedRecipeId: _linkedRecipeId,
        linkedMenuPlanId: _linkedMenuPlanId,
      );
    }

    setState(() => _isSubmitting = false);

    if (mounted && result != null) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? 'Evento actualizado' : 'Evento creado'),
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing ? 'Error al actualizar evento' : 'Error al crear evento',
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Initialize with existing event data if editing
    if (isEditing) {
      final event = _getEvent();
      if (event != null) {
        _initializeWithEvent(event);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar evento' : 'Nuevo evento'),
        backgroundColor: AppColors.calendar,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.lg),
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
                hintText: 'Ej: Cita con el medico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ingresa un titulo';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSizes.lg),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripcion (opcional)',
                hintText: 'Detalles adicionales...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
            const SizedBox(height: AppSizes.lg),

            // All day toggle
            Card(
              child: SwitchListTile(
                title: const Text('Todo el dia'),
                subtitle: const Text('Sin hora de inicio/fin'),
                value: _allDay,
                onChanged: (value) {
                  setState(() {
                    _allDay = value;
                  });
                },
              ),
            ),
            const SizedBox(height: AppSizes.md),

            // Start date/time
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Fecha de inicio'),
                    subtitle: Text(_dateFormat.format(_startDate)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _selectStartDate,
                  ),
                  if (!_allDay) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Hora de inicio'),
                      subtitle: Text(_startTime != null
                          ? _timeFormat.format(_combineDateTime(_startDate, _startTime))
                          : 'Sin definir'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _selectStartTime,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSizes.md),

            // End date/time (optional)
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.event),
                    title: const Text('Fecha de fin (opcional)'),
                    subtitle: Text(_endDate != null
                        ? _dateFormat.format(_endDate!)
                        : 'Sin definir'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_endDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() {
                              _endDate = null;
                              _endTime = null;
                            }),
                          ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: _selectEndDate,
                  ),
                  if (!_allDay && _endDate != null) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Hora de fin'),
                      subtitle: Text(_endTime != null
                          ? _timeFormat.format(_combineDateTime(_endDate!, _endTime))
                          : 'Sin definir'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _selectEndTime,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSizes.lg),

            // Recurrence
            Text(
              'Repeticion',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<RecurrenceType>(
                      initialValue: _recurrence,
                      decoration: const InputDecoration(
                        labelText: 'Frecuencia',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.repeat),
                      ),
                      items: RecurrenceType.values.map((type) {
                        return DropdownMenuItem<RecurrenceType>(
                          value: type,
                          child: Text(_getRecurrenceLabel(type)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _recurrence = value!;
                          if (_recurrence == RecurrenceType.none) {
                            _recurrenceEndDate = null;
                          }
                        });
                      },
                    ),
                    if (_recurrence != RecurrenceType.none) ...[
                      const SizedBox(height: AppSizes.md),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.event_busy),
                        title: const Text('Repetir hasta'),
                        subtitle: Text(_recurrenceEndDate != null
                            ? _dateFormat.format(_recurrenceEndDate!)
                            : 'Sin limite'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_recurrenceEndDate != null)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => setState(() {
                                  _recurrenceEndDate = null;
                                }),
                              ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: _selectRecurrenceEndDate,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.lg),

            // Linked items
            Text(
              'Vincular con',
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
                    // Board selector
                    _buildLinkedBoardSelector(),
                    const Divider(),
                    // Recipe selector
                    _buildLinkedRecipeSelector(),
                    const Divider(),
                    // Menu plan selector
                    _buildLinkedMenuPlanSelector(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedBoardSelector() {
    final boardsState = ref.watch(boardsProvider);
    final boards = boardsState is BoardsStateLoaded ? boardsState.boards : [];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.dashboard_outlined, color: AppColors.boards),
      title: const Text('Tablero'),
      trailing: DropdownButton<String?>(
        value: _linkedBoardId,
        hint: const Text('Ninguno'),
        underline: const SizedBox(),
        onChanged: (value) => setState(() => _linkedBoardId = value),
        items: [
          const DropdownMenuItem<String?>(value: null, child: Text('Ninguno')),
          ...boards.map((b) => DropdownMenuItem<String?>(
                value: b.id,
                child: Text(b.name, overflow: TextOverflow.ellipsis),
              )),
        ],
      ),
    );
  }

  Widget _buildLinkedRecipeSelector() {
    final recipesState = ref.watch(recipesProvider);
    final recipes = recipesState is RecipesStateLoaded ? recipesState.recipes : [];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.restaurant_menu, color: AppColors.recipes),
      title: const Text('Receta'),
      trailing: DropdownButton<String?>(
        value: _linkedRecipeId,
        hint: const Text('Ninguna'),
        underline: const SizedBox(),
        onChanged: (value) => setState(() => _linkedRecipeId = value),
        items: [
          const DropdownMenuItem<String?>(value: null, child: Text('Ninguna')),
          ...recipes.map((r) => DropdownMenuItem<String?>(
                value: r.id,
                child: Text(r.title, overflow: TextOverflow.ellipsis),
              )),
        ],
      ),
    );
  }

  Widget _buildLinkedMenuPlanSelector() {
    final plansState = ref.watch(menuPlansProvider);
    final plans = plansState is MenuPlansStateLoaded ? plansState.plans : [];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.calendar_view_week, color: AppColors.menus),
      title: const Text('Plan de menu'),
      trailing: DropdownButton<String?>(
        value: _linkedMenuPlanId,
        hint: const Text('Ninguno'),
        underline: const SizedBox(),
        onChanged: (value) => setState(() => _linkedMenuPlanId = value),
        items: [
          const DropdownMenuItem<String?>(value: null, child: Text('Ninguno')),
          ...plans.map((p) => DropdownMenuItem<String?>(
                value: p.id,
                child: Text(p.name ?? 'Sin nombre', overflow: TextOverflow.ellipsis),
              )),
        ],
      ),
    );
  }

  String _getRecurrenceLabel(RecurrenceType type) {
    return switch (type) {
      RecurrenceType.none => 'Sin repeticion',
      RecurrenceType.daily => 'Diario',
      RecurrenceType.weekly => 'Semanal',
      RecurrenceType.monthly => 'Mensual',
      RecurrenceType.yearly => 'Anual',
    };
  }
}
