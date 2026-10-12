# dashcn

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="brand/svg/lockup-on-dark.svg">
  <img src="brand/svg/lockup-on-light.svg" alt="dashcn" width="320">
</picture>

A widgets-only Flutter design system: themed components, blocks, and presets, without Material or Cupertino.

[![GitHub Repo](https://img.shields.io/badge/GitHub-shadcn_flutter_kit-black?style=for-the-badge&logo=github)](https://github.com/mibrar-dev/shadcn_flutter_kit)
[![Docs](https://img.shields.io/badge/Docs-Widget%20Catalog-blue?style=for-the-badge&logo=google-chrome&logoColor=white)](https://mibrar-dev.github.io/shadcn_flutter_kit/)
[![CLI on pub.dev](https://img.shields.io/badge/pub.dev-dashcn_cli-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/dashcn_cli)
[![GitHub Actions](https://img.shields.io/github/actions/workflow/status/mibrar-dev/shadcn_flutter_kit/docs-deploy.yml?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/mibrar-dev/shadcn_flutter_kit/actions)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](https://github.com/mibrar-dev/shadcn_flutter_kit/blob/main/LICENSE)
[![Stars](https://img.shields.io/github/stars/mibrar-dev/shadcn_flutter_kit?style=for-the-badge&logo=github)](https://github.com/mibrar-dev/shadcn_flutter_kit/stargazers)

> Badges and links still point at `mibrar-dev/shadcn_flutter_kit` until the
> repo rename lands (see `RELEASING.md` for the checklist).

---

## Install

Two ways to use the same components, from the same source.

**Package** — depend on the published package and update via semver:

```bash
flutter pub add dashcn
```

```dart
import 'package:dashcn/dashcn.dart';

void main() {
  runApp(const DashcnApp(home: SizedBox.shrink()));
}
```

Per-layer and per-component imports keep builds lean:

```dart
import 'package:dashcn/theme.dart';
import 'package:dashcn/components/button.dart';
```

**Own the code** — copy the sources into your app with the CLI:

```bash
dart pub global activate dashcn_cli
dashcn init
dashcn add button
```

Switch a package import to owned sources later with `dashcn eject button`.
See “Package or own the code?” in the docs, and the [CLI](https://pub.dev/packages/dashcn_cli)
reference for `init --mode`, `add --package`, and `theme import|export`.

---

## What's in this repo

- **`dashcn/`** — the `dashcn` package: foundation, theme, primitives,
  components, and blocks under `lib/src/`, with the `dashcn.dart` barrel
  plus per-layer and per-component libraries.
- **`docs/`** — the Flutter web docs app (Widget Catalog) showcasing every
  component, block, and theme preset.
- **`brand/`** — the dashcn logo kit (SVG sources plus generated PNG/ICO).

The [`dashcn` CLI](https://pub.dev/packages/dashcn_cli) lives in its own
repo and installs components from this one's registry, either as a package
dependency or as copied sources under `lib/ui/dashcn/`.

---

## Docs

- Website (Widget Catalog): <https://mibrar-dev.github.io/shadcn_flutter_kit/>
- Getting started: `docs/` in this repo, or `/#/docs/installation` on the site
- CLI commands: `dashcn --help`, or `/docs/cli` on the site
- Releasing: [`RELEASING.md`](RELEASING.md)
- Contributing blocks and components: [`REGISTRY_CONTRIBUTING.md`](REGISTRY_CONTRIBUTING.md)

---

## Attribution

This project is inspired by and partially derived from
[shadcn_flutter](https://github.com/sunarya-thito/shadcn_flutter) by Sunarya Thito.

Some components and patterns originated from the shadcn_flutter codebase and
have been adapted, reorganized, and extended into a registry-first architecture
with additional tooling (CLI, schema validation, and docs).

The original shadcn_flutter project is licensed under the BSD 3-Clause License.
A copy of that license is included in this repository under `licenses/`.

---

## License

This project is licensed under the MIT License.

Copyright (c) 2026 Muhammad Ibrar Javid

Third-party code adapted from other projects (such as
[shadcn_flutter](https://github.com/sunarya-thito/shadcn_flutter)) remains under
its original license terms. See the `licenses/` directory for details.

See the [LICENSE](LICENSE) file for the full MIT license text.
