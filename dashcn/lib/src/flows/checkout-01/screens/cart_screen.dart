// Cart screen of the `checkout-01` flow: swipe-to-delete rows, totals, and
// the address bottom sheet.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/drawer_container/drawer_container.dart';
import '../../../components/empty_state/empty_state.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../components/swipe_actions/swipe_actions.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import 'address_sheet.dart';
import '../../../primitives/localizations/localizations.dart';

/// Cart rows; Checkout opens the address sheet.
class Checkout01CartScreen extends StatefulWidget {
  /// Creates the cart screen.
  const Checkout01CartScreen({
    super.key,
    required this.items,
    this.onRemoveItem,
    this.onAddressSaved,
  });

  /// Starting rows; the screen owns a mutable copy.
  final List<Checkout01CartItem> items;

  /// Called with the removed row.
  final ValueChanged<Checkout01CartItem>? onRemoveItem;

  /// Called with the validated address from the sheet.
  final Future<void> Function(Checkout01Address address)? onAddressSaved;

  @override
  State<Checkout01CartScreen> createState() => _Checkout01CartScreenState();
}

class _Checkout01CartScreenState extends State<Checkout01CartScreen> {
  late final List<Checkout01CartItem> _items = List.of(widget.items);
  final SheetController _sheet = SheetController();
  bool _sheetOpen = false;

  @override
  void dispose() {
    _sheet.dispose();
    super.dispose();
  }

  double get _total {
    var total = 0.0;
    for (final Checkout01CartItem item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void _remove(Checkout01CartItem item) {
    setState(() => _items.remove(item));
    widget.onRemoveItem?.call(item);
  }

  Future<void> _saveAddress(Checkout01Address address) async {
    await widget.onAddressSaved?.call(address);
    if (!mounted) {
      return;
    }
    setState(() => _sheetOpen = false);
    Navigator.of(context).pushNamed(
      '/payment',
      arguments: Checkout01Order(address: address, total: _total),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(appTheme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        strings.blockYourCart,
                        style: appTheme.typography.h3,
                      ),
                      Gap(appTheme.spacing.xs),
                      Text(
                        '${_items.length} items',
                        style: appTheme.typography.textMuted.copyWith(
                          color: appTheme.colors.mutedForeground,
                        ),
                      ),
                      Gap(appTheme.spacing.lg),
                      if (_items.isEmpty)
                        EmptyState(
                          title: Text(strings.blockCartEmpty),
                          description: Text(strings.blockAddSomethingFirst),
                        )
                      else
                        Expanded(
                          child: ListView.separated(
                            itemCount: _items.length,
                            separatorBuilder: (_, _) =>
                                Gap(appTheme.spacing.sm),
                            itemBuilder: (BuildContext context, int index) {
                              final Checkout01CartItem item = _items[index];
                              return SwipeActions(
                                key: ValueKey<String>(
                                  'checkout01.row.${item.name}',
                                ),
                                actions: <SwipeAction>[
                                  SwipeAction(
                                    label: strings.menuDelete,
                                    destructive: true,
                                    onPressed: () => _remove(item),
                                  ),
                                ],
                                onDismissed: () => _remove(item),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      appTheme.spacing.md,
                                    ),
                                    child: _Row(item: item),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      Gap(appTheme.spacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            strings.chartTotalLabel,
                            style: appTheme.typography.h3,
                          ),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: appTheme.typography.h3,
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.md),
                      Button(
                        key: const ValueKey<String>('checkout01.checkout'),
                        onPressed: _items.isEmpty
                            ? null
                            : () => setState(() => _sheetOpen = true),
                        child: Text(strings.blockCheckout),
                      ),
                    ],
                  ),
                ),
                if (_sheetOpen)
                  PinnedSheet(
                    controller: _sheet,
                    initialStage: const SheetStage.expanded(),
                    child: DrawerContainer(
                      child: Checkout01AddressSheet(
                        controller: _sheet,
                        onClose: () => setState(() => _sheetOpen = false),
                        onSaved: _saveAddress,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One cart row: name, quantity and line price.
class _Row extends StatelessWidget {
  const _Row({required this.item});

  final Checkout01CartItem item;

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.name, style: appTheme.typography.textSmall),
              Text(
                strings.blockQty(item.quantity),
                style: appTheme.typography.textMuted.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        Text(
          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
          style: appTheme.typography.textSmall,
        ),
      ],
    );
  }
}
