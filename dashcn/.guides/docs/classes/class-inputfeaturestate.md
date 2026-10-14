---
title: "Class: InputFeatureState"
description: "What a feature sees of its input field."
---

```dart
/// What a feature sees of its input field.
///
/// Features are stateless descriptors building against this one contract;
/// mutable per-feature state lives in [slot].
abstract class InputFeatureState {
  /// Context of the input widget; safe for popovers and `Actions.invoke`.
  BuildContext get featureContext;
  /// The effective text controller.
  TextEditingController get controller;
  /// Whether the input state is still mounted.
  bool get mounted;
  /// Current text.
  String get text;
  /// Current selection.
  TextSelection get selection;
  /// Whether the field has focus.
  bool get focused;
  /// Whether the pointer hovers the field.
  bool get hovered;
  /// Effective obscure flag (widget value or a password feature override).
  bool get obscureText;
  /// Sets the password override; null falls back to the widget value.
  void setObscureText(bool? value);
  /// Rebuilds the input.
  void setFeatureState(VoidCallback fn);
  /// Runs the widget-leg validator immediately.
  void validateNow();
  /// Per-feature mutable slot, created on first use, disposed with the input.
  T slot<T extends Object>(InputFeature feature, T Function() create);
  /// The slot [feature] already owns, or null. Features that hold a
  /// [dispose]-time resource (a controller, a notifier) read it here so they
  /// can release it when the field tears the slot down.
  Object? featureSlotOf(InputFeature feature);
}
```
