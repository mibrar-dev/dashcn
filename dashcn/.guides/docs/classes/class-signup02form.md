---
title: "Class: Signup02Form"
description: "The sign-up form itself, shared by the signup-02 layouts."
---

```dart
/// The sign-up form itself, shared by the signup-02 layouts.
class Signup02Form extends StatelessWidget {
  /// Creates the form column.
  const Signup02Form({super.key, required this.controller, required this.onValidSubmit, required this.firstNameKey, required this.lastNameKey, required this.emailKey, required this.passwordKey, required this.termsKey, required this.firstNameFocus, required this.lastNameFocus, required this.emailFocus, required this.passwordFocus, required this.passwordController, required this.password, required this.terms, required this.onTermsChanged, required this.submitting, required this.succeeded, required this.onSubmit, required this.onSignIn});
  final FormController controller;
  final FormSubmitCallback onValidSubmit;
  final FormKey<String> firstNameKey;
  final FormKey<String> lastNameKey;
  final FormKey<String> emailKey;
  final FormKey<String> passwordKey;
  final FormKey<CheckboxValue> termsKey;
  final FocusNode firstNameFocus;
  final FocusNode lastNameFocus;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final TextEditingController passwordController;
  /// The current password text; drives the strength meter below the field.
  final String password;
  final CheckboxValue terms;
  final ValueChanged<CheckboxValue> onTermsChanged;
  final bool submitting;
  final bool succeeded;
  final Future<void> Function() onSubmit;
  final VoidCallback? onSignIn;
  Widget build(BuildContext context);
}
```
