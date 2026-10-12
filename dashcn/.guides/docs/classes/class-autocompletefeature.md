---
title: "Class: AutoCompleteFeature"
description: "The `input`-component adapter: an [InputFeature] that turns the field text  into the `autocomplete` suggestion popover."
---

```dart
/// The `input`-component adapter: an [InputFeature] that turns the field text
/// into the `autocomplete` suggestion popover.
///
/// The list opens while typing and closes when the query yields nothing.
/// Install it with `Input(features: <InputFeature>[AutoCompleteFeature(...)])`.
///
/// ```dart
/// Input(
///   hintText: 'Fruit',
///   features: <InputFeature>[
///     AutoCompleteFeature(suggestions: (query) => _fruits(query)),
///   ],
/// )
/// ```
class AutoCompleteFeature extends InputFeature {
  /// Creates the feature.
  const AutoCompleteFeature({required this.suggestions, this.mode, this.completer = identityAutoCompleteCompleter, this.onSuggestionSelected, this.itemBuilder, this.theme, super.visibility, super.skipFocusTraversal});
  /// Provides the suggestions for a query. May be asynchronous.
  final SuggestionBuilder suggestions;
  /// Overrides `AutoCompleteTheme.mode`.
  final AutoCompleteMode? mode;
  /// Post-processes a suggestion before it is applied.
  final AutoCompleteCompleter completer;
  /// Called after a suggestion was written into the field.
  final ValueChanged<String>? onSuggestionSelected;
  /// Builds one suggestion row; null renders the upstream default.
  final SuggestionRowBuilder? itemBuilder;
  /// Widget-leg theme override for the suggestion list.
  final AutoCompleteTheme? theme;
  void onTextChanged(InputFeatureState state, String text);
  void onFocusGained(InputFeatureState state);
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts(InputFeatureState state);
  Iterable<MapEntry<Type, Action<Intent>>> buildActions(InputFeatureState state);
  void dispose(InputFeatureState state);
}
```
