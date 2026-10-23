// The `checkout-01` flow: cart with swipe-to-delete rows, an address bottom
// sheet, payment, and a success screen.
//
// Entry: [Checkout01Flow] owns a nested [Navigator] (`/`, `/payment`,
// `/success`). Items and results travel through data + callbacks; the kit
// holds no cart backend and no demo catalogue.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/success_screen.dart';
import '../../foundation/component_preview.dart';

/// One row of the [Checkout01Flow] cart.
class Checkout01CartItem {
  /// Creates a cart row.
  const Checkout01CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  /// Display name of the item.
  final String name;

  /// Unit price of the item.
  final double price;

  /// Units in the cart.
  final int quantity;
}

/// Address collected by the cart's bottom sheet.
class Checkout01Address {
  /// Creates an address.
  const Checkout01Address({
    required this.name,
    required this.street,
    required this.city,
  });

  /// Recipient name.
  final String name;

  /// Street line.
  final String street;

  /// City line.
  final String city;
}

/// Address + total carried from the cart to the payment screen.
class Checkout01Order {
  /// Creates the payment arguments.
  const Checkout01Order({required this.address, required this.total});

  /// Address saved from the sheet.
  final Checkout01Address address;

  /// Cart total at checkout time.
  final double total;
}

/// Cart → address sheet → payment → success.
class Checkout01Flow extends StatelessWidget {
  /// Creates the flow.
  Checkout01Flow({
    super.key,
    List<Checkout01CartItem>? items,
    this.onRemoveItem,
    this.onAddressSaved,
    this.onPlaceOrder,
    this.onDone,
    this.initialScreen = '/',
  }) : items =
           items ??
           <Checkout01CartItem>[
             Checkout01CartItem(
               name: docsSample(null, 'Everyday backpack'),
               price: 89,
             ),
             Checkout01CartItem(
               name: docsSample(null, 'Insulated bottle'),
               price: 32,
               quantity: 2,
             ),
             Checkout01CartItem(name: docsSample(null, 'Desk lamp'), price: 54),
           ];

  /// Starting cart rows; the cart screen owns a mutable copy.
  final List<Checkout01CartItem> items;

  /// Called with the removed row.
  final ValueChanged<Checkout01CartItem>? onRemoveItem;

  /// Called with the validated address from the sheet.
  final Future<void> Function(Checkout01Address address)? onAddressSaved;

  /// Called with the address + total when Pay is tapped.
  final Future<void> Function(Checkout01Address address, double total)?
  onPlaceOrder;

  /// Called from the success screen.
  final VoidCallback? onDone;

  /// Initial route of the nested navigator (`/`, `/payment`, `/success`).
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/payment':
            // A bare `/payment` (e.g. a docs screen-map jump with no order
            // yet) falls back to the cart instead of throwing on the cast.
            final Object? args = settings.arguments;
            if (args is! Checkout01Order) {
              return AppPageRoute(
                settings: settings,
                builder: (_) => Checkout01CartScreen(
                  items: items,
                  onRemoveItem: onRemoveItem,
                  onAddressSaved: onAddressSaved,
                ),
              );
            }
            final Checkout01Order order = args;
            return AppPageRoute(
              settings: settings,
              builder: (_) => Checkout01PaymentScreen(
                order: order,
                onPlaceOrder: onPlaceOrder,
              ),
            );
          case '/success':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Checkout01SuccessScreen(onDone: onDone),
            );
          case '/':
          default:
            return AppPageRoute(
              settings: settings,
              builder: (_) => Checkout01CartScreen(
                items: items,
                onRemoveItem: onRemoveItem,
                onAddressSaved: onAddressSaved,
              ),
            );
        }
      },
    );
  }
}
