// The settings blocks of the Theme Studio canvas: switch rows grouped the way
// upstream's account pages do them.
//
// `Switch`, `Badge` and `Button` are the registry components; the rows are
// layout. Split out of `studio_list.dart` to keep every block file short.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/badge/badge.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/switch/switch.dart';
import '../../ui/dashcn/foundation/gap.dart';
import 'studio_card.dart';
import '../../ui/dashcn/foundation/component_preview.dart';

/// `Notifications`: switch rows, the way upstream's settings cards read.
class StudioNotificationsCard extends StatefulWidget {
  /// Creates the card.
  const StudioNotificationsCard({super.key});

  @override
  State<StudioNotificationsCard> createState() =>
      _StudioNotificationsCardState();
}

class _StudioNotificationsCardState extends State<StudioNotificationsCard> {
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
    return StudioCard(
      title: docsSample(context, 'Notifications'),
      subtitle: docsSample(
        context,
        'Choose what you want to be notified about.',
      ),
      trailing: Badge(
        variant: BadgeVariant.outline,
        child: Text('${_on.length} of ${rows.length}'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
