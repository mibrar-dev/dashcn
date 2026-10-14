# CLI Workflows For UI Agents

## Initialization

Always initialize a target Flutter project before installing components.

```bash
flutter pub get
dashcn init --yes
```

For a specific namespace:

```bash
dashcn init dashcn --yes
```

`init` creates `.dashcn/config.json`, `.dashcn/state.json`, shared install paths, and inline bootstrap files required by later `add` operations.

## Context Validation

```bash
dashcn registries --json
dashcn default
dashcn doctor --json
```

Do not continue to `add` if initialization or `doctor --json` reports broken setup.

## Discovery

```bash
dashcn list @dashcn --json
dashcn search @dashcn button --json
dashcn info @dashcn/button --json
```

## Install

```bash
dashcn dry-run @dashcn/button --json
dashcn add @dashcn/button
dashcn validate --json
dashcn audit --json
dashcn deps --json
```

For multi-component screens:

```bash
dashcn dry-run @dashcn/card @dashcn/button --json
dashcn add @dashcn/card @dashcn/button
dashcn validate --json
dashcn audit --json
dashcn deps --json
```

## Required Agent Order

1. `flutter pub get`
2. `dashcn init --yes`
3. `dashcn registries --json`
4. `dashcn default`
5. `dashcn doctor --json`
6. `dashcn list` / `search` / `info`
7. `dashcn dry-run ... --json`
8. `dashcn add ...`
9. `dashcn validate --json`
10. `dashcn audit --json`
11. `dashcn deps --json`

## Remove

```bash
dashcn remove @dashcn/dialog
```

Use `--force` only after confirming dependency consequences.

## Refresh Components

There is no dedicated update command:

```bash
dashcn init --yes
dashcn doctor --json
dashcn dry-run @dashcn/button --json
dashcn add @dashcn/button
dashcn audit --json
dashcn deps --json
```
