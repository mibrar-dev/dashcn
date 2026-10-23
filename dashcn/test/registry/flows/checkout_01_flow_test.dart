// End-to-end test for the `checkout-01` flow.
//
// Walks every screen in light + dark and LTR + RTL: cart with swipe-to-delete
// rows (action tap + dismiss fling), the address bottom sheet (drag + save),
// payment with validation, and success. Asserts callbacks fire with the right
// data.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/pinned_sheet/pinned_sheet.dart';
import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/flows/checkout-01/flow.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flows_support.dart';

const ValueKey<String> _name = ValueKey<String>('checkout01.address.name');
const ValueKey<String> _street = ValueKey<String>('checkout01.address.street');
const ValueKey<String> _city = ValueKey<String>('checkout01.address.city');
const ValueKey<String> _number = ValueKey<String>('checkout01.pay.number');
const ValueKey<String> _expiry = ValueKey<String>('checkout01.pay.expiry');
const ValueKey<String> _cvc = ValueKey<String>('checkout01.pay.cvc');

List<Checkout01CartItem> _items() => const <Checkout01CartItem>[
  Checkout01CartItem(name: 'Everyday backpack', price: 89),
  Checkout01CartItem(name: 'Insulated bottle', price: 32, quantity: 2),
  Checkout01CartItem(name: 'Desk lamp', price: 54),
];

/// Width of one revealed action (1 x 64 px readable tile per row).
const double _actionsWidth = 64;

void main() {
  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('walk ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        final removed = <String>[];
        final saved = <Checkout01Address>[];
        final placed = <List<Object>>[];
        var done = 0;
        await pumpFlow(
          tester,
          Checkout01Flow(
            items: _items(),
            onRemoveItem: (Checkout01CartItem item) => removed.add(item.name),
            onAddressSaved: (Checkout01Address address) async =>
                saved.add(address),
            onPlaceOrder: (Checkout01Address address, double total) async =>
                placed.add(<Object>[address, total]),
            onDone: () => done++,
          ),
          brightness: brightness,
          direction: direction,
        );

        // Cart with three rows and the full total.
        expect(find.text('Your cart'), findsOneWidget);
        expect(find.byType(SwipeActions), findsNWidgets(3));
        expect(find.text('Pay \$207.00'), findsNothing);

        // Swipe reveals the row actions (gesture; the row's translate
        // transform verifies the reveal), then tapping Delete fires it.
        final Finder backpackRow = find.byKey(
          const ValueKey<String>('checkout01.row.Everyday backpack'),
        );
        await dragOpen(
          tester,
          backpackRow,
          direction,
          totalWidth: _actionsWidth,
        );
        await settleSwipeOpen(
          tester,
          backpackRow,
          direction,
          totalWidth: _actionsWidth,
        );
        await tester.tap(
          find.descendant(of: backpackRow, matching: find.text('Delete')),
        );
        await flowSettle(tester);
        expect(removed, <String>['Everyday backpack']);
        expect(find.byType(SwipeActions), findsNWidgets(2));

        // Checkout opens the address sheet; a drag keeps it alive.
        await tester.tap(
          find.byKey(const ValueKey<String>('checkout01.checkout')),
        );
        await flowSettle(tester);
        expect(find.text('Delivery address'), findsOneWidget);
        await tester.drag(find.byType(PinnedSheet), const Offset(0, 150));
        await flowSettle(tester);
        expect(find.text('Delivery address'), findsOneWidget);

        // Saving needs a valid address, then payment shows the new total.
        await tester.tap(
          find.byKey(const ValueKey<String>('checkout01.address.save')),
        );
        await flowSettle(tester);
        expect(saved, isEmpty);
        expect(find.text('Payment'), findsNothing);
        await tester.enterText(fieldOf(_name), 'Ada Lovelace');
        await tester.enterText(fieldOf(_street), '12 Bernoulli Lane');
        await tester.enterText(fieldOf(_city), 'Springfield');
        await tester.tap(
          find.byKey(const ValueKey<String>('checkout01.address.save')),
        );
        await flowSettle(tester);
        expect(saved.length, 1);
        expect(saved.single.street, '12 Bernoulli Lane');
        expect(find.text('Payment'), findsOneWidget);
        expect(find.text('Pay \$118.00'), findsOneWidget);

        // Pay validates first, then places the order and succeeds.
        await tester.tap(find.byKey(const ValueKey<String>('checkout01.pay')));
        await flowSettle(tester);
        expect(placed, isEmpty);
        expect(find.text('Order placed'), findsNothing);
        await tester.enterText(fieldOf(_number), '4242424242424242');
        await tester.enterText(fieldOf(_expiry), '12/28');
        await tester.enterText(fieldOf(_cvc), '123');
        await tester.tap(find.byKey(const ValueKey<String>('checkout01.pay')));
        await flowSettle(tester);
        expect(placed.length, 1);
        expect((placed.single[1] as double), 118.0);
        expect(find.text('Order placed'), findsOneWidget);
        await tester.tap(find.byKey(const ValueKey<String>('checkout01.done')));
        await flowSettle(tester);
        expect(done, 1);
      });

      testWidgets('dismiss fling ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        final removed = <String>[];
        await pumpFlow(
          tester,
          Checkout01Flow(
            items: _items(),
            onRemoveItem: (Checkout01CartItem item) => removed.add(item.name),
          ),
          brightness: brightness,
          direction: direction,
        );
        await tester.fling(
          find.byKey(const ValueKey<String>('checkout01.row.Desk lamp')),
          direction == TextDirection.rtl
              ? const Offset(400, 0)
              : const Offset(-400, 0),
          2000,
        );
        await flowSettle(tester);
        expect(removed, <String>['Desk lamp']);
        expect(find.byType(SwipeActions), findsNWidgets(2));
      });
    }
  }

  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('form errors show only after submit ${brightness.name} '
          '${direction.name}', (WidgetTester tester) async {
        await pumpFlow(
          tester,
          Checkout01Flow(items: _items()),
          brightness: brightness,
          direction: direction,
        );

        // The address sheet starts pristine; empty save reveals errors.
        await tester.tap(
          find.byKey(const ValueKey<String>('checkout01.checkout')),
        );
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsNothing);
        await tester.tap(
          find.byKey(const ValueKey<String>('checkout01.address.save')),
        );
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsWidgets);

        // Payment starts pristine; empty pay reveals errors.
        await tester.enterText(fieldOf(_name), 'Ada Lovelace');
        await tester.enterText(fieldOf(_street), '12 Bernoulli Lane');
        await tester.enterText(fieldOf(_city), 'Springfield');
        await tester.tap(
          find.byKey(const ValueKey<String>('checkout01.address.save')),
        );
        await flowSettle(tester);
        expect(find.text('Payment'), findsOneWidget);
        expect(find.text('This field cannot be empty.'), findsNothing);
        await tester.tap(find.byKey(const ValueKey<String>('checkout01.pay')));
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsWidgets);
      });
    }
  }
}
