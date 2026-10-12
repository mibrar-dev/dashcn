---
title: "Class: EditableTextFieldRow"
description: "Lays out leading/trailing adornments around an editable child, with a  placeholder (widget or hint text) stacked under the text while empty."
---

```dart
/// Lays out leading/trailing adornments around an editable child, with a
/// placeholder (widget or hint text) stacked under the text while empty.
class EditableTextFieldRow extends StatelessWidget {
  /// Creates a field row.
  const EditableTextFieldRow({super.key, required this.editable, required this.showPlaceholder, this.placeholder, this.hintText, this.hintStyle, this.textAlign = TextAlign.start, this.maxLines, this.leading = const <Widget>[], this.trailing = const <Widget>[], this.gap = 4});
  /// The editable text widget.
  final Widget editable;
  /// Whether the field is empty and the placeholder may show.
  final bool showPlaceholder;
  /// Placeholder widget; wins over [hintText].
  final Widget? placeholder;
  /// Placeholder text.
  final String? hintText;
  /// Style of [hintText].
  final TextStyle? hintStyle;
  /// Alignment of [hintText].
  final TextAlign textAlign;
  /// Maximum lines of [hintText].
  final int? maxLines;
  /// Widgets before the editable text.
  final List<Widget> leading;
  /// Widgets after the editable text.
  final List<Widget> trailing;
  /// Gap between adornments and the text.
  final double gap;
  Widget build(BuildContext context);
}
```
