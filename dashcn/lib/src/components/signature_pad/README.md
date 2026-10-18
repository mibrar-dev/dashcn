# Signature Pad

Freehand signature capture with midpoint-quadratic smoothing and
speed-based stroke width. Widgets-only, built on `GestureDetector` and a
`CustomPaint` rasterizer shared with PNG export.

## When to use

- Collecting a signature at checkout, onboarding or consent.
- Any freehand capture that must export to PNG bytes or an SVG path.

For a read-only committed signature, pass `readOnly: true` (input ignored,
surface stays vivid). For an unavailable pad, pass `enabled: false` (input
ignored and the surface dims).

## Snippets

Capture with undo/redo/clear:

```dart
final SignaturePadController controller = SignaturePadController();

SignaturePad(controller: controller, onChanged: (count) => ...);
Button(onPressed: controller.undo, child: Text('Undo'));
Button(onPressed: controller.redo, child: Text('Redo'));
Button(onPressed: controller.clear, child: Text('Clear'));
```

Export:

```dart
// SVG path data for the `d` attribute (pair with linecap round).
final String d = controller.toSvgPath();

// PNG bytes at the pad's own size.
final Uint8List png = await controller.toPngBytes(
  size: context.size!,
  background: Colors.white,
);
```

Restore a saved signature:

```dart
controller.addStroke(savedStroke);
```

## API

| Member | Type | Default | Notes |
|---|---|---|---|
| `controller` | `SignaturePadController?` | null | owned internally when null |
| `strokeColor` / `background` | `Color?` | null | null resolves the theme |
| `strokeWidth` | `double?` | null | rest width, default 3 |
| `minStrokeWidth` | `double?` | null | at-speed width, default 1 |
| `variableWidth` | `bool?` | null | narrow with speed, default true |
| `height` | `double` | `200` | pad height (× `scaling`) |
| `enabled` / `readOnly` | `bool` | `true` / `false` | both ignore input |
| `onChanged` | `ValueChanged<int>?` | null | stroke count after every mutation |
| `semanticsLabel` | `String?` | null | null reads `'Signature pad'` |
| `theme` | `SignaturePadTheme?` | null | widget leg of the resolver |

`SignaturePadController`: `strokes`, `strokeCount`, `isEmpty`, `canUndo`,
`canRedo`, `addStroke(stroke)`, `undo()`, `redo()`, `clear()`,
`toSvgPath()`, `toPngBytes(size:, background:, pixelRatio:)`.
`SignaturePoint(position, time)` samples drive the speed-based width;
`signatureStrokeWidths(stroke)` and `paintSignatureStrokes(canvas, strokes)`
are public so custom layouts and exporters reuse them.

## Theme resolution

`widget (theme:) > ComponentTheme<SignaturePadTheme> in tree > app
overrides (ComponentThemes) > signaturePadDefaults`, per field. Fields:
`strokeColor` (`foreground`), `background` (`card`), `borderColor`
(`border`), `borderWidth` (1), `borderRadius` (8), `strokeWidth` (3),
`minStrokeWidth` (1), `variableWidth` (true).

## Getting started

1. Install the component (`dashcn add signature_pad`) or copy the folder
   into `lib/ui/dashcn/signature_pad/`.
2. Import `signature_pad.dart`; it re-exports the controller and theme.
3. App-wide overrides go in `signature_pad_theme.dart`; per-subtree overrides
   use `ComponentTheme<SignaturePadTheme>(data: ..., child: ...)`.
