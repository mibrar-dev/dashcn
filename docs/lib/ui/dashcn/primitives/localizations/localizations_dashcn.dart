// The public i18n entry point: the `DashcnLocalizations` name, RTL helpers,
// a direction-aware icon, an LTR guard for numbers/code, and a per-instance
// locale override.
//
// [ComponentLocalizations] is the generated lookup table (English defaults +
// one subclass per translated locale); everything here is a thin alias or a
// small widget built on top of it, so the lookup keeps a single source of
// truth with an English fallback (`ComponentLocalizations.of` returns
// `ComponentLocalizations.english` when no delegate was installed).

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../foundation/icons/lucide_icons.dart';
import 'localizations.dart';

/// Every user-facing string in the kit.
///
/// Alias for [ComponentLocalizations]: one instance per locale, reached with
/// [ComponentLocalizations.of] (equivalently `DashcnLocalizations.of`).
/// The values are the English defaults; locales with translated data subclass
/// it and override what they translate (see `lookupComponentLocalizations`).
///
/// ```dart
/// Text(DashcnLocalizations.of(context).formLengthLessThan(4));
/// ```
typedef DashcnLocalizations = ComponentLocalizations;

/// Loads [DashcnLocalizations] for every locale with translated data.
///
/// Alias for [ComponentLocalizationsDelegate].
typedef DashcnLocalizationsDelegate = ComponentLocalizationsDelegate;

/// Language codes written right-to-left (ISO 639), from the Unicode CLDR.
///
/// A locale implies its text direction; the kit reads it through
/// [isRtlLocale]/[textDirectionForLocale] and Flutter resolves
/// [Directionality] from `WidgetsLocalizations`, not from the string tables.
const Set<String> kRtlLanguageCodes = <String>{
  'ar', // Arabic
  'he', // Hebrew
  'fa', // Persian
  'ur', // Urdu
  'ps', // Pashto
  'yi', // Yiddish
  'ug', // Uyghur
  'sd', // Sindhi
  'ku', // Kurdish (Sorani)
};

/// Whether [locale] is written right-to-left.
///
/// Covers the kit's RTL locales (`ar`, `he`, `fa`, `ur`) and their regional
/// variants (`ar_EG`, …): only the language code matters.
bool isRtlLocale(Locale locale) =>
    kRtlLanguageCodes.contains(locale.languageCode.toLowerCase());

/// The [TextDirection] implied by [locale].
TextDirection textDirectionForLocale(Locale locale) =>
    isRtlLocale(locale) ? TextDirection.rtl : TextDirection.ltr;

/// An icon that flips in RTL locales.
///
/// In LTR, [forward] picks [right] and `!forward` picks [left]; in RTL the
/// sides swap, so "next" chevrons, back arrows and pagination controls keep
/// pointing the way the eye reads. Numbers and code must NOT use this: wrap
/// those in [DashcnLtr] instead so digits never mirror.
///
/// ```dart
/// DashcnDirectionalIcon.forward(
///   left: LucideIcons.chevronLeft,
///   right: LucideIcons.chevronRight,
/// )
/// ```
class DashcnDirectionalIcon extends StatelessWidget {
  /// Creates a direction-aware icon pointing forward (next).
  const DashcnDirectionalIcon.forward({
    super.key,
    required this.left,
    required this.right,
    this.size,
    this.color,
    this.semanticLabel,
  }) : forward = true;

  /// Creates a direction-aware icon pointing backward (previous).
  const DashcnDirectionalIcon.backward({
    super.key,
    required this.left,
    required this.right,
    this.size,
    this.color,
    this.semanticLabel,
  }) : forward = false;

  /// The icon shown in LTR when going backward (previous).
  final IconData left;

  /// The icon shown in LTR when going forward (next).
  final IconData right;

  /// Which way the icon points in LTR; mirrored in RTL.
  final bool forward;

  /// Icon size; null uses the ambient [IconTheme].
  final double? size;

  /// Icon color; null uses the ambient [IconTheme].
  final Color? color;

  /// Semantics label; null leaves the icon unlabeled.
  final String? semanticLabel;

  /// The chevron pair most navigations use, pointing forward.
  static DashcnDirectionalIcon chevronNext({double? size, Color? color}) =>
      DashcnDirectionalIcon.forward(
        left: LucideIcons.chevronLeft,
        right: LucideIcons.chevronRight,
        size: size,
        color: color,
      );

  /// The chevron pair most navigations use, pointing backward.
  static DashcnDirectionalIcon chevronPrevious({double? size, Color? color}) =>
      DashcnDirectionalIcon.backward(
        left: LucideIcons.chevronLeft,
        right: LucideIcons.chevronRight,
        size: size,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    // XOR: forward-in-RTL shows the LTR-backward glyph and vice versa.
    final IconData icon = (forward != rtl) ? right : left;
    return Icon(icon, size: size, color: color, semanticLabel: semanticLabel);
  }
}

/// Forces left-to-right layout for numbers, code and other LTR-only runs.
///
/// Digits, file sizes, durations and code snippets must never mirror in RTL
/// locales; wrap them so `Directionality` stays LTR underneath.
class DashcnLtr extends StatelessWidget {
  /// Creates an LTR guard around [child].
  const DashcnLtr({super.key, required this.child});

  /// The LTR-only content (numbers, code, durations).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr, child: child);
  }
}

/// Overrides the locale (and therefore the strings) for one subtree.
///
/// A per-instance override without touching the app's locale: dialogs,
/// previews and tests wrap content to show another language in place. Falls
/// back to English for locales with no translated table, exactly like
/// [ComponentLocalizations.of].
///
/// ```dart
/// DashcnLocaleOverride(
///   locale: const Locale('ar'),
///   child: MyDialog(),
/// )
/// ```
class DashcnLocaleOverride extends StatelessWidget {
  /// Creates a per-subtree locale override.
  const DashcnLocaleOverride({
    super.key,
    required this.locale,
    required this.child,
  });

  /// The locale [child] reads strings in.
  final Locale locale;

  /// The subtree using [locale].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: locale,
      delegates: <LocalizationsDelegate<dynamic>>[
        ...ComponentLocalizations.localizationsDelegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Directionality(
        textDirection: textDirectionForLocale(locale),
        child: child,
      ),
    );
  }
}
