# Theming, Assets, And Platform

## Theme Presets

```bash
dashcn theme --list
dashcn theme --apply modern-minimal
dashcn sync
dashcn validate --json
```

Use semantic theme values in app code instead of hardcoded colors.

## Widget-Level Themes

```bash
dashcn theme widget --list
dashcn theme widget @dashcn button --list-targets
dashcn theme widget @dashcn button --reset
```

Advanced JSON imports require `--advanced`:

```bash
dashcn --advanced theme --apply-file ./theme.json
dashcn --advanced theme widget @dashcn button --apply-file ./button-theme.json
```

## Assets

```bash
dashcn assets --icons
dashcn assets --typography
dashcn assets --all
```

Do not manually copy font assets or hand-edit `pubspec.yaml` when CLI asset actions exist.

## Platform Targets

```bash
dashcn platform --list
dashcn platform --set ios.infoPlist=ios/Runner/Info.plist
dashcn platform --reset ios.infoPlist
```

Run `doctor --json` after platform path changes.
