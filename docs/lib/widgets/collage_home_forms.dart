// Home showcase: form cards (P6-H1).
//
// Extends the Theme Studio form blocks (`studio_blocks/studio_forms.dart`):
// `Select`, `Slider`, `TextArea` and `Input` compositions, re-shelled in
// [CollageCard] for the home wall.

import 'package:flutter/widgets.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/select/select.dart';
import '../ui/dashcn/components/slider/slider.dart';
import '../ui/dashcn/components/text_area/text_area.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Payout Threshold`: a select, a slider with a live amount and a textarea.
class HomePayoutCard extends StatefulWidget {
  /// Creates the card.
  const HomePayoutCard({super.key});

  @override
  State<HomePayoutCard> createState() => _HomePayoutCardState();
}

class _HomePayoutCardState extends State<HomePayoutCard> {
  List<String> _currencies(BuildContext context) => <String>[
    docsSample(context, 'USD — United States Dollar'),
    docsSample(context, 'EUR — Euro'),
    docsSample(context, 'GBP — British Pound'),
  ];

  int _currencyIndex = 0;
  double _minimum = 2500;

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    final List<String> currencies = _currencies(context);
    return CollageCard(
      title: docsHome(locale, 'homePayoutTitle'),
      subtitle: docsHome(locale, 'homePayoutSub'),
      trailing: const Icon(LucideIcons.x, size: 14),
      children: <Widget>[
        StudioFieldLabel(docsHome(locale, 'homePrefCurrency')),
        const Gap(6),
        Select<String>(
          value: currencies[_currencyIndex],
          onChanged: (String? next) {
            if (next == null) {
              return;
            }
            final int index = currencies.indexOf(next);
            if (index >= 0) {
              setState(() => _currencyIndex = index);
            }
          },
          items: <Widget>[
            for (final String currency in currencies)
              SelectItem<String>(value: currency, child: Text(currency)),
          ],
          itemBuilder: (BuildContext context, String value) =>
              Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        const Gap(20),
        Row(
          children: <Widget>[
            Expanded(
              child: StudioFieldLabel(
                docsSample(context, 'Minimum Payout Amount'),
              ),
            ),
            Text(
              r'$' + _minimum.toStringAsFixed(2),
              style: theme.typography.small.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const Gap(8),
        Slider(
          value: _minimum,
          min: 50,
          max: 10000,
          onChanged: (double next) => setState(() => _minimum = next),
          semanticLabel: docsSample(context, 'Minimum payout amount'),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                docsSample(context, r'$50 (MIN)'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.typography.xSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            Expanded(
              child: Text(
                docsSample(context, r'$10,000 (MAX)'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: theme.typography.xSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        StudioFieldLabel(docsSample(context, 'Notes')),
        const Gap(6),
        TextArea(
          minLines: 3,
          maxLines: 4,
          hintText: docsSample(
            context,
            'Add any notes for this payout configuration...',
          ),
        ),
        const Gap(16),
        Button(
          variant: ButtonVariant.primary,
          onPressed: () {},
          child: SizedBox(
            width: double.infinity,
            child: Text(
              docsSample(context, 'Save Threshold'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

/// `Report an Issue`: a select plus a textarea, as upstream's form cards do.
class HomeReportCard extends StatefulWidget {
  /// Creates the card.
  const HomeReportCard({super.key});

  @override
  State<HomeReportCard> createState() => _HomeReportCardState();
}

class _HomeReportCardState extends State<HomeReportCard> {
  List<String> _kinds(BuildContext context) => <String>[
    docsSample(context, 'Wrong royalty split'),
    docsSample(context, 'Missing track'),
    docsSample(context, 'Artwork rejected'),
    docsSample(context, 'Payout delayed'),
  ];

  int _kindIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final List<String> kinds = _kinds(context);
    return CollageCard(
      title: docsHome(locale, 'homeReportTitle'),
      subtitle: docsSample(
        context,
        'Tell us what went wrong and we will pick it up.',
      ),
      children: <Widget>[
        StudioFieldLabel(docsSample(context, 'Category')),
        const Gap(6),
        Select<String>(
          value: kinds[_kindIndex],
          onChanged: (String? next) {
            if (next == null) {
              return;
            }
            final int index = kinds.indexOf(next);
            if (index >= 0) {
              setState(() => _kindIndex = index);
            }
          },
          items: <Widget>[
            for (final String kind in kinds)
              SelectItem<String>(value: kind, child: Text(kind)),
          ],
          itemBuilder: (BuildContext context, String value) => Text(value),
        ),
        const Gap(16),
        StudioFieldLabel(docsSample(context, 'What happened?')),
        const Gap(6),
        TextArea(
          minLines: 4,
          maxLines: 6,
          hintText: docsSample(
            context,
            'Include track names, dates and any error codes.',
          ),
        ),
        const Gap(16),
        Row(
          children: <Widget>[
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                onPressed: collageNoop,
                child: Text(docsSample(context, 'Cancel')),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Button(
                variant: ButtonVariant.primary,
                onPressed: () {},
                child: Text(docsSample(context, 'Submit Report')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
