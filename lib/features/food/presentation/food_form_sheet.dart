import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:a2ui_flutter/basic_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/food/forms/food_form_handler.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';

typedef FormBuild = List<Map<String, Object?>> Function(String surfaceId);

/// Show a food form (the same A2UI forms the assistant uses) in a bottom
/// sheet. Handles its actions, chains follow-up forms, opens recipes and
/// refreshes what changed. Returns the last outcome (null if dismissed).
Future<FormOutcome?> showFoodFormSheet(BuildContext context, WidgetRef ref, FormBuild build) async {
  final outcome = await showModalBottomSheet<FormOutcome>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _FoodFormSheet(build: build),
  );
  if (outcome == null || !context.mounted) return outcome;
  refreshFood(ref.invalidate, outcome.changed);
  final recipe = outcome.openRecipe;
  if (recipe != null) {
    context.push(Uri(
      path: '/food/recipes/${recipe.slug}',
      queryParameters: recipe.servings == null ? null : {'servings': '${recipe.servings}'},
    ).toString());
  } else if (outcome.done) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(outcome.summary)));
  }
  return outcome;
}

class _FoodFormSheet extends ConsumerStatefulWidget {
  final FormBuild build;

  const _FoodFormSheet({required this.build});

  @override
  ConsumerState<_FoodFormSheet> createState() => _FoodFormSheetState();
}

class _FoodFormSheetState extends ConsumerState<_FoodFormSheet> {
  late final MessageProcessor<ComponentImplementation> _renderer;
  SurfaceModel<ComponentImplementation>? _surface;
  final List<Subscription> _subs = [];
  int _count = 0;
  bool _busy = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _renderer = MessageProcessor<ComponentImplementation>(
      catalogs: [basicCatalog(locale: 'es-AR')],
      defaultVersion: A2uiProtocolVersion.v1_0,
    );
    _subs
      ..add(_renderer.model.onSurfaceCreated.subscribe((s) => setState(() => _surface = s)))
      ..add(_renderer.model.onAction.subscribe(_onAction));
    _show(widget.build);
  }

  void _show(FormBuild build) {
    final old = _surface;
    if (old != null) _renderer.model.deleteSurface(old.id);
    _renderer.processMessages(build('form-${++_count}'));
  }

  Future<void> _onAction(A2uiRendererAction action) async {
    if (_busy) return;
    if (!FoodFormHandler.handles(action.name)) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    final outcome = await ref.read(foodFormHandlerProvider).handle(action);
    if (!mounted) return;
    setState(() => _busy = false);
    refreshFood(ref.invalidate, outcome.changed);
    if (outcome.next != null) {
      setState(() => _message = outcome.summary);
      _show(outcome.next!);
      return;
    }
    if (!outcome.done && action.name != 'form.cancelar') {
      // Keep the form open so it can be corrected
      setState(() => _message = outcome.summary);
      return;
    }
    Navigator.of(context).pop(outcome.done ? outcome : null);
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.unsubscribe();
    }
    _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surface = _surface;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.sm),
                child: Text(_message!, style: Theme.of(context).textTheme.bodySmall),
              ),
            if (_busy) const LinearProgressIndicator(),
            if (surface != null)
              AbsorbPointer(
                absorbing: _busy,
                child: A2uiSurface(key: ObjectKey(surface), surface: surface),
              ),
          ],
        ),
      ),
    );
  }
}
