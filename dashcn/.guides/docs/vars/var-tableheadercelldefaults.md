---
title: "Variable: tableHeaderCellDefaults"
description: "Default header-cell styling: upstream v4 `TableHead` (`h-10 px-2`, medium  `foreground` text)."
---

Signature
```dart
const TableCellTheme tableHeaderCellDefaults = TableCellTheme(background: StateValue<ThemedColor>(hovered: ThemedColor.ref(ColorRef.muted, alpha: 0.5)), foreground: StateValue<ThemedColor>(rest: ThemedColor.ref(ColorRef.foreground)), borderColor: StateValue<ThemedColor>(rest: ThemedColor.ref(ColorRef.border)), borderWidth: 1, textStyle: TextStyle(fontWeight: FontWeight.w500), padding: tableHeadCellPadding, minHeight: 40);
```
