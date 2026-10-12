---
title: "Mixin: ComponentLocalizationsOverlay"
description: "Overlay text for [ComponentLocalizations]: dialogs, menus, the command palette  and popover affordances."
---

```dart
/// Overlay text for [ComponentLocalizations]: dialogs, menus, the command palette
/// and popover affordances.
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it.
mixin ComponentLocalizationsOverlay {
  String get commandEmpty;
  String get commandSearch;
  String get commandMoveUp;
  String get commandMoveDown;
  String get commandActivate;
  /// Label of a dialog's dismiss control and of dismiss actions.
  ///
  /// Copied from Flutter's `modalBarrierDismissLabel`.
  String get dialogDismiss;
  String get menuCut;
  String get menuCopy;
  String get menuPaste;
  String get menuSelectAll;
  String get menuShare;
  String get menuSearchWeb;
  String get menuLiveTextInput;
  String get menuUndo;
  String get menuRedo;
  String get menuDelete;
  /// Shown by the spell check suggestions toolbar when the misspelled word
  /// has no replacement suggestion.
  ///
  /// English fallback: Flutter's material/cupertino ARB tables carry no
  /// equivalent string, so no translations are copied.
  String get spellCheckNoSuggestions;
}
```
