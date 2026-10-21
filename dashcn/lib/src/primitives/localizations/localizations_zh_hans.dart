import 'package:flutter/widgets.dart';

import 'localizations.dart';
import 'localizations_zh.dart';

/// Simplified Chinese (`zh_Hans`) locale data.
///
/// `zh` is the simplified-Chinese table; this subclass pins the `Hans`
/// script subtag so `Locale.fromSubtags(languageCode: 'zh',
/// scriptCode: 'Hans')` (and `zh_Hans`) resolves to a distinct entry in
/// [ComponentLocalizations.supportedLocales] while sharing every string.
/// Text direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsZhHans extends ComponentLocalizationsZh {
  /// Creates the simplified-Chinese strings.
  const ComponentLocalizationsZhHans([
    super.locale = const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hans',
    ),
  ]);

  @override
  String get chartTotalLabel => '总计';
}
