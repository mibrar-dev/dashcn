---
title: "Class: InputOtp"
description: "A one-time-password / verification-code input."
---

```dart
/// A one-time-password / verification-code input. The code lives in one hidden
/// field; the slots are painted from the string (see README.md).
class InputOtp extends StatefulWidget {
  /// Creates an OTP input.
  const InputOtp({super.key, required this.length, this.controller, this.initialValue, this.onChanged, this.onCompleted, this.onSubmitted, this.keyboardType = TextInputType.number, this.obscureText = false, this.readOnly = false, this.enabled = true, this.autofocus = false, this.textCapitalization = TextCapitalization.none, this.autofillHints = const <String>[AutofillHints.oneTimeCode], this.inputFormatters, this.filter, this.separator, this.separatorEvery, this.validator, this.autovalidateMode = FormValidationMode.changed, this.theme});
  /// Number of slots.
  final int length;
  /// Controller for the whole code; created internally when null.
  final TextEditingController? controller;
  /// Initial code; ignored when [controller] is given.
  final String? initialValue;
  /// Called with the whole code whenever it changes.
  final ValueChanged<String>? onChanged;
  /// Called once, the first time every slot is filled.
  final ValueChanged<String>? onCompleted;
  /// Called when the field is submitted (Enter / the platform action).
  final ValueChanged<String>? onSubmitted;
  /// Keyboard type; digits by default.
  final TextInputType keyboardType;
  /// Whether each character is replaced by a dot.
  final bool obscureText;
  /// Whether the code can be edited.
  final bool readOnly;
  /// Whether the field accepts input; a disabled field is dimmed to 50%.
  final bool enabled;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  /// Rejects a character when it returns false. Null accepts everything.
  final bool Function(String character)? filter;
  /// Widget drawn after every [separatorEvery] slots; needs [separatorEvery].
  final Widget? separator;
  /// Slots between two separators.
  final int? separatorEvery;
  /// Validation of the whole code; the message renders below the row, but only
  /// once every slot is filled. The validator itself runs on every change
  /// (per [autovalidateMode]) and sees partial codes along the way.
  final String? Function(String? code)? validator;
  /// When [validator] runs: `initial` on mount, `changed` on every change,
  /// `submitted` on submit; all three also when [validator] itself changes.
  final FormValidationMode autovalidateMode;
  /// Widget-leg theme override, merged on top of the other legs.
  final InputOtpTheme? theme;
  State<InputOtp> createState();
}
```
