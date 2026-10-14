---
title: "Class: FlipperCharset"
description: "Character pool a [FlipperCharacter] rolls through."
---

```dart
/// Character pool a [FlipperCharacter] rolls through.
class FlipperCharset {
  /// Digits 0-9.
  static const FlipperCharset numbers = FlipperCharset('0123456789');
  /// Uppercase Latin letters.
  static const FlipperCharset uppercase = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  /// Lowercase Latin letters.
  static const FlipperCharset lowercase = FlipperCharset('abcdefghijklmnopqrstuvwxyz');
  /// Uppercase and lowercase Latin letters.
  static const FlipperCharset letters = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
  /// Alphanumeric characters.
  static const FlipperCharset alphanumeric = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789');
  /// Common symbol characters.
  static const FlipperCharset symbols = FlipperCharset('!@#\$%^&*()-_=+[]{}|;:\'",.<>?/`~');
  /// Letters, numbers and symbols.
  static const FlipperCharset all = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()-_=+[]{}|;:\'",.<>?/`~');
  /// Creates a charset from a string of characters.
  const FlipperCharset(this.characters);
  /// The characters available to roll through.
  final String characters;
  /// Concatenates two charsets.
  FlipperCharset operator +(FlipperCharset other);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
