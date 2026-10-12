---
title: "Class: SizeUnitLocale"
description: "Unit table and digit-grouping rules for byte-size formatting."
---

```dart
/// Unit table and digit-grouping rules for byte-size formatting.
///
/// ```dart
/// SizeUnitLocale.fileBytes.format(1536); // '1.5 KB'
/// const SizeUnitLocale(1000, ['B', 'kB'], separator: ' ').format(1234567);
/// // '1 234.6 kB'
/// ```
class SizeUnitLocale {
  /// Creates a unit table.
  ///
  /// [base] is the conversion factor between units (1024 for binary,
  /// 1000 for decimal), [units] are the labels from smallest to largest and
  /// [separator] groups the digits of the integer part (empty disables
  /// grouping).
  const SizeUnitLocale(this.base, this.units, {this.separator = ','});
  /// Conversion factor between two neighbouring units.
  final int base;
  /// Unit labels from smallest ([units] first) to largest.
  final List<String> units;
  /// Separator inserted between digit groups of the integer part.
  final String separator;
  /// Byte units with the conventional short labels (`B`, `KB`, `MB`, …).
  static const SizeUnitLocale fileBytes = SizeUnitLocale(1024, <String>['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']);
  /// Binary byte units with IEC labels (`B`, `KiB`, `MiB`, …).
  ///
  /// Replaces the old `fileBits`, whose labels started at `Bi` and described
  /// binary *bytes*; the renamed table keeps a single `B` for whole bytes.
  static const SizeUnitLocale binaryBytes = SizeUnitLocale(1024, <String>['B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']);
  /// Formats [bytes] using this table.
  ///
  /// Zero and negative counts read `0 <unit>`. Values past the largest unit
  /// stay in that unit instead of overflowing the table (the old top-level
  /// formatter indexed past the end and threw a `RangeError`).
  String format(int bytes);
}
```
