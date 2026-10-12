---
title: "Class: ValidatorBuilder"
description: "Builds a custom validator from a function."
---

```dart
/// Builds a custom validator from a function.
///
/// ```dart
/// ValidatorBuilder<String>(
///   (value) => (value?.contains('@') ?? false)
///       ? null
///       : const InvalidResult('Must contain @', state: FormValidationMode.changed),
/// );
/// ```
class ValidatorBuilder<T> extends Validator<T> {
  /// Creates a validator around [builder].
  const ValidatorBuilder(this.builder, {this.dependencies = const <FormKey>[]});
  /// The function performing the check.
  final ValidatorBuilderFunction<T> builder;
  /// Keys this validator re-runs for when their value changes.
  final List<FormKey> dependencies;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey source);
  bool operator ==(Object other);
  int get hashCode;
}
```
