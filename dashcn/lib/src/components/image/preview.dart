// Named examples for the `image` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'image.dart';

/// A 48x48 PNG decoded from memory: the preview never hits the network, so it
/// renders identically offline and inside a widget test.
const String _imagePhotoBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAWElEQVR42u3OoRGAMBBFwdPURBHoFIaj'
    'KTS9hBL+ROTUzjz/ts7xxZ73js1x5eqIFRAQEBAQ0CKoczarYkBAQEBAQKugzhkQEBAQENAWUOMMCAgIC'
    'AhoQz/vbpR28UARAAAAAABJRU5ErkJggg==';

/// Local photo provider shared by the examples.
final ImageProvider _imagePhoto = MemoryImage(base64Decode(_imagePhotoBase64));

/// The default square avatar-shaped image.
Widget _imageDefault(BuildContext context) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Picture(
      image: _imagePhoto,
      width: 96,
      height: 96,
      aspectRatio: 1,
      semanticLabel: 'Photo',
    ),
  );
}

/// The placeholder and error slots, and the theme legs.
Widget _imageSlots(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Picture(
        image: _imagePhoto,
        width: 96,
        height: 96,
        aspectRatio: 1,
        placeholder: const Center(
          child: Icon(LucideIcons.loaderCircle, size: 20),
        ),
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(LucideIcons.imageOff, size: 20)),
      ),
      Gap(spacing.lg),
      Picture(
        image: _imagePhoto,
        width: 96,
        height: 96,
        aspectRatio: 1,
        theme: const ImageTheme(borderRadius: BorderRadius.zero),
      ),
      Gap(spacing.lg),
      ComponentTheme<ImageTheme>(
        data: const ImageTheme(
          background: ThemedColor.ref(ColorRef.accent, alpha: 0.5),
        ),
        child: Picture(
          image: _imagePhoto,
          width: 96,
          height: 96,
          aspectRatio: 1,
        ),
      ),
    ],
  );
}

/// The default image with the theme border radius.
Widget _imageRounded(BuildContext context) {
  final theme = Theme.of(context);
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Picture(
      image: _imagePhoto,
      width: 96,
      height: 96,
      aspectRatio: 1,
      borderRadius: theme.borderRadiusMd,
    ),
  );
}

/// Named docs examples for `image`; the first entry is the default.
const List<ComponentPreview> imagePreviews = <ComponentPreview>[
  ComponentPreview('Default', _imageDefault),
  ComponentPreview('Rounded', _imageRounded),
  ComponentPreview('Slots', _imageSlots),
];
