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
  const Checkout01Flow({
    super.key,
    this.items = const <Checkout01CartItem>[
      Checkout01CartItem(name: 'Everyday backpack', price: 89),
      Checkout01CartItem(name: 'Insulated bottle', price: 32, quantity: 2),
      Checkout01CartItem(name: 'Desk lamp', price: 54),
    ],
    this.onRemoveItem,
    this.onAddressSaved,
    this.onPlaceOrder,
    this.onDone,
  });

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

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/payment':
            final Checkout01Order order = settings.arguments as Checkout01Order;
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
