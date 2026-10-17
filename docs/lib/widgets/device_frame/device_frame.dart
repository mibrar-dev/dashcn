// The P9-1 device frame: `package:device_preview` body artwork around a
// clipped screen, plus a `MediaQuery` + platform override for the child.
//
// The child sees the spec's logical screen size, safe-area padding (as both
// `padding` and `viewPadding`), device pixel ratio and platform
// (`Theme.of(context).platform`, routed through the kit `ThemeData.platform`
// override). The body artwork (bezel, Dynamic Island / punch hole, window
// chrome) and the decorative system UI (status bar, gesture pill) are drawn
// by `DevicePreviewFrame` from the spec's preset — the package owns every
// device pixel, this widget only reserves the letterbox around the screen
// (the package paints OUTSIDE its widget box) and feeds the matching
// `MediaQuery`.
//
// Semantics container: framed content owns nested `Navigator`s whose routes
// insert a `ModalBarrier` (`BlockSemantics`) each. Without a boundary here
// that barrier would hide sibling page content (e.g. the docs article title)
// from assistive tech.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';

import '../../ui/dashcn/theme/theme.dart';
import 'device_spec.dart';

/// One framed preview: [spec]'s device body around [child].
class DeviceFrame extends StatefulWidget {
  /// Creates a frame for [spec] around [child].
  const DeviceFrame({
    super.key,
    required this.spec,
    required this.child,
    this.orientation = DeviceOrientation.portrait,
  });

  /// The device to emulate.
  final DeviceSpec spec;

  /// The preview inside the screen.
  final Widget child;

  /// Portrait or landscape.
  final DeviceOrientation orientation;

  @override
  State<DeviceFrame> createState() => _DeviceFrameState();
}

class _DeviceFrameState extends State<DeviceFrame> {
  /// The live simulation `DevicePreviewFrame` paints from.
  ///
  /// One notifier per framed preview (the spike's embedded pattern): the
  /// render object repaints whenever the value changes, and sharing one
  /// notifier across different devices would paint the wrong body.
  late final ValueNotifier<DeviceSimulation?> _simulation;

  @override
  void initState() {
    super.initState();
    _simulation = ValueNotifier<DeviceSimulation?>(
      widget.spec.simulationFor(widget.orientation),
    );
  }

  @override
  void didUpdateWidget(DeviceFrame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spec != widget.spec ||
        oldWidget.orientation != widget.orientation) {
      setState(() {
        _simulation.value = widget.spec.simulationFor(widget.orientation);
      });
    }
  }

  @override
  void dispose() {
    _simulation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData outer = Theme.of(context);
    final DeviceSpec spec = widget.spec;
    final DeviceOrientation orientation = widget.orientation;
    final Size screen = spec.sizeFor(orientation);
    final EdgeInsets safe = spec.paddingFor(orientation);
    final EdgeInsets letterbox = spec.letterboxFor(orientation);
    final Size total = spec.totalFor(orientation);
    final MediaQueryData? ambient = MediaQuery.maybeOf(context);
    final MediaQueryData media = (ambient ?? const MediaQueryData()).copyWith(
      size: screen,
      padding: safe,
      viewPadding: safe,
      viewInsets: EdgeInsets.zero,
      devicePixelRatio: spec.devicePixelRatio,
    );
    // Letterbox first: the body paints outside `DevicePreviewFrame`'s box
    // (which is exactly the screen size), so the padding keeps that paint
    // inside this frame's footprint instead of over neighbouring content.
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: SizedBox(
        width: total.width,
        height: total.height,
        child: Padding(
          padding: letterbox,
          child: DevicePreviewFrame(
            simulation: _simulation,
            child: SizedBox(
              width: screen.width,
              height: screen.height,
              child: ColoredBox(
                color: outer.colors.background,
                child: Theme(
                  data: outer.copyWith(platform: () => spec.platform),
                  child: MediaQuery(data: media, child: widget.child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
