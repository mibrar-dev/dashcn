---
title: "Variable: tableCellDefaults"
description: "Default body-cell styling: bottom border, `muted/50` hover fill."
---

Signature
```dart
const TableCellTheme tableCellDefaults = TableCellTheme(background: StateValue<ThemedColor>(hovered: ThemedColor.ref(ColorRef.muted, alpha: 0.5)), foreground: StateValue<ThemedColor>(rest: ThemedColor.ref(ColorRef.foreground), disabled: ThemedColor.ref(ColorRef.mutedForeground)), borderColor: StateValue<ThemedColor>(rest: ThemedColor.ref(ColorRef.border)), borderWidth: 1, padding: tableCellPadding);
```
