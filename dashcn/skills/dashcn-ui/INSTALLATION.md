# Install The Flutter dashcn UI Skill

This skill ships with `dashcn_cli` and can be installed into AI model folders from any Flutter project.

```bash
dart pub global activate dashcn_cli
dashcn --advanced install-skill --available
dashcn --advanced install-skill --skill dashcn-ui --model .codex
```

For local repo development:

```bash
dart run bin/dashcn.dart --advanced install-skill --skill dashcn-ui --model .codex
```

Remote kit source fallback:

```bash
dashcn --advanced install-skill \
  --skills-url https://raw.githubusercontent.com/mibrar-dev/shadcn_flutter_kit/main/dashcn/skills \
  --skill dashcn-ui \
  --model .codex
```

Verify:

```bash
dashcn --advanced install-skill --list
```
