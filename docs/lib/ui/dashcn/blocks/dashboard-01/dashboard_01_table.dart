// The `dashboard-01` block, part 2: the recent-transactions table with its
// working customer filter. Imported by `dashboard_01.dart`; a block never
// imports another block.

import 'package:flutter/widgets.dart';

import '../../components/badge/badge.dart';
import '../../components/card/card.dart';
import '../../components/divider/divider.dart';
import '../../components/input/input.dart';
import '../../components/table/table.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';

class _Dashboard01Order {
  const _Dashboard01Order(this.customer, this.status, this.method, this.amount);

  final String customer;
  final String status;
  final String method;
  final String amount;

  /// Registry badge variant for the status cell.
  BadgeVariant get badgeVariant => switch (status) {
    'Paid' => BadgeVariant.primary,
    'Pending' => BadgeVariant.secondary,
    _ => BadgeVariant.outline,
  };
}

const List<_Dashboard01Order> _dashboard01Orders = <_Dashboard01Order>[
  _Dashboard01Order('Olivia Martin', 'Paid', 'Visa', '\$1,999.00'),
  _Dashboard01Order('Jackson Lee', 'Pending', 'Mastercard', '\$39.00'),
  _Dashboard01Order('Isabella Nguyen', 'Refunded', 'PayPal', '\$299.00'),
  _Dashboard01Order('William Kim', 'Paid', 'Visa', '\$99.00'),
  _Dashboard01Order('Sofia Davis', 'Paid', 'Amex', '\$499.00'),
];

/// Recent transactions with a working customer filter.
class Dashboard01Recent extends StatefulWidget {
  /// Creates the table card.
  const Dashboard01Recent({super.key});

  @override
  State<Dashboard01Recent> createState() => _Dashboard01RecentState();
}

class _Dashboard01RecentState extends State<Dashboard01Recent> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final String needle = _filter.trim().toLowerCase();
    final List<_Dashboard01Order> rows = needle.isEmpty
        ? _dashboard01Orders
        : _dashboard01Orders
              .where(
                (_Dashboard01Order order) =>
                    order.customer.toLowerCase().contains(needle),
              )
              .toList();
    return Card(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final strings = ComponentLocalizations.of(context);
                final Widget filter = SizedBox(
                  width: 220,
                  child: Input(
                    hintText: strings.blockFilterTransactions,
                    onChanged: (String value) =>
                        setState(() => _filter = value),
                  ),
                );
                // The title and the 220px filter share one row from 560px;
                // below that the filter takes its own row instead of
                // squeezing the title off-screen.
                if (constraints.maxWidth >= 560) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Transactions',
                          style: theme.typography.textLarge,
                        ),
                      ),
                      Gap(theme.spacing.lg),
                      filter,
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      strings.blockTransactions,
                      style: theme.typography.textLarge,
                    ),
                    Gap(theme.spacing.md),
                    filter,
                  ],
                );
              },
            ),
          ),
          const Divider(),
          if (rows.isEmpty)
            Padding(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Text(
                strings.blockNoTransactions(_filter),
                style: theme.typography.textSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            )
          else
            TableView(
              // upstream `TableHead` is h-10 (40); body rows hug the same
              // height so the badge (h-5) centres with even padding.
              defaultRowHeight: const FixedTableSize(40),
              columnWidths: const <int, TableSize>{
                0: FlexTableSize(flex: 2),
                1: FlexTableSize(),
                2: FlexTableSize(),
                3: FixedTableSize(110),
              },
              rows: <TableViewRow>[
                TableViewHeader(
                  cells: <TableViewCell>[
                    TableViewCell(child: Text(strings.blockCustomer)),
                    TableViewCell(child: Text(strings.blockStatus)),
                    TableViewCell(child: Text(strings.blockMethod)),
                    TableViewCell(child: Text(strings.blockAmount)),
                  ],
                ),
                for (final _Dashboard01Order order in rows)
                  TableViewRow(
                    cells: <TableViewCell>[
                      TableViewCell(child: Text(order.customer)),
                      TableViewCell(
                        // Intrinsic width, left-aligned: a bare badge in a
                        // tight table cell would paint the full column width.
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Badge(
                            variant: order.badgeVariant,
                            child: Text(order.status),
                          ),
                        ),
                      ),
                      TableViewCell(child: Text(order.method)),
                      TableViewCell(child: Text(order.amount)),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
