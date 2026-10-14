// The P9-1 device frame: painted chrome (no images), a clipped screen, and
// a `MediaQuery` + platform override for the child.
//
// The child sees the spec's logical size, safe-area padding (as both
// `padding` and `viewPadding`), device pixel ratio and platform
// (`Theme.of(context).platform`, routed through the kit `ThemeData.platform`
// override). The chrome is drawn by [_DeviceChromePainter] behind the screen
// and [_DeviceNotchPainter] in front (island/camera, home indicator and
// title-bar furniture overlay the content, like real hardware).

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/theme/theme.dart';
import 'device_spec.dart';

/// One framed preview: [spec]'s chrome around [child].
class DeviceFrame extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final ThemeData outer = Theme.of(context);
    final Size screen = spec.sizeFor(orientation);
    final EdgeInsets safe = spec.paddingFor(orientation);
    final Size total = spec.totalFor(orientation);
    final MediaQueryData? ambient = MediaQuery.maybeOf(context);
    final MediaQueryData media = (ambient ?? const MediaQueryData()).copyWith(
      size: screen,
      padding: safe,
      viewPadding: safe,
      viewInsets: EdgeInsets.zero,
      devicePixelRatio: spec.devicePixelRatio,
    );
    // Semantics container: framed content owns nested `Navigator`s whose
    // routes insert a `ModalBarrier` (`BlockSemantics`) each. Without a
    // boundary here that barrier would hide sibling page content (e.g. the
    // docs article title) from assistive tech.
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: SizedBox(
        width: total.width,
        height: total.height,
        child: CustomPaint(
          painter: _DeviceChromePainter(
            spec: spec,
            orientation: orientation,
            theme: outer,
          ),
          foregroundPainter: _DeviceNotchPainter(
            spec: spec,
            orientation: orientation,
            theme: outer,
          ),
          child: Padding(
            padding: spec.framePadding,
            child: SizedBox(
              width: screen.width,
              height: screen.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(spec.screenRadius),
                child: ColoredBox(
                  color: outer.colors.background,
                  child: Theme(
                    data: outer.copyWith(platform: () => spec.platform),
                    child: MediaQuery(data: media, child: child),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the device body / window behind the screen.
class _DeviceChromePainter extends CustomPainter {
  _DeviceChromePainter({
    required this.spec,
    required this.orientation,
    required this.theme,
  });

  final DeviceSpec spec;
  final DeviceOrientation orientation;
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final RRect body = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(spec.outerRadius),
    );
    final Paint fill = Paint()..color = _bodyColor();
    canvas.drawRRect(body, fill);
    final Paint edge = Paint()
      ..color = theme.colors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(body, edge);
    if (spec.chrome == DeviceChromeKind.phone) {
      _paintSideButtons(canvas, size);
    } else if (spec.chrome == DeviceChromeKind.desktop) {
      _paintTrafficLights(canvas);
    } else {
      _paintBrowserBar(canvas, size);
    }
  }

  Color _bodyColor() {
    final bool dark = theme.colors.brightness == Brightness.dark;
    if (spec.chrome == DeviceChromeKind.phone) {
      return dark ? const Color(0xFF1C1C1E) : const Color(0xFFE8E8EC);
    }
    return theme.colors.card;
  }

  void _paintSideButtons(Canvas canvas, Size size) {
    final bool landscape = orientation == DeviceOrientation.landscape;
    final Paint button = Paint()..color = theme.colors.border;
    if (!landscape) {
      final double h = size.height;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(-2, h * 0.18, 4, h * 0.07),
          const Radius.circular(2),
        ),
        button,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width - 2, h * 0.24, 4, h * 0.11),
          const Radius.circular(2),
        ),
        button,
      );
    }
  }

  void _paintTrafficLights(Canvas canvas) {
    const List<Color> lights = <Color>[
      Color(0xFFFF5F57),
      Color(0xFFFEBC2E),
      Color(0xFF28C840),
    ];
    double x = spec.framePadding.left + 16;
    final double y = 26;
    for (final Color color in lights) {
      canvas.drawCircle(Offset(x, y), 6, Paint()..color = color);
      x += 20;
    }
  }

  void _paintBrowserBar(Canvas canvas, Size size) {
    final double pad = spec.framePadding.left;
    // Active tab.
    final RRect tab = RRect.fromRectAndRadius(
      Rect.fromLTWH(pad + 12, 10, 190, 34),
      const Radius.circular(8),
    );
    canvas.drawRRect(tab, Paint()..color = theme.colors.muted);
    canvas.drawCircle(
      Offset(pad + 184, 27),
      5,
      Paint()
        ..color = theme.colors.mutedForeground
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    // Toolbar row: back/forward chevrons + the address pill.
    final Paint glyph = Paint()
      ..color = theme.colors.mutedForeground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final double y = 70;
    canvas.drawLine(Offset(pad + 16, y), Offset(pad + 24, y), glyph);
    canvas.drawLine(Offset(pad + 34, y), Offset(pad + 42, y), glyph);
    final RRect url = RRect.fromRectAndRadius(
      Rect.fromLTWH(pad + 56, y - 14, size.width - 2 * pad - 72, 28),
      const Radius.circular(14),
    );
    canvas.drawRRect(
      url,
      Paint()
        ..color = theme.colors.muted
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _DeviceChromePainter old) {
    return old.spec != spec ||
        old.orientation != orientation ||
        old.theme != theme;
  }
}

/// Paints the island/camera, home indicator and title divider above the
/// screen (they overlay content, like real hardware).
class _DeviceNotchPainter extends CustomPainter {
  _DeviceNotchPainter({
    required this.spec,
    required this.orientation,
    required this.theme,
  });

  final DeviceSpec spec;
  final DeviceOrientation orientation;
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    if (spec.chrome == DeviceChromeKind.phone) {
      _paintPhone(canvas, size);
    } else {
      final Paint divider = Paint()
        ..color = theme.colors.border
        ..strokeWidth = 1;
      final double y = spec.framePadding.top - 0.5;
      canvas.drawLine(
        Offset(spec.outerRadius / 2, y),
        Offset(size.width - spec.outerRadius / 2, y),
        divider,
      );
    }
  }

  void _paintPhone(Canvas canvas, Size size) {
    final bool landscape = orientation == DeviceOrientation.landscape;
    final EdgeInsets pad = spec.framePadding;
    const Color black = Color(0xFF000000);
    final Paint ink = Paint()..color = black;
    if (spec.hasIsland) {
      if (!landscape) {
        final RRect island = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width / 2, pad.top + 22),
            width: 112,
            height: 30,
          ),
          const Radius.circular(15),
        );
        canvas.drawRRect(island, ink);
      } else {
        final RRect island = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(pad.left + 30, size.height / 2),
            width: 30,
            height: 112,
          ),
          const Radius.circular(15),
        );
        canvas.drawRRect(island, ink);
      }
    } else if (!landscape) {
      canvas.drawCircle(Offset(size.width / 2, pad.top + 23), 8, ink);
    }
    // Home indicator.
    final Paint bar = Paint()
      ..color = theme.colors.mutedForeground
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    if (!landscape) {
      final double y = size.height - pad.bottom + 12;
      canvas.drawLine(
        Offset(size.width / 2 - 60, y),
        Offset(size.width / 2 + 60, y),
        bar,
      );
    } else {
      final double x = size.width - pad.right + 10;
      canvas.drawLine(
        Offset(x, size.height / 2 - 60),
        Offset(x, size.height / 2 + 60),
        bar,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DeviceNotchPainter old) {
    return old.spec != spec ||
        old.orientation != orientation ||
        old.theme != theme;
  }
}
