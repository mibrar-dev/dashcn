# Shop starter (`shop`)

Auth into a product grid with cart checkout and settings.

## Routes

- `/signin` — `auth-01` flow.
- `/shop` — product grid built in the starter from components (card, badge,
  button, picture). No new kit block.
- `/cart` — `checkout-01` flow (cart, address sheet, payment, success).
- `/settings` — `settings-01` flow.

The grid adds rows to the app's own `ShopRepository`
(`lib/data/repository.dart`, marked replace-with-backend); the checkout flow
reads the cart through data plus callbacks. The kit holds no backend.

## Create

```sh
dashcn create shop my_app
dashcn create shop my_app --theme vercel --mode package
```
