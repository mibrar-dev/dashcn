# Button

Pressable action control with seven variants and five fixed sizes, built on
the `Clickable` primitive (hover, press, keyboard, focus ring, semantics).
Widgets-only: no Material, no Cupertino, no component-to-component imports.

## When to use

- A one-shot action (`Save`, `Delete`, `Next`) that fires a callback.
- An inline link-styled action or a muted text action.
- Several connected actions — wrap them in `ButtonGroup`.

On/off state belongs to the separate `Toggle` component; navigation entries
belong to the navigation components.

## Snippets

Minimal:

```dart
Button(onPressed: save, child: const Text('Save'));
```

Variant, size and icon:

```dart
Button(
  variant: ButtonVariant.outline,
  size: ButtonSize.sm,
  leading: const Icon(LucideIcons.plus, size: 16),
  onPressed: addItem,
  child: const Text('Add item'),
);
```

Connected group (first/last keep their radius, inner edges flatten):

```dart
ButtonGroup(
  children: <Widget>[
    Button(variant: ButtonVariant.outline, onPressed: prev, child: const Text('Prev')),
    Button(variant: ButtonVariant.outline, onPressed: next, child: const Text('Next')),
  ],
);
```

Async work with the status machine (idle → loading → success/failure):

```dart
Button(
  onPressedAsync: () async {
    await save();
  },
  successLabel: const Text('Saved'),
  onAsyncError: (Object error, StackTrace stack) => log(error),
  child: const Text('Save changes'),
);
```

Controlled status (the parent owns the machine):

```dart
Button(
  status: state,
  onPressed: advance,
  child: const Text('Checkout'),
);
```

Validated form submit (return = success, throw = failure):

```dart
Button(
  onPressedAsync: () async {
    final SubmissionResult result = await controller.submit(context);
    if (!result.isValid) {
      focusFirstInvalid(result.errors);
      throw StateError('Submit failed: form is invalid.');
    }
  },
  child: const Text('Sign in'),
);
```

## `Button` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `child` | `Widget` | required | label or icon |
| `variant` | `ButtonVariant` | `primary` | `primary, secondary, outline, ghost, link, text, destructive` |
| `size` | `ButtonSize` | `md` | `xs, sm, md, lg, icon` (icon = square 36) |
| `onPressed` | `VoidCallback?` | null | null disables unless `enabled` is set |
| `onPressedAsync` | `Future<void> Function()?` | null | return = success, throw = failure; loading disables |
| `status` | `ButtonStatus?` | null | non-null = controlled, parent owns the machine |
| `successLabel` / `failureLabel` | `Widget?` | null | replaces the label in that state; null keeps `child` |
| `statusResetDuration` | `Duration?` | 1.5s | auto-reset to idle; null stays on the end state |
| `onStatusChanged` | `ValueChanged<ButtonStatus>?` | null | every status entered, from either leg |
| `onAsyncError` | `Function(Object, StackTrace)?` | null | error thrown by `onPressedAsync` |
| `onLongPress` | `VoidCallback?` | null | ignored while disabled |
| `onHover` / `onFocusChange` | `ValueChanged<bool>?` | null | observation only |
| `leading` / `trailing` | `Widget?` | null | auto-spaced with `theme.spacing.sm` |
| `focusNode` | `FocusNode?` | null | internal `Clickable` node when null |
| `autofocus` | `bool` | false | requests focus after the first frame |
| `enabled` | `bool?` | null | null means `onPressed != null` |
| `theme` | `ButtonVariantStyle?` | null | widget leg of the resolver |

Rare gestures (`onTapDown`, secondary/tertiary clicks) go through an outer
`GestureDetector`, per the new architecture's callback policy.

## Size table

| Size | Horizontal padding | Text | Min height |
|---|---|---|---|
| `xs` | 8 | 14 / w500 | 28 |
| `sm` | 12 | 14 / w500 | 32 |
| `md` | 16 | 14 / w500 | 36 |
| `lg` | 24 | 14 / w500 | 40 |
| `icon` | 0 | — | 36 x 36 |

Heights match dashcn `h-7`/`h-8`/`h-9`/`h-10`; the height comes from
`minHeight` (vertical padding is zero so outline borders do not inflate
it). All sizes use 14 / w500 text.

On touch platforms the button grows with transparent hit padding (iOS 44,
Android 48) via `TouchHitArea`; the painted size never changes. Opt out per
app with `ThemeData(touchTargets: TouchTargets.shrinkWrap)`.

Global `Density.baseContentPadding` scales the padding; `ButtonTheme` may
override `padding` and `textStyle` per variant.

## Status machine

`enum ButtonStatus { idle, loading, success, failure }`.

Uncontrolled (`onPressedAsync`): press enters loading synchronously — the
button hugs the spinner + gap + label and disables — then success (check
icon + gap + label, optional `successLabel`) or failure (x icon + gap +
label, destructive tint for non-destructive variants, optional
`failureLabel`). The width glides between states (`AnimatedSize` ease-out
over the status transition; instant under reduced motion); siblings in a
row move with the animation and full-width buttons keep the parent width.
A parent narrower than the content shrinks the label (it wraps) instead of
overflowing; roomy layouts hug the full label exactly as before. The
thrown error reaches `onAsyncError` and is never rethrown. Success/failure
auto-reset to idle after `statusResetDuration` (default 1.5s; null stays).
`onStatusChanged` fires for every transition.

Controlled (`status:`): the button renders the parent-owned status and never
changes it internally; `onPressedAsync` still runs as the press trigger
(errors go to `onAsyncError`). Loading still disables the button.

Icon buttons (icon size, no leading/trailing) cross-fade the child itself
inside the fixed 36 box; `ButtonGroup` items share the same core. `Toggle`
is a separate component and stays out of this machine.

Motion and a11y: the width glides over 150–200ms (`AnimatedSize` ease-out;
instant under reduced motion) while the incoming icon/label fades in over
`ButtonStatusStyle.transitionDuration` (zero under reduced motion, when the
loading spinner is replaced by a static glyph); the outgoing visual drops
instantly so no stale spinner or announcement lingers in the tree. Status
changes announce through a live region (`Loading`/`Success`/`Failure`); the
row follows text direction (RTL mirrors the icon).

## Theme resolution

`widget (theme:) > ComponentTheme<ButtonTheme> in tree > app overrides
(button_theme.dart through ComponentThemes) > buttonDefaults`, merged per
field and per state with receiver-wins `Mergeable.merge`. The `status` slice
resolves through the same legs (`widget` leg carries no status; per-subtree
and app legs do) against `buttonStatusDefaults`. Disabled is not a
colour row: every `StateValue` falls back to `rest` and the whole button is
drawn at `opacity 0.5` (dashcn `disabled:opacity-50`).

| `ButtonTheme` field | Default |
|---|---|
| `primary..destructive` | one `ButtonVariantStyle` row per variant (token refs only) |
| `background` | primary: `primary`, hover/press `primary@0.9`; secondary `@0.8`; outline `input@0.3/0.5`; ghost `muted@0/0.8`; destructive `destructive@0.9`; link/text none |
| `foreground` | primary/secondary/destructive use their `*Foreground`; outline/ghost/link `foreground`; text `mutedForeground`, hover `primary` |
| `borderColor` / `borderWidth` | outline: `input` / 1.0; others none |
| `decoration` | link: underline on hover/press |
| `padding` / `textStyle` | null = size table |
| `status` | cross-variant async visuals (`ButtonStatusStyle`) |
| `status.spinnerSize` / `status.statusIconSize` | 16 / 16 |
| `status.successIcon` / `status.failureIcon` / `status.loadingIcon` | check / x / loaderCircle (static glyph under reduced motion) |
| `status.successColor` / `status.loadingColor` | null = button foreground |
| `status.failureColor` | null = destructive (foreground for the destructive variant) |
| `status.transitionDuration` | 175ms cross-fade |

## Differences from the old button (`registry/components/control/button`)

Deleted:

- The 8 named constructors (`Button.primary` … `Button.card`, `Button.fixed`)
  — one constructor plus `variant`.
- `PrimaryButton`, `SecondaryButton`, `OutlineButton`, `GhostButton`,
  `LinkButton`, `TextButton`, `DestructiveButton`, `FixedButton`,
  `CardButton`, `IconButton.*`, `TabButton`, `SelectedButton`.
- `ButtonSize` scale-factor class and `ButtonDensity` (8 densities),
  `AbstractButtonStyle` / `ButtonStyle` and the `Styleable` override
  machinery, `button_state.dart` (state now lives in `Clickable`).

Changed:

- `ButtonGroup` is part of the `button` component (`button_group.dart`), not
  an independently installable component; `ButtonGroupData` is applied by
  `Button` to its resolved radius.
- `Toggle` and `SelectedButton` moved to the separate `toggle` component;
  `SelectedButton.selectedStyle` maps to `Toggle.activeStyle`.

Fixed (not ported):

- Destructive text was hardcoded `Colors.white` — now the
  `destructiveForeground` token.
- Hover alphas follow dashcn (`/90` primary+destructive, `/80` secondary);
  destructive rest was `@0.5`, now the full token.
- Disabled colors were unreadable combinations (primary `mutedForeground`
  background); now rest colours + whole-button opacity.
- Material/Cupertino imports are gone; icons inherit the resolved foreground
  through the `Clickable` icon theme.

## Getting started

1. Install the component (`dashcn add button`) or copy the folder into
   `lib/ui/dashcn/button/`.
2. Import `button.dart` — it re-exports the style surface (`ButtonVariant`,
   `ButtonSize`, `ButtonTheme`, `ButtonVariantStyle`, `buttonDefaults`).
3. App-wide overrides go in the user-owned `button_theme.dart` and are listed
   in `ComponentThemes`; per-subtree overrides use
   `ComponentTheme<ButtonTheme>(data: ..., child: ...)`.
