---
title: "Variable: tableFooterCellDefaults"
description: "Default footer-cell styling: medium muted-foreground text, no border."
---

Signature
```dart
const TableCellTheme tableFooterCellDefaults = TableCellTheme(background: StateValue<ThemedColor>(hovered: ThemedColor.ref(ColorRef.muted, alpha: 0.5)), foreground: StateValue<ThemedColor>(rest: ThemedColor.ref(ColorRef.mutedForeground)), borderWidth: 0, padding: tableHeadCellPadding);
```
