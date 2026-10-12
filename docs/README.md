# docs

Flutter web documentation app for the dashcn kit.

The user-facing install and command walkthrough lives in the website at
`/#/docs/installation`. Keep that page aligned with the CLI markdown guide in
`dashcn-cli/doc/user/complete-guide.md` when command behavior changes.

## Registry docs workflow

The docs app consumes the `dashcn` package registry at
`dashcn/lib/src`:

- Per-component `meta.json` lives at the component top level.
- Per-component `README.md` feeds the usage snippets and keyboard rows.
- `docs/lib/ui/dashcn` is a generated mirror of the registry. Do not edit
  files there directly.

Refresh the mirror and the generated data from `docs/`:

```bash
bash tool/sync_registry.sh
dart run tool/gen_docs_data.dart
```

Verify without writing:

```bash
bash tool/sync_registry.sh --check
dart run tool/gen_docs_data.dart --check
```

The CLI reference page renders `tool/cli_snapshot.txt`, which is pasted
from the current `dashcn` help output. Re-paste it when CLI flags change,
then re-run the generator.
