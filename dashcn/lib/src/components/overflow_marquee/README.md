# Overflow marquee

Continuous self-scrolling content loop with soft edge fades, pause on
hover/focus, and reduced-motion support. Widgets-only: no Material, no Cupertino.

## When to use

- Continuous tickers, announcements, and news bands that stream content.
- Now-playing music tracks, long titles, and stock tickers.
- Vertical credits or looping notifications.
- Accessible marquee with keyboard focus pause and pointer hover pause.

## Snippets

```dart
// Continuous horizontal ticker with edge fade
OverflowMarquee(
  speed: 50.0,
  gap: 28.0,
  child: Text('Breaking updates streaming continuously ...'),
);

// Controlled playback with play/pause controller
final controller = MarqueeController();

OverflowMarquee(
  controller: controller,
  pauseOnHover: true,
  child: Text('Midnight City — M83 (Extended Club Mix)'),
);

// Vertical credits scrolling upwards
OverflowMarquee(
  direction: AxisDirectional.up,
  speed: 25.0,
  child: Column(
    children: [Text('Directed by ...'), Text('Produced by ...')],
  ),
);
```

## API

| Parameter | Default | Notes |
|---|---|---|
| `direction` | `AxisDirectional.start` | scroll direction (`start`, `end`, `up`, `down`, RTL-aware; also accepts legacy `Axis`) |
| `speed` | `50.0` | speed in pixels per second (overrides `step` and `duration`) |
| `gap` | `24.0` | gap between repeating copies in continuous loop |
| `pauseOnHover` | `true` | pause scrolling when mouse pointer enters |
| `pauseOnFocus` | `true` | pause scrolling when keyboard focus enters |
| `loop` | `true` | whether content loops continuously |
| `controller` | null | `MarqueeController` for external play/pause management |
| `leading` | null | builder slot placed before the scrolling marquee |
| `trailing` | null | builder slot placed after the scrolling marquee |
| `builder` | null | custom wrapper builder `(context, child)` |
| `fadePortion` | `0.1` | edge fade as a **fraction** of visible extent, clamped `0..0.5` |
| `theme` | null | widget-leg `OverflowMarqueeTheme` |

## Theming

`OverflowMarqueeTheme` follows the standard four legs: widget `theme`
argument > nearest `ComponentTheme<OverflowMarqueeTheme>` > app
`ComponentThemes` > `overflowMarqueeDefaults`. Overrides are values only; see
`overflow_marquee_theme.dart`.

## Behaviour notes

- Continuous seamless marquee: content streams across the viewport, repeating with `gap`.
- RTL aware: `AxisDirectional.start` automatically scrolls left in LTR and right in RTL.
- Reduced motion (`MediaQuery.disableAnimations`): stops the ticker, halts at start position, and truncates text with ellipsis.
- Hit testing: all visible instances in the marquee window remain interactable and tappable.
- Hover & focus: automatically pauses scrolling on hover or focus to comply with WCAG accessibility guidelines.
- Ticks repaint the render object without rebuilding the widget subtree.
