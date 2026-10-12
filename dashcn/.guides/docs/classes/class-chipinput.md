---
title: "Class: ChipInput"
description: "A token field: text typed next to [chip] widgets, each with its own remove  button."
---

```dart
/// A token field: text typed next to [chip] widgets, each with its own remove
/// button.
///
/// Two modes, like `Toggle`: uncontrolled with a [TokenEditingController], or
/// controlled with [chips] + [onChipsChanged].
///
/// ```dart
/// ChipInput<String>(onChipSubmit: (t) => t.toLowerCase(), initialChips: ['a']);
/// ```
class ChipInput<T> extends StatefulWidget {
  /// Creates a chip input.
  const ChipInput({super.key, this.controller, this.initialChips, this.chips, this.onChipsChanged, required this.onChipSubmit, this.chipBuilder, this.suggestions, this.features = const <InputFeature>[], this.clipboardHandler, this.hintText, this.focusNode, this.keyboardType, this.enabled = true, this.readOnly = false, this.validator, this.autovalidateMode = FormValidationMode.changed, this.theme, this.inputTheme});
  /// Owns the field text and its tokens; created and disposed here when null.
  final TokenEditingController<T>? controller;
  /// Chips an uncontrolled field starts with; ignored in controlled mode.
  final List<T>? initialChips;
  /// Controlled mode: the chips to render.
  final List<T>? chips;
  /// Called with the new chip list whenever it changes.
  final ValueChanged<List<T>>? onChipsChanged;
  /// Converts the word at the caret into a chip; null rejects it.
  final ChipSubmitCallback<T> onChipSubmit;
  /// Builds each chip's content; defaults to a `Text` of the value.
  final ChipBuilder<T>? chipBuilder;
  /// Suggestions for the current word; an accepted one becomes a chip.
  final SuggestionBuilder? suggestions;
  /// Extra input features, installed before the field's own key bindings.
  final List<InputFeature> features;
  /// Chip clipboard serialization; defaults to [PlainTokenClipboardHandler].
  final TokenClipboardHandler<T>? clipboardHandler;
  /// Hint shown while the field is empty.
  final String? hintText;
  /// Focus node of the field.
  final FocusNode? focusNode;
  /// Keyboard type of the field; the keyboard action is always `done`.
  final TextInputType? keyboardType;
  /// Whether the field accepts input; a disabled field is dimmed to 50%.
  final bool enabled;
  /// Whether the text and the chips can be edited.
  final bool readOnly;
  /// Validates the chip list; a non-null result paints a destructive border
  /// and shows the message below the field.
  final String? Function(List<T> chips)? validator;
  /// When [validator] runs.
  final FormValidationMode autovalidateMode;
  /// Widget-leg token overrides, merged over the other legs.
  final ChipInputTheme? theme;
  /// Widget-leg overrides for the field surface itself.
  final InputTheme? inputTheme;
  State<ChipInput<T>> createState();
}
```
