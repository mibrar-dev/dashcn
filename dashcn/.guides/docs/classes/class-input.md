---
title: "Class: Input"
description: "A single-line (or multi-line) text field."
---

```dart
/// A single-line (or multi-line) text field.
///
/// ```dart
/// Input(
///   hintText: 'Email',
///   features: const <InputFeature>[InputClearFeature()],
/// );
/// ```
class Input extends StatefulWidget {
  /// Creates an input.
  ///
  /// [initialValue] and [controller] are mutually exclusive. [validator] runs
  /// per [autovalidateMode]; a non-null result paints a destructive border and
  /// shows the message below the field.
  const Input({super.key, this.controller, this.initialValue, this.focusNode, this.undoController, this.statesController, this.keyboardType, this.textInputAction, this.textCapitalization = TextCapitalization.none, this.style, this.placeholder, this.hintText, this.textAlign = TextAlign.start, this.maxLines = 1, this.minLines, this.expands = false, this.maxLength, this.maxLengthEnforcement, this.obscureText = false, this.obscuringCharacter = '•', this.readOnly = false, this.enabled = true, this.autofocus = false, this.autocorrect = true, this.enableSuggestions = true, this.inputFormatters, this.autofillHints, this.cursorColor, this.cursorWidth = 2.0, this.cursorHeight, this.cursorRadius, this.scrollPadding = const EdgeInsets.all(20), this.onChanged, this.onEditingComplete, this.onSubmitted, this.onTapOutside, this.selectionControls, this.contextMenuBuilder, this.decoration, this.border, this.borderRadius, this.filled, this.padding, this.features = const <InputFeature>[], this.validator, this.autovalidateMode = FormValidationMode.changed, this.groupId = EditableText, this.theme, this.showFocusRing = true});
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final UndoHistoryController? undoController;
  final WidgetStatesController? statesController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final Widget? placeholder;
  final String? hintText;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool obscureText;
  final String obscuringCharacter;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final Color? cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final EdgeInsets scrollPadding;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final TapRegionCallback? onTapOutside;
  final TextSelectionControls? selectionControls;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final BoxDecoration? decoration;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final bool? filled;
  final EdgeInsetsGeometry? padding;
  final List<InputFeature> features;
  final String? Function(String? value)? validator;
  final FormValidationMode autovalidateMode;
  final Object groupId;
  final InputTheme? theme;
  /// Whether the focused field paints the ring; false keeps caret only.
  final bool showFocusRing;
  State<Input> createState();
}
```
