// Scopes component previews under the active website locale and directionality.
//
// Passes `Localizations` (with `ComponentLocalizations` delegates) and
// `Directionality` (derived from `textDirectionForLocale`), so every kit
// component inside a preview renders in the selected language and flips to RTL
// for Arabic, Hebrew, Persian, Urdu, etc.

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../routing/docs_router.dart';
import '../state/docs_sample_strings.dart';
import '../ui/dashcn/primitives/localizations/localizations.dart';

/// Scopes a preview subtree under the website's ambient [Locale] and [TextDirection].
class PreviewScope extends StatelessWidget {
  /// Creates a preview scope around [child], optionally overriding [locale].
  const PreviewScope({super.key, this.locale, required this.child});

  /// Optional locale override; defaults to website ambient locale.
  final Locale? locale;

  /// The preview content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Locale activeLocale =
        locale ??
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.maybeLocaleOf(context) ??
        currentDocsLocale;
    final TextDirection direction = textDirectionForLocale(activeLocale);
    return Localizations(
      locale: activeLocale,
      delegates: const <LocalizationsDelegate<dynamic>>[
        ...ComponentLocalizations.localizationsDelegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Directionality(textDirection: direction, child: child),
    );
  }
}
