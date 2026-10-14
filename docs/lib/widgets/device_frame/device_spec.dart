// Device specs for the P9-1 preview frames (every platform at once).
//
// Four specs — an iPhone, an Android phone, a desktop window and a browser
// window — each carrying the logical screen size, the safe-area insets the
// child sees, the device pixel ratio and the `TargetPlatform` the kit theme
// resolves through. Sizes and insets are approximations of real hardware
// (iPhone 16, Pixel 9) and of a typical desktop/browser window; they exist
// so previews exercise narrow widths, notches and platform branches, not to
// certify hardware pixels.

import 'package:flutter/widgets.dart';

/// Which frame a preview renders inside (the `FrameBar` segments).
enum DeviceFrameId {
  /// No frame: the preview fills the available width.
  none('none', 'None'),

  /// iPhone 16 portrait/landscape.
  iphone('iphone', 'iPhone'),

  /// Pixel 9 portrait/landscape.
  android('android', 'Android'),

  /// macOS-style desktop window.
  desktop('desktop', 'Desktop'),

  /// Browser window (tab strip + address bar).
  web('web', 'Web'),

  /// All four specs side by side (or a snap scroller when narrow).
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
}

/// The chrome kind a spec paints (phones draw a bezel + island/camera,
/// desktop and browser draw a title/tab bar).
enum DeviceChromeKind {
  /// Phone body with a camera island (iPhone) or punch hole (Android).
  phone,

  /// Window with a title bar.
  desktop,

  /// Window with a tab strip + address bar.
  browser,
}

/// One framed device: screen size, safe areas, pixel ratio and platform.
@immutable
class DeviceSpec {
  const DeviceSpec({
    required this.id,
    required this.label,
    required this.size,
    required this.portraitPadding,
    required this.landscapePadding,
    required this.devicePixelRatio,
    required this.platform,
    required this.outerRadius,
    required this.screenRadius,
    required this.framePadding,
    required this.chrome,
    required this.hasIsland,
    required this.rotatable,
  });

  /// Which toolbar segment this spec belongs to.
  final DeviceFrameId id;

  /// Visible name (`iPhone 16`).
  final String label;

  /// Logical screen size in portrait.
  final Size size;

  /// Safe-area insets exposed to the child in portrait.
  final EdgeInsets portraitPadding;

  /// Safe-area insets exposed to the child in landscape.
  final EdgeInsets landscapePadding;

  /// Device pixel ratio exposed through `MediaQuery`.
  final double devicePixelRatio;

  /// Platform the kit theme resolves to inside this frame
  /// (`Theme.of(context).platform`).
  final TargetPlatform platform;

  /// Corner radius of the device body / window.
  final double outerRadius;

  /// Corner radius of the screen (where the child is clipped).
  final double screenRadius;

  /// Chrome around the screen: bezel on phones, title-bar height on top
  /// plus a thin edge elsewhere on desktop/browser.
  final EdgeInsets framePadding;

  /// Which chrome the painter draws.
  final DeviceChromeKind chrome;

  /// Whether the phone draws a Dynamic Island (true) or a punch hole
  /// (false). Ignored for non-phone chrome.
  final bool hasIsland;

  /// Whether rotation applies. Phones rotate; the desktop window and the
  /// browser are landscape-native, so [sizeFor]/[paddingFor]/[totalFor]
  /// ignore the orientation for them instead of swapping a 1280-wide
  /// window into a tall portrait one.
  final bool rotatable;

  /// Screen size for [orientation] (landscape swaps width/height, unless
  /// the spec is not [rotatable]).
  Size sizeFor(DeviceOrientation orientation) {
    if (!rotatable || orientation == DeviceOrientation.portrait) {
      return size;
    }
    return Size(size.height, size.width);
  }

  /// Safe-area insets for [orientation] (portrait values unless the spec
  /// is [rotatable] and landscape).
  EdgeInsets paddingFor(DeviceOrientation orientation) {
    if (!rotatable || orientation == DeviceOrientation.portrait) {
      return portraitPadding;
    }
    return landscapePadding;
  }

  /// Total footprint (screen + chrome) for [orientation].
  Size totalFor(DeviceOrientation orientation) {
    final Size screen = sizeFor(orientation);
    return Size(
      screen.width + framePadding.left + framePadding.right,
      screen.height + framePadding.top + framePadding.bottom,
    );
  }
}

/// iPhone 16: 393x852 @3x, iOS, Dynamic Island.
const DeviceSpec kIphoneSpec = DeviceSpec(
  id: DeviceFrameId.iphone,
  label: 'iPhone 16',
  size: Size(393, 852),
  portraitPadding: EdgeInsets.only(top: 59, bottom: 34),
  landscapePadding: EdgeInsets.fromLTRB(59, 21, 34, 21),
  devicePixelRatio: 3,
  platform: TargetPlatform.iOS,
  outerRadius: 55,
  screenRadius: 48,
  framePadding: EdgeInsets.all(12),
  chrome: DeviceChromeKind.phone,
  hasIsland: true,
  rotatable: true,
);

/// Pixel 9: 412x915 @2.625x, Android, punch-hole camera.
const DeviceSpec kAndroidSpec = DeviceSpec(
  id: DeviceFrameId.android,
  label: 'Pixel 9',
  size: Size(412, 915),
  portraitPadding: EdgeInsets.only(top: 47, bottom: 30),
  landscapePadding: EdgeInsets.fromLTRB(47, 24, 30, 24),
  devicePixelRatio: 2.625,
  platform: TargetPlatform.android,
  outerRadius: 36,
  screenRadius: 28,
  framePadding: EdgeInsets.all(10),
  chrome: DeviceChromeKind.phone,
  hasIsland: false,
  rotatable: true,
);

/// Desktop window: 1280x800 @2x, macOS, title bar with traffic lights.
const DeviceSpec kDesktopSpec = DeviceSpec(
  id: DeviceFrameId.desktop,
  label: 'Desktop window',
  size: Size(1280, 800),
  portraitPadding: EdgeInsets.only(top: 52),
  landscapePadding: EdgeInsets.only(top: 52),
  devicePixelRatio: 2,
  platform: TargetPlatform.macOS,
  outerRadius: 12,
  screenRadius: 10,
  framePadding: EdgeInsets.fromLTRB(8, 52, 8, 8),
  chrome: DeviceChromeKind.desktop,
  hasIsland: false,
  rotatable: false,
);

/// Browser window: 1280x800 @1x, tab strip + address bar.
///
/// The platform is Windows so desktop and web resolve differently in
/// previews that branch on `Theme.of(context).platform`.
const DeviceSpec kWebSpec = DeviceSpec(
  id: DeviceFrameId.web,
  label: 'Browser window',
  size: Size(1280, 800),
  portraitPadding: EdgeInsets.only(top: 104),
  landscapePadding: EdgeInsets.only(top: 104),
  devicePixelRatio: 1,
  platform: TargetPlatform.windows,
  outerRadius: 12,
  screenRadius: 10,
  framePadding: EdgeInsets.fromLTRB(8, 104, 8, 8),
  chrome: DeviceChromeKind.browser,
  hasIsland: false,
  rotatable: false,
);

/// The four framable specs, in toolbar order.
const List<DeviceSpec> kFramedSpecs = <DeviceSpec>[
  kIphoneSpec,
  kAndroidSpec,
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
