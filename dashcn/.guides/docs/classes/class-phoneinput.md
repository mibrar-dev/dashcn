---
title: "Class: PhoneInput"
description: "A country selector plus a number field (an optional dial-code prefix plus  the national number)."
---

```dart
/// A country selector plus a number field (an optional dial-code prefix plus
/// the national number). `onChanged` reports a [PhoneNumber] whenever either
/// side changes, and null while the number is empty.
class PhoneInput extends StatefulWidget {
  const PhoneInput({super.key, this.initialCountry, this.initialValue, this.onChanged, this.controller, this.onlyNumber = true, this.countries, this.searchPlaceholder, this.theme});
  /// Country selected when [initialValue] carries none.
  final Country? initialCountry;
  /// Initial country + national number.
  final PhoneNumber? initialValue;
  /// Called with the next value; null while the number is empty.
  final ValueChanged<PhoneNumber?>? onChanged;
  /// External text controller for the national number. When null the widget
  /// owns one seeded from [initialValue].
  final TextEditingController? controller;
  /// Whether the number field accepts digits only.
  final bool onlyNumber;
  /// Rows offered by the selector; null uses the full ISO table.
  final List<CountryInfo>? countries;
  /// Placeholder of the selector's search field.
  final Widget? searchPlaceholder;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final PhoneInputTheme? theme;
  State<PhoneInput> createState();
}
```
