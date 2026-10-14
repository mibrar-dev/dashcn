# Install the Flutter DashCN Kit Skill for Claude Code

This skill gives Claude Code deep knowledge of the `dashcn` component registry — all 133 components, import patterns, theming, and example pages — so it can build Flutter UI screens without re-exploring the project each session.

## Prerequisites

- [Claude Code](https://claude.ai/code) installed
- `dashcn_cli` activated globally:
  ```bash
  dart pub global activate dashcn_cli
  ```

## Install

```bash
dashcn --advanced install-skill --available
dashcn --advanced install-skill --skill dashcn-kit --model claude
```

This copies the skill files into `~/.claude/skills/dashcn-kit/`. Claude Code picks them up automatically on the next session.

## Verify

```bash
dashcn --advanced install-skill --list
```

You should see `dashcn-kit` listed as installed for the `claude` model target.

## For local repo development

```bash
dart run bin/dashcn.dart --advanced install-skill --skill dashcn-kit --model claude
```

## Remote source fallback

```bash
dashcn --advanced install-skill \
  --skills-url https://raw.githubusercontent.com/mibrar-dev/dashcn/main/dashcn/skills \
  --skill dashcn-kit \
  --model claude
```

## What gets installed

```
~/.claude/skills/dashcn-kit/
├── SKILL.md                          # Core skill — always loaded when triggered
└── references/
    ├── components-catalog.md         # Full API reference for all 133 components
    └── example-pages.md              # 5 complete example screens
```

## What the skill does

Once installed, when you work in any Flutter project that uses `dashcn`, Claude will:

- Know the correct import patterns (including `hide Card, TextField`)
- Know all component APIs without needing to read preview files
- Follow the correct `Select`, `Dialog`, `Tabs`, and `Alert` patterns
- Build complete pages using the standard layout shell
- Read `references/` when you ask about a specific component or want a full example

## Uninstall

```bash
rm -rf ~/.claude/skills/dashcn-kit
```
