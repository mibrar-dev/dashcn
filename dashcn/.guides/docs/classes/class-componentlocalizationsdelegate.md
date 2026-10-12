---
title: "Class: ComponentLocalizationsDelegate"
description: "Loads [ComponentLocalizations] for every locale that ships translated data."
---

```dart
/// Loads [ComponentLocalizations] for every locale that ships translated data.
///
/// Matching is on the language code, so `de_AT` resolves to German and
/// `zh_TW` to the traditional-Chinese table.
class ComponentLocalizationsDelegate extends LocalizationsDelegate<ComponentLocalizations> {
  /// Creates the delegate.
  const ComponentLocalizationsDelegate();
  bool isSupported(Locale locale);
  Future<ComponentLocalizations> load(Locale locale);
  bool shouldReload(ComponentLocalizationsDelegate old);
}
```
