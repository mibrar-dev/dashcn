---
title: "Mixin: InputFeatureHostState"
description: "Implements [InputFeatureState] over an [EditableTextHost]-based state."
---

```dart
/// Implements [InputFeatureState] over an [EditableTextHost]-based state.
mixin InputFeatureHostState<T extends StatefulWidget> on State<T> implements InputFeatureState {
  /// The editing host of this field.
  EditableTextHost get editingHost;
  /// Per-feature slots of this field.
  InputFeatureSlots get featureSlots;
  /// The password-feature override, or null for the widget value.
  bool? get obscureOverride;
  /// Assigns the password override (and rebuilds).
  void setObscureOverride(bool? value);
  /// The widget's own obscure flag.
  bool get widgetObscureText;
  BuildContext get featureContext;
  TextEditingController get controller;
  String get text;
  TextSelection get selection;
  bool get focused;
  bool get hovered;
  bool get obscureText;
  void setObscureText(bool? value);
  void setFeatureState(VoidCallback fn);
  T2 slot<T2 extends Object>(InputFeature feature, T2 Function() create);
  Object? featureSlotOf(InputFeature feature);
}
```
