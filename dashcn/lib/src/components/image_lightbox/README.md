# image_lightbox

A full-screen image viewer opened from a thumbnail with a hero-like
scale+fade transition. Pinch or scroll to zoom, drag to pan, double-tap to
toggle zoom, swipe between images, and close on Escape, the backdrop or the ×
button. Captions, a counter and a thumbnail strip are optional chrome.

Images render through the `image` component's `Picture`, so loading and error
slots behave exactly like everywhere else in the kit.

## Getting started

Open it from a thumbnail:

```dart
GestureDetector(
  onTap: () => showImageLightbox<void>(
    context: context,
    images: photos,
    initialIndex: 0,
  ),
  child: Picture(image: photos[0].image, width: 72, height: 72),
)
```

Or render it directly:

```dart
ImageLightbox(
  images: photos,
  initialIndex: 0,
  onChanged: (index) => print(index),
)
```

## API

| Member | Type | Notes |
|---|---|---|
| `images` | `List<LightboxImage>` | Required. The images to show. |
| `initialIndex` | `int` | The image to open on. |
| `showThumbnails` | `bool` | Thumbnail strip. Default true. |
| `showCounter` | `bool` | Counter. Default true. |
| `minScale` / `maxScale` | `double` | Zoom range. Defaults 1 / 4. |
| `doubleTapScale` | `double` | Double-tap zoom target. Default 2. |
| `onChanged` | `ValueChanged<int>?` | Current image index on page change. |
| `scrimBuilder` | `LightboxScrimBuilder?` | Replaces the scrim behind the image. |
| `imageBuilder` | `LightboxImageBuilder?` | Replaces the main image content. |
| `captionBuilder` | `LightboxCaptionBuilder?` | Replaces the caption. |
| `counterBuilder` | `LightboxCounterBuilder?` | Replaces the `n / total` counter. |
| `closeButtonBuilder` | `LightboxCloseBuilder?` | Replaces the close button. |
| `thumbnailBuilder` | `LightboxThumbnailBuilder?` | Replaces one thumbnail. |
| `theme` | `ImageLightboxTheme?` | Widget-leg theme override. |

`LightboxImage` carries `image` (the `ImageProvider`), an optional `caption`
and a `semanticLabel`.

## Theme

`ImageLightboxTheme` (see `image_lightbox_style.dart`) with four resolving
legs — widget argument > nearest `ComponentTheme<ImageLightboxTheme>` >
`ComponentThemes` app entry > `imageLightboxDefaults`:

| Field | Default |
|---|---|
| `barrierColor` | 60% black |
| `surfaceColor` | `background` token (frosted) |
| `foreground` | `foreground` token |
| `mutedForeground` | `mutedForeground` token |
| `closeButtonColor` | `foreground` token |
| `closeButtonBackground` | `background` token |
| `thumbnailBorderRadius` | `radiusMd` |
| `thumbnailBorderWidth` | 2 |
| `thumbnailBorderColor` | `accent` token |
| `thumbnailHeight` | 56 |
| `minScale` / `maxScale` | 1 / 4 |
| `doubleTapScale` | 2 |
| `transitionDuration` | 250 ms |
| `zoomDuration` | 150 ms |
| `showThumbnails` / `showCounter` | true / true |
| `captionPadding` | 12h / 8v |

Customise app-wide in `image_lightbox_theme.dart` (values only, never
overwritten by a CLI update).

## Gestures

| Gesture | Action |
|---|---|
| Pinch / scroll | Zoom (1x–4x) |
| Drag (zoomed in) | Pan |
| Double-tap | Toggle 1x ↔ 2x |
| Horizontal swipe | Previous / next image |
| Single tap on image | Close |
| Escape / backdrop / × | Close |

## Notes

- The open transition is a hero-like scale+fade route transition timed by the
  theme motion tokens; under reduced motion the route snaps.
- The caption/thumbnail chrome is a frosted surface through the shared surface
  primitive, so the ambient `surfaceOpacity` / `surfaceBlur` apply.
