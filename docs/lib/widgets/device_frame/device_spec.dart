// Device specs for the P9-1 preview frames (every platform at once).
//
// Each spec mirrors one `package:device_preview` preset: an iPhone, an
// Android phone, an iPad, a desktop window and a browser window. The spec
// carries the preset's logical screen size, safe-area insets, device pixel
// ratio and `TargetPlatform`; the device body artwork is drawn by
// `DevicePreviewFrame` from the same preset (see `device_frame.dart`), so
// sizes and artwork can never drift apart. Values are approximations of real
// hardware (iPhone 16 Pro, Galaxy S25, iPad Air 11" M4) and of typical
// desktop/browser windows; they exist so previews exercise narrow widths,
// notches and platform branches, not to certify hardware pixels.

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter/widgets.dart';

/// Which frame a preview renders inside (the `FrameBar` segments).
enum DeviceFrameId {
  /// No frame: the preview fills the available width.
  none('none', 'None'),

  /// iPhone 16 Pro portrait/landscape.
  iphone('iphone', 'iPhone'),

  /// Galaxy S25 portrait/landscape.
  android('android', 'Android'),

  /// iPad Air 11" (M4) portrait/landscape.
  ipad('ipad', 'iPad'),

  /// macOS-style desktop window.
  desktop('desktop', 'Desktop'),

  /// Browser window (Windows-style window chrome).
  web('web', 'Web'),

  /// All five specs side by side (or a snap scroller when narrow).
  all('all', 'All');

  const DeviceFrameId(this.queryValue, this.label);

  /// The `?frame=` query value.
  final String queryValue;

  /// The toolbar label.
  final String label;

  /// Parses a `?frame=` value; unknown values fall back to [none].
  static DeviceFrameId parse(String? value) {
    for (final DeviceFrameId id in DeviceFrameId.values) {
      if (id.queryValue == value) {
        return id;
      }
    }
    return DeviceFrameId.none;
  }
}

/// Portrait or landscape (the `FrameBar` rotate control).
enum DeviceOrientation {
  /// Upright.
  portrait('portrait'),

  /// Rotated: width/height and the phone safe areas swap sides.
  landscape('landscape');

  const DeviceOrientation(this.queryValue);

  /// The `?orientation=` query value.
  final String queryValue;

  /// Parses a `?orientation=` value; unknown values fall back to [portrait].
  static DeviceOrientation parse(String? value) {
    for (final DeviceOrientation orientation in DeviceOrientation.values) {
      if (orientation.queryValue == value) {
        return orientation;
      }
    }
    return DeviceOrientation.portrait;
  }

  /// The `package:device_preview` orientation for `DevicePreset.resolve`.
  Orientation get previewOrientation => this == DeviceOrientation.landscape
      ? Orientation.landscape
      : Orientation.portrait;
}

/// One framed device: the `package:device_preview` preset plus the toolbar
/// metadata around it.
///
/// Screen size, safe-area insets, pixel ratio and platform all come straight
/// from [preset] (via [sizeFor]/[paddingFor]/[devicePixelRatio]/[platform]),
/// so the `MediaQuery` the frame exposes always matches the artwork
/// `DevicePreviewFrame` paints. [device_spec_test] pins every mirrored value
/// against its preset, so a preset upgrade fails loudly instead of drifting.
@immutable
class DeviceSpec {
  const DeviceSpec({
    required this.id,
    required this.label,
    required this.preset,
    required this.rotatable,
  });

  /// Which toolbar segment this spec belongs to.
  final DeviceFrameId id;

  /// Visible name (`iPhone 16 Pro`).
  final String label;

  /// The `package:device_preview` preset this spec mirrors.
  ///
  /// Referenced as a `DevicePresets.X` constant (never via
  /// `DevicePresets.all`/`byId`) so unreferenced presets tree-shake away.
  final DevicePreset preset;

  /// Whether rotation applies. Phones and the tablet rotate; the desktop
  /// window and the browser are landscape-native, so [sizeFor]/[paddingFor]/
  /// [totalFor] ignore the orientation for them instead of swapping a wide
  /// window into a tall portrait one.
  final bool rotatable;

  /// Logical screen size in portrait.
  Size get size => preset.portraitSize;

  /// Device pixel ratio exposed through `MediaQuery`.
  double get devicePixelRatio => preset.devicePixelRatio;

  /// Platform the kit theme resolves to inside this frame
  /// (`Theme.of(context).platform`).
  TargetPlatform get platform => preset.platform;

  /// Screen size for [orientation] (landscape swaps width/height, unless
  /// the spec is not [rotatable]).
  Size sizeFor(DeviceOrientation orientation) {
    if (!rotatable || orientation == DeviceOrientation.portrait) {
      return preset.portraitSize;
    }
    return preset.resolve(orientation: Orientation.landscape).screenSize ??
        Size(preset.portraitSize.height, preset.portraitSize.width);
  }

  /// Safe-area insets for [orientation] (portrait values unless the spec
  /// is [rotatable] and landscape).
  EdgeInsets paddingFor(DeviceOrientation orientation) {
    if (!rotatable || orientation == DeviceOrientation.portrait) {
      return preset.portraitPadding;
    }
    return preset.landscapePadding ??
        DevicePreset.rotateToLandscape(preset.portraitPadding);
  }

  /// The resolved `package:device_preview` simulation for [orientation]:
  /// screen metrics plus the body artwork and system UI
  /// `DevicePreviewFrame` paints.
  DeviceSimulation simulationFor(DeviceOrientation orientation) {
    if (!rotatable || orientation == DeviceOrientation.portrait) {
      return preset.resolve();
    }
    return preset.resolve(orientation: Orientation.landscape);
  }

  /// Blank space reserved around the screen for the body artwork.
  ///
  /// `DevicePreviewFrame` paints the body OUTSIDE its widget box (which is
  /// exactly the screen size); the letterbox keeps that paint inside this
  /// frame's [totalFor] footprint so neighbouring content is never covered.
  EdgeInsets letterboxFor(DeviceOrientation orientation) {
    final DeviceSimulation simulation = simulationFor(orientation);
    final Size? screen = simulation.screenSize;
    final Rect bounds = simulation.contentBounds;
    if (screen == null || bounds.isEmpty) {
      return EdgeInsets.zero;
    }
    double clampNonNegative(double value) =>
        value.isNaN ? 0 : value.clamp(0, double.infinity).toDouble();
    return EdgeInsets.fromLTRB(
      clampNonNegative(-bounds.left),
      clampNonNegative(-bounds.top),
      clampNonNegative(bounds.right - screen.width),
      clampNonNegative(bounds.bottom - screen.height),
    );
  }

  /// Total footprint (screen + letterbox) for [orientation].
  Size totalFor(DeviceOrientation orientation) {
    final Size screen = sizeFor(orientation);
    final EdgeInsets letterbox = letterboxFor(orientation);
    return Size(
      screen.width + letterbox.left + letterbox.right,
      screen.height + letterbox.top + letterbox.bottom,
    );
  }
}

/// iPhone 16 Pro @3x, iOS.
const DeviceSpec kIphoneSpec = DeviceSpec(
  id: DeviceFrameId.iphone,
  label: 'iPhone 16 Pro',
  preset: DevicePresets.iPhone16Pro,
  rotatable: true,
);

/// Galaxy S25 @3x, Android.
const DeviceSpec kAndroidSpec = DeviceSpec(
  id: DeviceFrameId.android,
  label: 'Galaxy S25',
  preset: DevicePresets.galaxyS25,
  rotatable: true,
);

/// iPad Air 11" (M4) @2x, iOS.
const DeviceSpec kIpadSpec = DeviceSpec(
  id: DeviceFrameId.ipad,
  label: 'iPad Air 11" (M4)',
  preset: DevicePresets.iPadAir11M4,
  rotatable: true,
);

/// Large desktop window @2x, macOS.
const DeviceSpec kDesktopSpec = DeviceSpec(
  id: DeviceFrameId.desktop,
  label: 'Desktop window',
  preset: DevicePresets.largeDesktopWindow,
  rotatable: false,
);

/// Small desktop window @1x, Windows.
///
/// The platform is Windows so desktop and web resolve differently in
/// previews that branch on `Theme.of(context).platform`.
const DeviceSpec kWebSpec = DeviceSpec(
  id: DeviceFrameId.web,
  label: 'Browser window',
  preset: DevicePresets.smallDesktopWindow,
  rotatable: false,
);

/// The five framable specs, in toolbar order.
const List<DeviceSpec> kFramedSpecs = <DeviceSpec>[
  kIphoneSpec,
  kAndroidSpec,
  kIpadSpec,
  kDesktopSpec,
  kWebSpec,
];

/// Returns the spec for [id], or null for [DeviceFrameId.none]/[all].
DeviceSpec? specForFrame(DeviceFrameId id) {
  for (final DeviceSpec spec in kFramedSpecs) {
    if (spec.id == id) {
      return spec;
    }
  }
  return null;
}
