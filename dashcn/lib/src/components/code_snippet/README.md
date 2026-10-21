# CodeSnippet

Scrollable code block with language syntax colouring, selectable text and a
built-in copy button. The content renders in the ambient monospace small style
on a bordered card surface. Long lines scroll horizontally inside the block
without overflowing. Widgets-only; it imports no other component.

## When to use

- Displaying code snippets, shell commands, JSON, YAML or HTML with copy actions.
- Code blocks where users need to select, copy or run commands.
- Read-only output blocks (logs, diffs use their own components).

## Snippets

Minimal (automatic syntax colouring, selectable text and copy button):

```dart
const CodeSnippet(code: Text('flutter run -d chrome'));
```

With language tag and bounds:

```dart
CodeSnippet(
  language: 'dart',
  constraints: const BoxConstraints(maxWidth: 480, maxHeight: 200),
  code: const Text('void main() => runApp(const MyApp());'),
);
```

With extra action buttons:

```dart
CodeSnippet(
  actions: [
    Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.ghost,
      onPressed: runCode,
      child: const Text('Run'),
    ),
  ],
  code: const Text('dart format .'),
);
```

## `CodeSnippet` API

| Parameter | Type | Default | Notes |
|---|---|---|---|
| `code` | `Widget` | required | code content, usually `Text` |
| `rawCode` | `String?` | null | explicit code string to copy/highlight |
| `language` | `String?` | null | language id (`dart`, `json`, `yaml`, `sh`, `js`, `html`, …) |
| `actions` | `List<Widget>` | `[]` | extra top-right action buttons |
| `showCopyButton` | `bool?` | null (theme) | whether the copy button renders |
| `copied` | `bool?` | null | controlled copy feedback state |
| `onCopiedChange` | `ValueChanged<bool>?` | null | copy state change callback |
| `onCopy` | `VoidCallback?` | null | called when copy button is activated |
| `copyButtonBuilder` | `Widget Function(BuildContext, VoidCallback, bool)?` | null | builder slot for the copy button |
| `actionsBuilder` | `Widget Function(BuildContext, List<Widget>)?` | null | builder slot for the actions row |
| `codeBuilder` | `Widget Function(BuildContext, Widget)?` | null | builder slot for the code widget |
| `constraints` | `BoxConstraints?` | null | bounds of the snippet area |
| `theme` | `CodeSnippetTheme?` | null | widget-leg theme override |

## Differences from old `code_snippet`

- Syntax colouring with ambient theme tokens (`SyntaxColors`).
- Built-in accessible, keyboard-reachable copy button with animated checkmark feedback.
- Selectable and copyable text via `SelectableRegion` and platform shortcuts.
- Directional padding (`DirectionalEdgeInsetsDensity`) for complete RTL correctness.
- Builder slots for copy button, actions and code content.
