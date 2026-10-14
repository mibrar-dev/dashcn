---
title: "Class: SelectableText"
description: "Read-only text that users can select, copy and long-press."
---

```dart
/// Read-only text that users can select, copy and long-press.
///
/// ```dart
/// const SelectableText('Select this text');
/// SelectableText.rich(TextSpan(children: <TextSpan>[...]));
/// ```
class SelectableText extends StatefulWidget {
  /// Creates selectable text from a plain string.
  const SelectableText(String this.data, {super.key, this.focusNode, this.style, this.strutStyle, this.textAlign, this.textDirection, this.textScaler, this.showCursor = false, this.autofocus = false, this.minLines, this.maxLines, this.cursorWidth, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle, this.selectionWidthStyle, this.enableInteractiveSelection, this.selectionControls, this.contextMenuBuilder, this.onTap, this.onSelectionChanged, this.semanticsLabel, this.textHeightBehavior, this.textWidthBasis, this.theme});
  /// Creates selectable text from a styled [TextSpan].
  const SelectableText.rich(TextSpan this.textSpan, {super.key, this.focusNode, this.style, this.strutStyle, this.textAlign, this.textDirection, this.textScaler, this.showCursor = false, this.autofocus = false, this.minLines, this.maxLines, this.cursorWidth, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle, this.selectionWidthStyle, this.enableInteractiveSelection, this.selectionControls, this.contextMenuBuilder, this.onTap, this.onSelectionChanged, this.semanticsLabel, this.textHeightBehavior, this.textWidthBasis, this.theme});
  /// Plain text; null when the [SelectableText.rich] constructor is used.
  final String? data;
  /// Styled text; null when the default constructor is used.
  final TextSpan? textSpan;
  /// Focus node; one is created and disposed internally when null.
  final FocusNode? focusNode;
  /// Style override; merged over the theme and default text style.
  final TextStyle? style;
  /// Strut style override.
  final StrutStyle? strutStyle;
  /// Horizontal text alignment.
  final TextAlign? textAlign;
  /// Text direction override.
  final TextDirection? textDirection;
  /// Text scaling override.
  final TextScaler? textScaler;
  /// Whether to paint a blinking caret when focused.
  final bool showCursor;
  /// Whether to focus when first built.
  final bool autofocus;
  /// Minimum number of lines.
  final int? minLines;
  /// Maximum number of lines before scrolling.
  final int? maxLines;
  /// Caret width override.
  final double? cursorWidth;
  /// Caret height override.
  final double? cursorHeight;
  /// Caret corner radius override.
  final Radius? cursorRadius;
  /// Caret colour override.
  final Color? cursorColor;
  /// Selection box height style override.
  final BoxHeightStyle? selectionHeightStyle;
  /// Selection box width style override.
  final BoxWidthStyle? selectionWidthStyle;
  /// Whether drag/double-tap/long-press selection is enabled.
  final bool? enableInteractiveSelection;
  /// Selection controls override; defaults to `SelectionControls`.
  final TextSelectionControls? selectionControls;
  /// Context menu builder override; defaults to the upstream toolbar.
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  /// Called when the text is tapped.
  final VoidCallback? onTap;
  /// Called when the selection changes.
  final SelectionChangedCallback? onSelectionChanged;
  /// Semantic label; replaces the text semantics when set.
  final String? semanticsLabel;
  /// Text height behavior override.
  final TextHeightBehavior? textHeightBehavior;
  /// Text width basis override.
  final TextWidthBasis? textWidthBasis;
  /// Widget-leg theme override, merged on top of the other legs.
  final SelectableTextTheme? theme;
  State<SelectableText> createState();
}
```
