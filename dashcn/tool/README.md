# Tooling Layout

- `tool/registry/` — the generated registry manifest and the package barrel.
- `tool/rearch/` — re-architecture guardrails (`check_layers`,
  `check_single_owner`, `check_user_theme`, `api_snapshot`) and
  `gen_app_theme.dart`.

Run all of them from `dashcn/`. The package tree is the flat
`lib/src/{foundation,theme,primitives,components,themes}` layout.
