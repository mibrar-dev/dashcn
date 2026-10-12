---
title: "Class: AlertDialog"
description: "Builds the header row: optional icon, then the title/description column."
---

```dart
/// Builds the header row: optional icon, then the title/description column.
class AlertDialog extends StatelessWidget {
  /// Creates an alert dialog body.
  ///
  /// Place it in the `builder` of [showAlertDialog]; the surrounding card,
  /// padding and barrier come from the `dialog` component.
  const AlertDialog({super.key, this.title, this.description, this.icon, this.actions = const <Widget>[], this.theme});
  /// Headline of the dialog. Typically a `Text`.
  final Widget? title;
  /// Supporting text below [title]. Typically a `Text`.
  final Widget? description;
  /// Leading glyph of the header, usually an `Icon`. It is tinted with
  /// `AlertDialogTheme.iconColor` (`mutedForeground` by default).
  final Widget? icon;
  /// Footer controls, usually buttons. They are laid out in a row aligned by
  /// `AlertDialogTheme.footerAlignment` (the end of the row by default) and
  /// separated by `actionGap`.
  final List<Widget> actions;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final AlertDialogTheme? theme;
  Widget build(BuildContext context);
}
```
