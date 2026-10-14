// The P9-1 frame toolbar: `None · iPhone · Android · Desktop · Web · All`,
// plus rotate (portrait/landscape) and light/dark.
//
// Self-contained (value + callbacks, no `DocsState` import): the docs page
// wires it to the persisted state in P9-Z. Segment buttons carry
// `ValueKey('frame-bar-<queryValue>')` so widget tests can tap them.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/tooltip/tooltip.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/foundation/icons/lucide_icons.dart';
import 'device_spec.dart';

/// The frame picker toolbar above a framed preview.
class FrameBar extends StatelessWidget {
  /// Creates the toolbar.
  const FrameBar({
    super.key,
    required this.frame,
    required this.onFrameChanged,
    required this.orientation,
    required this.onOrientationChanged,
    this.brightness,
    this.onBrightnessChanged,
  });

  /// The selected frame.
  final DeviceFrameId frame;

  /// Called with the newly selected frame.
  final ValueChanged<DeviceFrameId> onFrameChanged;

  /// Portrait or landscape.
  final DeviceOrientation orientation;

  /// Called when the rotate button is tapped.
  final ValueChanged<DeviceOrientation> onOrientationChanged;

  /// Current site brightness; null hides the light/dark toggle.
  final Brightness? brightness;

  /// Called with the flipped brightness; null hides the toggle.
  final ValueChanged<Brightness>? onBrightnessChanged;

  @override
  Widget build(BuildContext context) {
    final bool showBrightness =
        brightness != null && onBrightnessChanged != null;
    // Rotation only affects rotatable specs (phones): hidden for the
    // desktop window and browser frames. `none` keeps it (it will apply
    // once a phone is picked) and `all` keeps it (its phones rotate).
    final bool showRotate =
        frame == DeviceFrameId.none ||
        frame == DeviceFrameId.all ||
        (specForFrame(frame)?.rotatable ?? false);
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        for (final DeviceFrameId id in DeviceFrameId.values)
          _Segment(
            key: ValueKey<String>('frame-bar-${id.queryValue}'),
            label: id.label,
            selected: id == frame,
            onPressed: () => onFrameChanged(id),
          ),
        const Gap(8),
        if (showRotate)
          Tooltip(
            tooltip: (BuildContext context) => Text(
              orientation == DeviceOrientation.portrait
                  ? 'Rotate to landscape'
                  : 'Rotate to portrait',
            ),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Button(
                key: const ValueKey<String>('frame-bar-rotate'),
                variant: ButtonVariant.ghost,
                size: ButtonSize.xs,
                theme: const ButtonVariantStyle(padding: EdgeInsets.zero),
                onPressed: () => onOrientationChanged(
                  orientation == DeviceOrientation.portrait
                      ? DeviceOrientation.landscape
                      : DeviceOrientation.portrait,
                ),
                child: const Icon(LucideIcons.rotateCw, size: 14),
              ),
            ),
          ),
        if (showBrightness)
          Tooltip(
            tooltip: (BuildContext context) => Text(
              brightness == Brightness.dark
                  ? 'Switch to light'
                  : 'Switch to dark',
            ),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Button(
                key: const ValueKey<String>('frame-bar-brightness'),
                variant: ButtonVariant.ghost,
                size: ButtonSize.xs,
                theme: const ButtonVariantStyle(padding: EdgeInsets.zero),
                onPressed: () => onBrightnessChanged!(
                  brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
                ),
                child: Icon(
                  brightness == Brightness.dark
                      ? LucideIcons.sun
                      : LucideIcons.moon,
                  size: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// One text segment of the picker; the active one is filled.
class _Segment extends StatelessWidget {
  const _Segment({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: selected ? ButtonVariant.secondary : ButtonVariant.ghost,
      size: ButtonSize.xs,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
