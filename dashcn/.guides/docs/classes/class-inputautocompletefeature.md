---
title: "Class: InputAutoCompleteFeature"
description: "Generic suggestion slot: `input` knows nothing about `autocomplete`."
---

```dart
/// Generic suggestion slot: `input` knows nothing about `autocomplete`.
///
/// [suggestionMenuBuilder] receives the current suggestions and a selection
/// callback; when null the feature computes and renders nothing.
class InputAutoCompleteFeature extends InputFeature {
  /// Creates a suggestion-slot feature; defaults to `focused` visibility.
  const InputAutoCompleteFeature({required this.suggestions, super.visibility = InputFeatureVisibility.focused, this.onSuggestionSelected, this.suggestionMenuBuilder});
  /// Provides suggestions for the current query.
  final SuggestionBuilder suggestions;
  /// Called after a suggestion is selected.
  final ValueChanged<String>? onSuggestionSelected;
  /// Builds the suggestion menu; null renders no menu at all.
  final Widget Function(BuildContext context, Iterable<String> suggestions, ValueChanged<String> onSelected)? suggestionMenuBuilder;
  void onTextChanged(InputFeatureState state, String text);
  Widget wrap(InputFeatureState state, Widget child);
}
```
