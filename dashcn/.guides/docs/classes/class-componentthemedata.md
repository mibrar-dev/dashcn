---
title: "Class: ComponentThemeData"
description: "Base of every `<Name>Theme` component theme class."
---

```dart
/// Base of every `<Name>Theme` component theme class. Carries optional
/// density/spacing/shadow overrides scoped to that component.
abstract class ComponentThemeData {
  const ComponentThemeData({this.themeDensity, this.themeSpacing, this.themeShadows});
  /// Optional density override for this component theme.
  final Density? themeDensity;
  /// Optional spacing override for this component theme.
  final SpacingScale? themeSpacing;
  /// Optional shadow override for this component theme.
  final ShadowScale? themeShadows;
  bool operator ==(Object other);
  int get hashCode;
}
```
