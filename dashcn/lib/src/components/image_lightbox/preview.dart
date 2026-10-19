// Named examples for the `image_lightbox` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. The lightbox
// fills its box, so each example renders it inside a bounded frame the size of
// the docs preview stage. The images are solid-colour PNGs decoded from
// memory, so the examples render identically offline and inside a test.

import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../image/image.dart';
import 'image_lightbox.dart';

const String _redPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUElEQVR42u3PQREAAAQAMITRP5AwUni42xospzs+q3hOQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA4N4CDKIBqK4z/20AAAAASUVORK5CYII=';
const String _greenPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgIRGETo1PBQdI6aNZ0XPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9HxJZAYMtZ/JwAAAAAElFTkSuQmCC';
const String _bluePng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgXlCEfE1PBQdI6aFZPXPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9Hy4iAfMxiKoyAAAAAElFTkSuQmCC';
const String _amberPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMNiBZbTiZio4SFoHzemKy14cJyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgILDvA7hbAdZfb5ZtAAAAAElFTkSuQmCC';

final List<LightboxImage> _photos = <LightboxImage>[
  LightboxImage(
    image: MemoryImage(base64Decode(_redPng)),
    caption: 'Red sample',
    semanticLabel: 'Red sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_greenPng)),
    caption: 'Green sample',
    semanticLabel: 'Green sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_bluePng)),
    caption: 'Blue sample',
    semanticLabel: 'Blue sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_amberPng)),
    caption: 'Amber sample',
    semanticLabel: 'Amber sample image',
  ),
];

/// The default lightbox: counter, captions and the thumbnail strip.
Widget _default(BuildContext context) {
  return ImageLightbox(images: _photos);
}

/// A single image with no chrome.
Widget _minimal(BuildContext context) {
  return ImageLightbox(
    images: <LightboxImage>[_photos[1]],
    showCounter: false,
    showThumbnails: false,
  );
}

/// A customized lightbox: theme overrides and a deeper scrim.
Widget _customized(BuildContext context) {
  return ImageLightbox(
    images: _photos,
    theme: const ImageLightboxTheme(
      barrierColor: ThemedColor.value(Color(0xCC000000)),
      maxScale: 5,
      thumbnailHeight: 64,
      thumbnailBorderWidth: 3,
    ),
  );
}

/// A lightbox opened from a thumbnail grid, the way a caller uses it.
class _Gallery extends StatefulWidget {
  const _Gallery();

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: theme.spacing.md,
      runSpacing: theme.spacing.md,
      children: <Widget>[
        for (int i = 0; i < _photos.length; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showImageLightbox<void>(
              context: context,
              images: _photos,
              initialIndex: i,
            ),
            child: ClipRRect(
              borderRadius: theme.borderRadiusMd,
              child: Picture(
                image: _photos[i].image,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                semanticLabel: _photos[i].semanticLabel,
              ),
            ),
          ),
      ],
    );
  }
}

Widget _gallery(BuildContext context) => const _Gallery();

/// Named docs examples for `image_lightbox`; the first entry is the default.
const List<ComponentPreview> imageLightboxPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Minimal', _minimal),
  ComponentPreview('Customized', _customized),
  ComponentPreview('From thumbnails', _gallery),
];
