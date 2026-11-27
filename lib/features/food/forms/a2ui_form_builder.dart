import 'package:a2ui_core/a2ui_core.dart';

/// Builds A2UI v1.0 forms in code (the app writes them, not the model), so
/// every form is valid by construction and reviewed like any other code.
///
/// Values are bound to the surface data model with `{"@path": "/f/<name>"}`;
/// the submit button sends them in its action context. Text inputs always
/// come back as strings, choice pickers as lists of strings, sliders as
/// numbers, check boxes as booleans.
class A2uiFormBuilder {
  final String surfaceId;
  final List<Map<String, Object?>> _components = [];
  final Map<String, Object?> _data = {};
  final List<String> _children = [];
  int _next = 0;

  A2uiFormBuilder(this.surfaceId);

  String _id(String kind) => '${kind}_${_next++}';

  static Map<String, Object?> bind(String name) => {'@path': '/f/$name'};

  /// A heading line (rendered as a title).
  A2uiFormBuilder title(String text) => _add({'component': 'Text', 'text': '### $text'});

  A2uiFormBuilder text(String text, {bool caption = false}) =>
      _add({'component': 'Text', 'text': text, 'variant': caption ? 'caption' : 'body'});

  A2uiFormBuilder divider() => _add({'component': 'Divider'});

  /// Single or multiple choice. [options] maps value -> label.
  A2uiFormBuilder choice(
    String name,
    String label,
    Map<String, String> options, {
    bool multiple = false,
    List<String> initial = const [],
    bool chips = true,
    bool filterable = false,
  }) {
    _data[name] = initial;
    return _add({
      'component': 'ChoicePicker',
      'label': label,
      'variant': multiple ? 'multipleSelection' : 'mutuallyExclusive',
      'displayStyle': chips ? 'chips' : 'checkbox',
      if (filterable) 'filterable': true,
      'options': [
        for (final e in options.entries) {'label': e.value, 'value': e.key},
      ],
      'value': bind(name),
    });
  }

  A2uiFormBuilder field(
    String name,
    String label, {
    String initial = '',
    String? placeholder,
    bool multiline = false,
    bool number = false,
  }) {
    _data[name] = initial;
    return _add({
      'component': 'TextField',
      'label': label,
      'value': bind(name),
      if (placeholder != null) 'placeholder': placeholder,
      if (multiline) 'variant': 'longText' else if (number) 'variant': 'number',
    });
  }

  A2uiFormBuilder check(String name, String label, {bool initial = false}) {
    _data[name] = initial;
    return _add({'component': 'CheckBox', 'label': label, 'value': bind(name)});
  }

  /// Whole numbers from [min] to [max], one step per unit.
  A2uiFormBuilder slider(String name, String label, int min, int max, {required int initial}) {
    _data[name] = initial;
    return _add({
      'component': 'Slider',
      'label': label,
      'min': min,
      'max': max,
      'steps': max - min,
      'value': bind(name),
    });
  }

  /// A button that sends an action named [action] with the current values of
  /// [fields] plus fixed [extra] values. [requiredField] disables it until
  /// that field has a value.
  A2uiFormBuilder button(
    String label,
    String action, {
    List<String> fields = const [],
    Map<String, Object?> extra = const {},
    bool primary = true,
    String? requiredField,
    String requiredMessage = 'Completa este dato',
  }) {
    final labelId = _id('label');
    _components.add({'id': labelId, 'component': 'Text', 'text': label});
    return _add({
      'component': 'Button',
      'child': labelId,
      'variant': primary ? 'primary' : 'borderless',
      if (requiredField != null)
        '@checks': [
          {
            'condition': {
              '@call': 'required',
              'args': {'value': bind(requiredField)},
            },
            'message': requiredMessage,
          },
        ],
      'action': {
        'event': {
          'name': action,
          'context': {
            for (final f in fields) f: bind(f),
            ...extra,
          },
        },
      },
    });
  }

  /// Buttons side by side (pass ids of buttons added with [buttonRow]).
  A2uiFormBuilder buttonRow(List<A2uiFormBuilder Function(A2uiFormBuilder)> buttons) {
    final start = _children.length;
    for (final b in buttons) {
      b(this);
    }
    final ids = _children.sublist(start);
    _children.removeRange(start, _children.length);
    return _add({'component': 'Row', 'justify': 'end', 'children': ids});
  }

  A2uiFormBuilder _add(Map<String, Object?> component) {
    final id = _id((component['component'] as String).toLowerCase());
    _components.add({'id': id, ...component});
    _children.add(id);
    return this;
  }

  /// The createSurface message, ready for `MessageProcessor.processMessages`.
  List<Map<String, Object?>> build() => [
        {
          'version': '1.0',
          'createSurface': {
            'surfaceId': surfaceId,
            'catalogId': BasicCatalog.v1_0Id,
            'components': [
              {'id': 'root', 'component': 'Card', 'child': 'col'},
              {'id': 'col', 'component': 'Column', 'children': _children},
              ..._components,
            ],
            'dataModel': {'f': _data},
          },
        },
      ];
}
