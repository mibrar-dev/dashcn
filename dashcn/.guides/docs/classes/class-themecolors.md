---
title: "Class: ThemeColors"
description: "The 32 upstream color tokens for one brightness."
---

```dart
/// The 32 upstream color tokens for one brightness.
///
/// Field names match the preset JSON keys exactly (camelCase of the upstream
/// CSS variables, PLAN §6.1). Colors may carry alpha (8-digit ARGB); never
/// assume opaque. `destructiveForeground` is a normal field (un-deprecated
/// per QA decision A5); contrast derivation only applies at import time.
class ThemeColors {
  const ThemeColors({required this.brightness, required this.background, required this.foreground, required this.card, required this.cardForeground, required this.popover, required this.popoverForeground, required this.primary, required this.primaryForeground, required this.secondary, required this.secondaryForeground, required this.muted, required this.mutedForeground, required this.accent, required this.accentForeground, required this.destructive, required this.destructiveForeground, required this.border, required this.input, required this.ring, required this.chart1, required this.chart2, required this.chart3, required this.chart4, required this.chart5, required this.sidebar, required this.sidebarForeground, required this.sidebarPrimary, required this.sidebarPrimaryForeground, required this.sidebarAccent, required this.sidebarAccentForeground, required this.sidebarBorder, required this.sidebarRing});
  final Brightness brightness;
  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color popover;
  final Color popoverForeground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;
  final Color sidebar;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;
  /// Chart series colors in order.
  List<Color> get chartColors;
  /// All tokens are non-nullable, so copyWith takes plain optional values.
  ThemeColors copyWith({Brightness? brightness, Color? background, Color? foreground, Color? card, Color? cardForeground, Color? popover, Color? popoverForeground, Color? primary, Color? primaryForeground, Color? secondary, Color? secondaryForeground, Color? muted, Color? mutedForeground, Color? accent, Color? accentForeground, Color? destructive, Color? destructiveForeground, Color? border, Color? input, Color? ring, Color? chart1, Color? chart2, Color? chart3, Color? chart4, Color? chart5, Color? sidebar, Color? sidebarForeground, Color? sidebarPrimary, Color? sidebarPrimaryForeground, Color? sidebarAccent, Color? sidebarAccentForeground, Color? sidebarBorder, Color? sidebarRing});
  /// Field-wise lerp. Brightness steps at t = 0.5.
  static ThemeColors lerp(ThemeColors a, ThemeColors b, double t);
  bool operator ==(Object other);
  int get hashCode;
  /// Transcribed from the old `ColorSchemes.lightDefaultColor`. Test and
  /// fallback baseline only; real apps use generated preset values.
  static const ThemeColors lightFallback = ThemeColors(brightness: Brightness.light, background: Color(0xFFFFFFFF), foreground: Color(0xFF0A0A0A), card: Color(0xFFFFFFFF), cardForeground: Color(0xFF0A0A0A), popover: Color(0xFFFFFFFF), popoverForeground: Color(0xFF0A0A0A), primary: Color(0xFF171717), primaryForeground: Color(0xFFFAFAFA), secondary: Color(0xFFF5F5F5), secondaryForeground: Color(0xFF171717), muted: Color(0xFFF5F5F5), mutedForeground: Color(0xFF737373), accent: Color(0xFFF5F5F5), accentForeground: Color(0xFF171717), destructive: Color(0xFFE7000B), destructiveForeground: Color(0xFFFFFFFF), border: Color(0xFFE5E5E5), input: Color(0xFFE5E5E5), ring: Color(0xFFA1A1A1), chart1: Color(0xFFF54900), chart2: Color(0xFF009689), chart3: Color(0xFF104E64), chart4: Color(0xFFFFB900), chart5: Color(0xFFFE9A00), sidebar: Color(0xFFFAFAFA), sidebarForeground: Color(0xFF0A0A0A), sidebarPrimary: Color(0xFF171717), sidebarPrimaryForeground: Color(0xFFFAFAFA), sidebarAccent: Color(0xFFF5F5F5), sidebarAccentForeground: Color(0xFF171717), sidebarBorder: Color(0xFFE5E5E5), sidebarRing: Color(0xFFA1A1A1));
  /// Transcribed from the old `ColorSchemes.darkDefaultColor`. Also the
  /// readability fallback source for dark normalisation.
  static const ThemeColors darkFallback = ThemeColors(brightness: Brightness.dark, background: Color(0xFF0A0A0A), foreground: Color(0xFFFAFAFA), card: Color(0xFF171717), cardForeground: Color(0xFFFAFAFA), popover: Color(0xFF171717), popoverForeground: Color(0xFFFAFAFA), primary: Color(0xFFE5E5E5), primaryForeground: Color(0xFF171717), secondary: Color(0xFF262626), secondaryForeground: Color(0xFFFAFAFA), muted: Color(0xFF262626), mutedForeground: Color(0xFFA1A1A1), accent: Color(0xFF262626), accentForeground: Color(0xFFFAFAFA), destructive: Color(0xFFFF6467), destructiveForeground: Color(0xFFFFFFFF), border: Color(0x1AFFFFFF), input: Color(0x26FFFFFF), ring: Color(0xFF737373), chart1: Color(0xFF1447E6), chart2: Color(0xFF00BC7D), chart3: Color(0xFFFE9A00), chart4: Color(0xFFAD46FF), chart5: Color(0xFFFF2056), sidebar: Color(0xFF171717), sidebarForeground: Color(0xFFFAFAFA), sidebarPrimary: Color(0xFF1447E6), sidebarPrimaryForeground: Color(0xFFFAFAFA), sidebarAccent: Color(0xFF262626), sidebarAccentForeground: Color(0xFFFAFAFA), sidebarBorder: Color(0x1AFFFFFF), sidebarRing: Color(0xFF737373));
}
```
