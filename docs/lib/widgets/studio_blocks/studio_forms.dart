// The form blocks of the Theme Studio canvas: the reference `/create` cards
// built from `Select`, `Slider`, `TextArea` and `Input`.
//
// Each one re-themes live: the select surface, the slider track and thumb, the
// textarea border and the button all read the tokens the rail edits.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/input/input.dart';
import '../../ui/dashcn/components/select/select.dart';
import '../../ui/dashcn/components/slider/slider.dart';
import '../../ui/dashcn/components/switch/switch.dart';
import '../../ui/dashcn/components/text_area/text_area.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../../ui/dashcn/theme/theme.dart';
import 'studio_card.dart';
import '../../ui/dashcn/foundation/component_preview.dart';

/// `Payout Threshold`: a select, a slider with a live amount and a textarea.
class StudioPayoutCard extends StatefulWidget {
  /// Creates the card.
  const StudioPayoutCard({super.key});

  @override
  State<StudioPayoutCard> createState() => _StudioPayoutCardState();
}

class _StudioPayoutCardState extends State<StudioPayoutCard> {
  static List<String> currencies = <String>[
    r'USD — United States Dollar',
    docsSample(null, 'EUR — Euro'),
    docsSample(null, 'GBP — British Pound'),
  ];

  String _currency = currencies.first;
  double _minimum = 2500;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StudioCard(
      title: docsSample(context, 'Payout Threshold'),
      subtitle: docsSample(
        context,
        'Set the minimum balance before a payout is triggered.',
      ),
      trailing: const Icon(LucideIcons.x, size: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StudioFieldLabel(docsSample(context, 'Preferred Currency')),
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
                  r'$50 (MIN)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.typography.xSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  r'$10,000 (MAX)',
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
      ),
    );
  }
}

/// `Buy Investment`: amount input, order-type select and an estimate row.
class StudioInvestmentCard extends StatefulWidget {
  /// Creates the card.
  const StudioInvestmentCard({super.key});

  @override
  State<StudioInvestmentCard> createState() => _StudioInvestmentCardState();
}

class _StudioInvestmentCardState extends State<StudioInvestmentCard> {
  static List<String> orderTypes = <String>[
    docsSample(null, 'Market Order'),
    docsSample(null, 'Limit Order'),
    docsSample(null, 'Stop Order'),
  ];

  String _orderType = orderTypes.first;
  String _amount = '2500';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StudioCard(
      title: docsSample(context, 'Buy Investment'),
      subtitle: docsSample(
        context,
        'A strategy for building wealth over time.',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StudioFieldLabel(docsSample(context, 'Amount to Invest')),
          const Gap(6),
          Row(
            children: <Widget>[
              Text(
                r'$',
                style: theme.typography.h3.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Input(
                  initialValue: _amount,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) => _amount = value,
                  hintText: '0.00',
                ),
              ),
            ],
          ),
          const Gap(16),
          StudioFieldLabel(docsSample(context, 'Order Type')),
          const Gap(6),
          Select<String>(
            value: _orderType,
            onChanged: (String? next) =>
                setState(() => _orderType = next ?? _orderType),
            items: <Widget>[
              for (final String type in orderTypes)
                SelectItem<String>(value: type, child: Text(type)),
            ],
            itemBuilder: (BuildContext context, String value) => Text(value),
          ),
          const Gap(16),
          StudioRow(
            label: docsSample(context, 'Estimated Shares'),
            value: '1.95',
          ),
          StudioRow(
            label: docsSample(context, 'Buying Power'),
            value: r'$12,450.00',
          ),
          const Gap(12),
          const Text(
            'Market orders execute at the current price. Trades are '
            'typically executed within minutes during market hours.',
            style: TextStyle(fontSize: 12),
          ),
          const Gap(16),
          Button(
            variant: ButtonVariant.primary,
            onPressed: () {},
            child: SizedBox(
              width: double.infinity,
              child: Text(
                docsSample(context, 'Review Order'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// `Report an Issue`: a select plus a textarea, as upstream's form cards do.
class StudioReportIssueCard extends StatefulWidget {
  /// Creates the card.
  const StudioReportIssueCard({super.key});

  @override
  State<StudioReportIssueCard> createState() => _StudioReportIssueCardState();
}

class _StudioReportIssueCardState extends State<StudioReportIssueCard> {
  static List<String> kinds = <String>[
    docsSample(null, 'Wrong royalty split'),
    docsSample(null, 'Missing track'),
    docsSample(null, 'Artwork rejected'),
    docsSample(null, 'Payout delayed'),
  ];

  String _kind = kinds.first;

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Report an Issue'),
      subtitle: docsSample(
        context,
        'Tell us what went wrong and we will pick it up.',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StudioFieldLabel(docsSample(context, 'Category')),
          const Gap(6),
          Select<String>(
            value: _kind,
            onChanged: (String? next) => setState(() => _kind = next ?? _kind),
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
                  onPressed: studioNoop,
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
      ),
    );
  }
}

/// `Create Account`: the upstream email/password signup card.
class StudioCreateAccountCard extends StatefulWidget {
  /// Creates the card.
  const StudioCreateAccountCard({super.key});

  @override
  State<StudioCreateAccountCard> createState() =>
      _StudioCreateAccountCardState();
}

class _StudioCreateAccountCardState extends State<StudioCreateAccountCard> {
  bool _sameAddress = true;
  String _payout = docsSample(null, 'Bank Transfer');

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Create Account'),
      subtitle: docsSample(
        context,
        'Start distributing your music in minutes.',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StudioFieldLabel(docsSample(context, 'Email')),
          const Gap(6),
          const Input(
            initialValue: '',
            hintText: 'm@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const Gap(16),
          StudioFieldLabel(docsSample(context, 'Password')),
          const Gap(6),
          Input(
            initialValue: '',
            obscureText: true,
            hintText: docsSample(context, 'At least 8 characters'),
          ),
          const Gap(16),
          StudioFieldLabel(docsSample(context, 'Payout Method')),
          const Gap(6),
          Select<String>(
            value: _payout,
            onChanged: (String? next) =>
                setState(() => _payout = next ?? _payout),
            items: <Widget>[
              SelectItem<String>(
                value: docsSample(context, 'Bank Transfer'),
                child: Text(docsSample(context, 'Bank Transfer')),
              ),
              SelectItem<String>(value: 'PayPal', child: Text('PayPal')),
            ],
            itemBuilder: (BuildContext context, String value) => Text(value),
          ),
          const Gap(16),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(docsSample(context, 'Billing same as payout')),
              ),
              Switch(
                value: _sameAddress,
                onChanged: (bool value) => setState(() => _sameAddress = value),
              ),
            ],
          ),
          const Gap(16),
          Button(
            variant: ButtonVariant.primary,
            onPressed: () {},
            child: SizedBox(
              width: double.infinity,
              child: Text(
                docsSample(context, 'Create Account'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
