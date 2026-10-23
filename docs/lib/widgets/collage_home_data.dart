import '../ui/dashcn/foundation/component_preview.dart';
// Home showcase: data-display cards (P6-H1).
//
// Extends the Theme Studio blocks (`studio_blocks/studio_list.dart`,
// `studio_blocks/studio_form.dart`): avatar-led transaction rows, the team
// roster with role selects, the FAQ accordion and the `Distribute Track`
// empty state — re-shelled in [CollageCard] for the home wall.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/accordion/accordion.dart';
import '../ui/dashcn/components/avatar/avatar.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/empty_state/empty_state.dart';
import '../ui/dashcn/components/select/select.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';

/// `Recent Transactions`: a list of avatar rows with a category caption.
class HomeTransactionsCard extends StatelessWidget {
  /// Creates the card.
  const HomeTransactionsCard({super.key});

  static List<(String, String, IconData, String, bool)> rows =
      <(String, String, IconData, String, bool)>[
        (
          docsSample(null, 'Blue Bottle Coffee'),
          docsSample(null, 'Food & Drink'),
          LucideIcons.coffee,
          r'Today, 10:24 AM -$6.50',
          false,
        ),
        (
          docsSample(null, 'Whole Foods Market'),
          docsSample(null, 'Groceries'),
          LucideIcons.shoppingCart,
          r'Yesterday -$142.30',
          false,
        ),
        (
          docsSample(null, 'Stripe Payout'),
          docsSample(null, 'Income'),
          LucideIcons.landmark,
          r'Oct 12 +$4,200.00',
          true,
        ),
        (
          docsSample(null, 'Uber Technologies'),
          docsSample(null, 'Transport'),
          LucideIcons.car,
          r'Oct 11 -$24.10',
          false,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Recent Transactions'),
      subtitle: docsSample(context, 'Your latest account activity.'),
      trailing: Button(
        variant: ButtonVariant.ghost,
        size: ButtonSize.sm,
        onPressed: collageNoop,
        child: Text(docsSample(context, 'View All')),
      ),
      children: <Widget>[
        for (int i = 0; i < rows.length; i++) ...<Widget>[
          if (i > 0)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: _HomeRowDivider(),
            ),
          _TransactionRow(entry: rows[i]),
        ],
      ],
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.entry});

  final (String, String, IconData, String, bool) entry;

  @override
  Widget build(BuildContext context) {
    final String name = entry.$1;
    final String category = entry.$2;
    final IconData icon = entry.$3;
    final String amount = entry.$4;
    final bool inbound = entry.$5;
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Avatar(initials: _initials(name), size: 32),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(name, style: theme.typography.small),
                Text(
                  category,
                  style: theme.typography.small.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Icon(icon, size: 14, color: theme.colors.mutedForeground),
          const Gap(12),
          SizedBox(
            width: 96,
            child: Text(
              amount,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typography.small.copyWith(
                fontWeight: inbound ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A hairline between rows, themed like the divider component's default.
class _HomeRowDivider extends StatelessWidget {
  const _HomeRowDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: ColoredBox(color: Theme.of(context).colors.border),
    );
  }
}

/// `Team Members`: avatars with a role `Select` per row.
class HomeTeamCard extends StatelessWidget {
  /// Creates the card.
  const HomeTeamCard({super.key});

  static List<(String, String)> members = <(String, String)>[
    (docsSample(null, 'Maya Okafor'), docsSample(null, 'Admin')),
    (docsSample(null, 'Leo Marchetti'), docsSample(null, 'Editor')),
  ];

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Team Members'),
      subtitle: docsSample(
        context,
        'Four people have access to this workspace.',
      ),
      children: <Widget>[
        for (final (String name, String role) in members)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                Avatar(initials: _initials(name), size: 34),
                const Gap(12),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(12),
                SizedBox(width: 116, child: _HomeRoleSelect(role: role)),
              ],
            ),
          ),
        const Gap(8),
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: collageNoop,
          child: Text(docsSample(context, 'Invite teammate')),
        ),
      ],
    );
  }
}

class _HomeRoleSelect extends StatefulWidget {
  const _HomeRoleSelect({required this.role});

  final String role;

  @override
  State<_HomeRoleSelect> createState() => _HomeRoleSelectState();
}

class _HomeRoleSelectState extends State<_HomeRoleSelect> {
  static List<String> roles = <String>[
    docsSample(null, 'Admin'),
    docsSample(null, 'Editor'),
    docsSample(null, 'Analyst'),
    docsSample(null, 'Viewer'),
  ];

  late String _role = widget.role;

  @override
  Widget build(BuildContext context) {
    return Select<String>(
      value: _role,
      onChanged: (String? next) => setState(() => _role = next ?? _role),
      items: <Widget>[
        for (final String role in roles)
          SelectItem<String>(value: role, child: Text(role)),
      ],
      itemBuilder: (BuildContext context, String value) => Text(value),
    );
  }
}

/// `Frequently asked questions`: the registry accordion with three items.
class HomeFaqCard extends StatelessWidget {
  /// Creates the card.
  const HomeFaqCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Frequently asked questions'),
      subtitle: docsSample(context, 'General, Billing and Goals'),
      children: <Widget>[
        Accordion(
          items: <AccordionItem>[
            AccordionItem(
              expanded: true,
              trigger: Text(
                docsSample(context, 'How secure is my financial data?'),
              ),
              content: Text(
                'Bank-level AES-256 encryption, SOC 2 Type II certified '
                'infrastructure, and read-only access tokens.',
              ),
            ),
            AccordionItem(
              trigger: Text(
                docsSample(
                  context,
                  docsSample(
                    context,
                    'How do I connect my bank or investment accounts?',
                  ),
                ),
              ),
              content: Text(
                'Open Preferences, pick a receiving method and follow the '
                'bank-level OAuth flow.',
              ),
            ),
            AccordionItem(
              trigger: Text(
                docsSample(context, 'Can I export my data for tax purposes?'),
              ),
              content: Text(
                docsSample(
                  context,
                  'Every report exports as CSV, including the royalty ledger.',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// `Distribute Track`: the reference's empty state with its CTA.
class HomeEmptyCard extends StatelessWidget {
  /// Creates the card.
  const HomeEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'New Release'),
      subtitle: docsSample(context, 'Nothing here yet.'),
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.empty,
          size: EmptyStateSize.compact,
          icon: Icon(LucideIcons.plus, size: 18),
          title: Text(docsSample(context, 'Distribute Track')),
          description: Text(
            'Upload your first master to start reaching listeners on Spotify, '
            'Apple Music, and more.',
            textAlign: TextAlign.center,
          ),
          primaryAction: EmptyStateAction(
            label: docsSample(context, 'Create Release'),
          ),
        ),
      ],
    );
  }
}

/// The two-letter initials an `Avatar` falls back to.
String _initials(String name) => name
    .split(' ')
    .where((String part) => part.isNotEmpty)
    .take(2)
    .map((String part) => part[0])
    .join()
    .toUpperCase();
