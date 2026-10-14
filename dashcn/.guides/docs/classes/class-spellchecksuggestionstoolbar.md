---
title: "Class: SpellCheckSuggestionsToolbar"
description: "A upstream styled toolbar offering replacement suggestions for the  misspelled word under the cursor."
---

```dart
/// A upstream styled toolbar offering replacement suggestions for the
/// misspelled word under the cursor.
///
/// Build it from an [EditableTextState] with the `.editableText` constructor
/// and return it from an editable text toolbar builder; the framework places
/// it at [anchors]. The registry `input` component does not enable spell
/// check itself, so this toolbar is wired by apps that opt into
/// `EditableText`'s `spellCheckConfiguration`.
class SpellCheckSuggestionsToolbar extends StatelessWidget {
  /// Creates a toolbar from explicit button items.
  ///
  /// [buttonItems] must not contain more than three items, mirroring the
  /// platform convention.
  const SpellCheckSuggestionsToolbar({super.key, required this.anchors, required this.buttonItems});
  /// Creates a toolbar for [editableTextState].
  ///
  /// Reads the misspelled span under the cursor from [editableTextState] and
  /// turns its suggestions into replacement rows. When there is no misspelled
  /// span, or the service offers no suggestion for it, the toolbar builds to
  /// nothing.
  SpellCheckSuggestionsToolbar.editableText({super.key, required EditableTextState editableTextState});
  /// Where the toolbar is anchored relative to the text field.
  final TextSelectionToolbarAnchors anchors;
  /// The replacement suggestions to display, at most three.
  final List<ContextMenuButtonItem> buttonItems;
  /// Replacement rows for the misspelled word under the cursor.
  ///
  /// Returns an empty list when the cursor is not inside a misspelled span.
  /// A misspelled span without suggestions returns one disabled placeholder
  /// row; the toolbar labels it with
  /// `ComponentLocalizations.spellCheckNoSuggestions`.
  static List<ContextMenuButtonItem> buildButtonItems(EditableTextState editableTextState);
  Widget build(BuildContext context);
}
```
