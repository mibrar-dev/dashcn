# Checkout 01 (`checkout-01`)

Cart with swipe-to-delete rows, an address bottom sheet, payment and a
success screen. Mobile-first; centres at desktop widths.

## Files

- `flow.dart` — `Checkout01Flow` (owns the nested `Navigator`),
  `Checkout01CartItem`, `Checkout01Address`, `Checkout01Order`.
- `screens/cart_screen.dart`, `screens/address_sheet.dart`,
  `screens/payment_screen.dart`, `screens/success_screen.dart`

## Install

```sh
dashcn add flow:checkout-01
```

```dart
import 'package:<your_app>/ui/dashcn/flows/checkout-01/flow.dart';

Checkout01Flow(
  items: const [Checkout01CartItem(name: 'Backpack', price: 89)],
  onRemoveItem: (item) => remove(item),
  onAddressSaved: (address) => save(address),
  onPlaceOrder: (address, total) => pay(address, total),
)
```

## Declared dependencies

| Layer | Units |
|---|---|
| `foundation` | `gap`, `icons` |
| `theme` | `theme` |
| `components` | `button`, `card`, `drawer_container`, `empty_state`, `form`, `input`, `page_route`, `pinned_sheet`, `swipe_actions` |

## Notes

The flow takes items + callbacks in; there is no cart backend and no demo
catalogue in the kit. `/` cart, `/payment`, `/success`; the address form is
a `PinnedSheet` over the cart.
