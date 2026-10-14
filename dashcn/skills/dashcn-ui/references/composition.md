# Component Composition Rules

## App Shell

Install app-level primitives before overlay-heavy screens:

```bash
dashcn add @dashcn/app @dashcn/scaffold @dashcn/card
```

Use one app-scope wrapper where overlay components are used:

- `DashcnApp`
- `AppLayer`
- `OverlayManagerLayer`

## Overlay Components

Overlay-dependent components include dialog, alert dialog, drawer, popover, popup, tooltip, refresh trigger, hover card, toast, menu, menubar, context menu, dropdown menu, and swiper.

Install and verify:

```bash
dashcn dry-run @dashcn/dialog @dashcn/drawer @dashcn/toast --json
dashcn add @dashcn/dialog @dashcn/drawer @dashcn/toast
```

## Prefer Registry Composition

- Use `layout/scaffold`, `layout/card`, `layout/basic`, `layout/flex`, and `layout/stage_container` before hand-building shells.
- Use `control/button`, `display/icon`, `display/text`, and `display/badge` for common controls.
- Use `overlay/menu`, `overlay/dropdown_menu`, and `overlay/context_menu` for action menus.
- Use `navigation/tabs`, `navigation/breadcrumb`, `navigation/pagination`, and `navigation/navigation_menu` for navigation.

## Safe Removal

```bash
dashcn remove @dashcn/form_field
```

Only use:

```bash
dashcn remove @dashcn/form_field --force
```

when dependency constraints are intentionally overridden.
