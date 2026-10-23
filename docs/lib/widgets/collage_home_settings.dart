// Home showcase: settings cards (P6-H1).
//
// Extends the Theme Studio settings blocks
// (`studio_blocks/studio_settings.dart`, `studio_blocks/studio_tabs.dart`):
// switch rows, a currency select and cookie choices, re-shelled in
// [CollageCard] for the home wall.

import 'package:flutter/widgets.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';

import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/select/select.dart';
import '../ui/dashcn/components/switch/switch.dart';
import '../ui/dashcn/foundation/gap.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Notifications`: switch rows, the way upstream's settings cards read.
class HomeNotificationsCard extends StatefulWidget {
  /// Creates the card.
  const HomeNotificationsCard({super.key});

  @override
  State<HomeNotificationsCard> createState() => _HomeNotificationsCardState();
}

class _HomeNotificationsCardState extends State<HomeNotificationsCard> {
  static List<(String, String)> rows = <(String, String)>[
    (
      docsSample(null, 'Transaction alerts'),
      docsSample(null, 'Deposits, withdrawals, and transfers.'),
    ),
    (
      docsSample(null, 'Security alerts'),
      docsSample(null, 'Login attempts and account changes.'),
    ),
    (
      docsSample(null, 'Goal milestones'),
      docsSample(null, 'Updates at 25%, 50%, 75%, and 100%.'),
    ),
    (
      docsSample(null, 'Market updates'),
      docsSample(null, 'Daily portfolio summary and price alerts.'),
    ),
  ];

  final Set<int> _on = <int>{0, 1, 2};

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeNotifTitle'),
      subtitle: docsSample(
        context,
        'Choose what you want to be notified about.',
      ),
      trailing: Badge(
        variant: BadgeVariant.outline,
        child: Text('${_on.length} of ${rows.length}'),
      ),
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(rows[i].$1),
                      const Gap(2),
                      StudioHelper(rows[i].$2),
                    ],
                  ),
                ),
                const Gap(12),
                Switch(
                  value: _on.contains(i),
                  onChanged: (bool value) => setState(() {
                    if (value) {
                      _on.add(i);
                    } else {
                      _on.remove(i);
                    }
                  }),
                ),
              ],
            ),
          ),
        const Gap(8),
        Button(
          variant: ButtonVariant.primary,
          onPressed: () {},
          child: SizedBox(
            width: double.infinity,
            child: Text(
              docsSample(context, 'Save Preferences'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

/// `Preferences`: a select and two switch rows.
class HomePreferencesCard extends StatefulWidget {
  /// Creates the card.
  const HomePreferencesCard({super.key});

  @override
  State<HomePreferencesCard> createState() => _HomePreferencesCardState();
}

class _HomePreferencesCardState extends State<HomePreferencesCard> {
  static List<String> currencies = <String>[
    r'USD — United States Dollar',
    docsSample(null, 'EUR — Euro'),
    docsSample(null, 'GBP — British Pound'),
  ];

  static List<(String, String)> switches = <(String, String)>[
    (
      docsSample(null, 'Public Statistics'),
      docsSample(null, 'Allow others to see your stream count'),
    ),
    (
      docsSample(null, 'Email Notifications'),
      docsSample(null, 'Monthly royalty and distribution updates'),
    ),
  ];

  String _currency = currencies.first;
  final Set<int> _on = <int>{0};

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homePrefTitle'),
      subtitle: docsSample(
        context,
        'Manage your account settings and notifications.',
      ),
      children: <Widget>[
        StudioFieldLabel(docsSample(context, 'Default Currency')),
        const Gap(6),
        Select<String>(
          value: _currency,
          onChanged: (String? next) =>
              setState(() => _currency = next ?? _currency),
          items: <Widget>[
            for (final String currency in currencies)
              SelectItem<String>(value: currency, child: Text(currency)),
          ],
          itemBuilder: (BuildContext context, String value) =>
              Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        const Gap(16),
        for (int i = 0; i < switches.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(switches[i].$1),
                      const Gap(2),
                      StudioHelper(switches[i].$2),
                    ],
                  ),
                ),
                const Gap(12),
                Switch(
                  value: _on.contains(i),
                  onChanged: (bool value) => setState(() {
                    if (value) {
                      _on.add(i);
                    } else {
                      _on.remove(i);
                    }
                  }),
                ),
              ],
            ),
          ),
        const Gap(16),
        Row(
          children: <Widget>[
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                onPressed: collageNoop,
                child: Text(docsSample(context, 'Reset')),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Button(
                variant: ButtonVariant.primary,
                onPressed: () {},
                child: Text(docsSample(context, 'Save Preferences')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// `Cookie Settings`: three switch rows with badges.
class HomeCookieCard extends StatefulWidget {
  /// Creates the card.
  const HomeCookieCard({super.key});

  @override
  State<HomeCookieCard> createState() => _HomeCookieCardState();
}

class _HomeCookieCardState extends State<HomeCookieCard> {
  static List<(String, String, bool)> rows = <(String, String, bool)>[
    (
      docsSample(null, 'Strictly Necessary'),
      docsSample(null, 'Required for the site to work.'),
      true,
    ),
    (
      docsSample(null, 'Functional'),
      docsSample(null, 'Remembers your preset and mode.'),
      true,
    ),
    (
      docsSample(null, 'Analytics'),
      docsSample(null, 'Anonymous usage measurements.'),
      false,
    ),
  ];

  final Set<int> _on = <int>{0, 1};

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeCookieTitle'),
      subtitle: docsHome(locale, 'homeCookieSub'),
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Text(rows[i].$1),
                          if (rows[i].$3)
                            Badge(
                              variant: BadgeVariant.outline,
                              child: Text(docsSample(context, 'Always on')),
                            ),
                        ],
                      ),
                      const Gap(2),
                      StudioHelper(rows[i].$2),
                    ],
                  ),
                ),
                const Gap(12),
                Switch(
                  value: _on.contains(i),
                  onChanged: (bool value) => setState(() {
                    if (value) {
                      _on.add(i);
                    } else {
                      _on.remove(i);
                    }
                  }),
                ),
              ],
            ),
          ),
        const Gap(12),
        Button(
          variant: ButtonVariant.primary,
          onPressed: () {},
          child: SizedBox(
            width: double.infinity,
            child: Text(
              docsSample(context, 'Save Choices'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
