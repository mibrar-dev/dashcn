# QR Code

QR code display for a string or URL. Widgets-only: the matrix comes from the
pure-Dart `qr` package (no Flutter/material import; its only dependency is
`meta`) and painting is a plain `CustomPainter` that scales the matrix to
its box, so even a version-40 code cannot overflow.

## When to use

- Sharing a URL, contact or payment payload on screen.
- A live code that re-encodes as the user types.

For print or guaranteed scanning, pin both inks to literal colours (see
below); the defaults follow the ambient preset, including its dark mode.

## Snippets

Fixed code:

```dart
QrCode(data: 'https://example.com');
```

Levels, quiet zone, shapes and a centre logo:

```dart
QrCode(
  data: 'https://example.com',
  errorCorrectLevel: QrErrorCorrectionLevel.high,
  quietZone: 4,
  moduleShape: QrModuleShape.rounded,
  size: 200,
  center: ColoredBox(child: Center(child: Text('D'))),
  centerFraction: 0.24,
);
```

Print-safe inks:

```dart
QrCode(
  data: payload,
  foreground: Color(0xFF000000),
  background: Color(0xFFFFFFFF),
);
```

## API

| Member | Type | Default | Notes |
|---|---|---|---|
| `data` | `String` | required | empty renders a blank placeholder |
| `errorCorrectLevel` | `QrErrorCorrectionLevel` | `medium` | `low` / `medium` / `quartile` / `high` |
| `quietZone` | `int` | `4` | margin in modules (spec minimum 4) |
| `moduleShape` | `QrModuleShape` | `square` | `square` / `rounded` / `dot` |
| `foreground` / `background` | `Color?` | null | null resolves the theme |
| `size` | `double?` | null | square side; null fits the box |
| `center` | `Widget?` | null | logo over the cleared area |
| `centerFraction` | `double` | `0.24` | cleared side as a fraction of the QR side |
| `semanticsLabel` | `String?` | null | null reads `'QR code'` |
| `theme` | `QrCodeTheme?` | null | widget leg of the resolver |

`QrMatrix.encode(data, level:)` exposes the matrix (`moduleCount`,
`isDark(row, col)`, `typeNumber`) for tests and custom painters;
`QrCodePainter` exposes `totalModules` (modules including the quiet zone).

## Theme resolution

`widget (theme:) > ComponentTheme<QrCodeTheme> in tree > app overrides
(ComponentThemes) > qrCodeDefaults`, per field. Fields: `foreground`
(`foreground` token), `background` (`background` token).

## Getting started

1. Install the component (`dashcn add qr_code`) or copy the folder
   into `lib/ui/dashcn/qr_code/`.
2. Import `qr_code.dart`; it re-exports the matrix and the theme.
3. App-wide overrides go in `qr_code_theme.dart`; per-subtree overrides use
   `ComponentTheme<QrCodeTheme>(data: ..., child: ...)`.
