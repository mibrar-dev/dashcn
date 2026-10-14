// Snapshot cross-fade for site-wide theme switches (P7-WD, kinds P7-TS1).
//
// The old shell tweened the whole tree through `AnimatedTheme`: every
// animation tick re-lerped the theme and rebuilt every theme dependent (~19
// full-tree rebuilds per switch), which froze the page on preset and
// light/dark switches.
//
// This widget swaps the theme exactly once per commit and animates a raster
// snapshot of the old frame over the new one. Only the overlay repaints per
// frame; the content tree builds once. The tree shape never changes (the
// overlay slot is always present), so content state — scroll positions, text
// fields, focus — survives every switch. Reduced motion (or [Duration.zero])
// swaps instantly with no snapshot. A switch that lands mid-fade swaps the
// base instantly and lets the older snapshot keep fading, so rapid commits
// never pile up captures.
//
// The rail `Transition` row (P7-TS1) picks the [kind]: [DocsThemeTransition
// .none] swaps instantly, [DocsThemeTransition.fade] cross-fades,
// [DocsThemeTransition.circular] opens an expanding hole from [origin] (the
// tap point; the centre when unknown), [DocsThemeTransition.wipe] slides the
// old frame away, and [DocsThemeTransition.blur] dissolves it through a
// blur. Every kind animates the snapshot only, so all stay GPU-cheap.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../motion/ease.dart';
import '../motion/motion_scope.dart';
import '../state/docs_storage.dart';
import '../ui/dashcn/theme/theme.dart';

/// Length of the fade switch (~250 ms, P7-WD).
const Duration kThemeSwitchFade = Duration(milliseconds: 250);

/// Length of the circular reveal (~350 ms).
const Duration kThemeSwitchCircular = Duration(milliseconds: 350);

/// Length of the wipe (~300 ms).
const Duration kThemeSwitchWipe = Duration(milliseconds: 300);

/// Length of the blur dissolve (~300 ms).
const Duration kThemeSwitchBlur = Duration(milliseconds: 300);

/// The animation length of [kind] (all in the brief's ~250–400 ms band).
Duration docsTransitionDuration(DocsThemeTransition kind) => switch (kind) {
  DocsThemeTransition.none => Duration.zero,
  DocsThemeTransition.fade => kThemeSwitchFade,
  DocsThemeTransition.circular => kThemeSwitchCircular,
  DocsThemeTransition.wipe => kThemeSwitchWipe,
  DocsThemeTransition.blur => kThemeSwitchBlur,
};

/// Cross-fades a raster snapshot of the old frame over the new theme.
class ThemeSwitchTransition extends StatefulWidget {
  /// Creates the transition around [child].
  const ThemeSwitchTransition({
    super.key,
    required this.data,
    required this.child,
    this.duration = kDurationThemeSwitch,
    this.curve = kEaseOutExpo,
    this.kind = DocsThemeTransition.fade,
    this.origin,
  });

  /// The theme to show. Compared by value; an unchanged value is a no-op.
  final ThemeData data;

  /// The subtree themed by [data].
  final Widget child;

  /// Fade length. [Duration.zero] (or reduced motion, or [kind] none) swaps
  /// instantly.
  final Duration duration;

  /// Fade curve.
  final Curve curve;

  /// The switch animation. Defaults to the cross-fade.
  final DocsThemeTransition kind;

  /// Where the circular reveal starts, in global coordinates (the last tap
  /// point the shell captured). Null centres the reveal.
  final Offset? origin;

  @override
  State<ThemeSwitchTransition> createState() => _ThemeSwitchTransitionState();
}

/// State of [ThemeSwitchTransition].
class _ThemeSwitchTransitionState extends State<ThemeSwitchTransition>
    with SingleTickerProviderStateMixin {
  final GlobalKey _boundaryKey = GlobalKey();
  late ThemeData _base = widget.data;
  ui.Image? _snapshot;

  /// The kind (and reveal origin) the in-flight snapshot animates with, so
  /// a mid-fade commit never flips the running animation.
  DocsThemeTransition _activeKind = DocsThemeTransition.fade;
  Offset? _activeOrigin;
  bool _capturing = false;
  bool _reducedMotion = false;
  late final AnimationController _fade = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _activeKind = widget.kind;
    _fade.addStatusListener(_onFadeStatus);
  }

  @override
  void dispose() {
    _fade
      ..removeStatusListener(_onFadeStatus)
      ..dispose();
    _snapshot?.dispose();
    _snapshot = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(ThemeSwitchTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data == oldWidget.data) {
      return;
    }
    if (identical(widget.data, _base)) {
      return;
    }
    if (widget.kind == DocsThemeTransition.none ||
        widget.duration == Duration.zero ||
        _reducedMotion) {
      _settleInstantly();
      return;
    }
    if (_snapshot != null || _capturing) {
      // A fade (or its capture) is already in flight: swap the base
      // instantly — one rebuild — and let the older frame keep fading. The
      // in-flight capture picks up the latest data on completion.
      setState(() => _base = widget.data);
      return;
    }
    _capturing = true;
    _captureThenSwap();
  }

  /// Instant path: no snapshot, no animation.
  void _settleInstantly() {
    _fade.stop();
    _snapshot?.dispose();
    _snapshot = null;
    _base = widget.data;
    _activeKind = widget.kind;
    setState(() {});
  }

  Future<void> _captureThenSwap() async {
    final ui.Image? image = await _captureOldFrame();
    if (!mounted) {
      image?.dispose();
      return;
    }
    _capturing = false;
    if (widget.data == _base) {
      image?.dispose();
      return;
    }
    setState(() {
      _snapshot?.dispose();
      _snapshot = image;
      _base = widget.data;
      _activeKind = widget.kind;
      _activeOrigin = widget.origin;
    });
    if (image == null) {
      return;
    }
    _fade
      ..reset()
      ..duration = widget.duration
      ..animateTo(1, curve: widget.curve);
  }

  void _onFadeStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || _snapshot == null) {
      return;
    }
    final ui.Image? snapshot = _snapshot;
    _snapshot = null;
    snapshot?.dispose();
    if (mounted) {
      setState(() {});
    }
  }

  /// Rasters the currently shown frame at 1x. A 1x snapshot over a hi-dpi
  /// base softens for ~250 ms; capturing at device pixel ratio would cost a
  /// full-res raster every switch for no visible gain during a fade.
  Future<ui.Image?> _captureOldFrame() async {
    try {
      final RenderObject? render = _boundaryKey.currentContext
          ?.findRenderObject();
      if (render is! RenderRepaintBoundary) {
        return null;
      }
      return await render.toImage(pixelRatio: 1);
    } on Object {
      return null;
    }
  }

  /// The reveal centre in overlay-local coordinates.
  Offset _localOrigin(Size size) {
    final Offset fallback = Offset(size.width / 2, size.height / 2);
    final Offset? global = _activeOrigin;
    if (global == null) {
      return fallback;
    }
    final RenderObject? render = _boundaryKey.currentContext
        ?.findRenderObject();
    if (render is! RenderBox || !render.hasSize) {
      return fallback;
    }
    final Offset local = render.globalToLocal(global);
    return Offset(
      local.dx.clamp(0, size.width),
      local.dy.clamp(0, size.height),
    );
  }

  @override
  Widget build(BuildContext context) {
    _reducedMotion = MotionScope.of(context);
    final Widget content = Theme(
      data: _base,
      child: RepaintBoundary(key: _boundaryKey, child: widget.child),
    );
    // The overlay slot is always present so [content] never moves in the
    // tree: inserting the snapshot cannot remount (and reset the state of)
    // the content subtree. The non-directional alignment keeps this widget
    // free of a Directionality dependency (both children fill the stack, so
    // alignment never affects layout).
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        content,
        Positioned.fill(
          child: IgnorePointer(
            child: ExcludeSemantics(
              child: RepaintBoundary(child: _buildOverlay()),
            ),
          ),
        ),
      ],
    );
  }

  /// The snapshot overlay for the in-flight [_activeKind]; an empty box
  /// when there is nothing to animate. Every branch repaints the snapshot
  /// only — the content tree is untouched while the animation runs.
  Widget _buildOverlay() {
    final ui.Image? snapshot = _snapshot;
    if (snapshot == null) {
      return const SizedBox.shrink();
    }
    return switch (_activeKind) {
      DocsThemeTransition.none => const SizedBox.shrink(),
      DocsThemeTransition.fade => _SnapshotFade(
        image: snapshot,
        animation: _fade,
        curve: widget.curve,
      ),
      DocsThemeTransition.circular => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final Offset centre = _localOrigin(size);
          final double maxRadius = <double>[
            for (final Offset corner in <Offset>[
              Offset.zero,
              Offset(size.width, 0),
              Offset(0, size.height),
              Offset(size.width, size.height),
            ])
              (corner - centre).distance,
          ].reduce(math.max);
          return AnimatedBuilder(
            animation: _fade,
            builder: (BuildContext context, Widget? child) => ClipPath(
              clipper: _InverseCircleClip(
                centre,
                _fade.value * maxRadius,
                size,
              ),
              child: child,
            ),
            child: RawImage(image: snapshot, fit: BoxFit.fill),
          );
        },
      ),
      DocsThemeTransition.wipe => AnimatedBuilder(
        animation: _fade,
        builder: (BuildContext context, Widget? child) => Transform.translate(
          // The 1x snapshot is [snapshot.width] logical px wide.
          offset: Offset(-_fade.value * snapshot.width, 0),
          child: Opacity(opacity: 1 - _fade.value * 0.4, child: child),
        ),
        child: RawImage(image: snapshot, fit: BoxFit.fill),
      ),
      DocsThemeTransition.blur => AnimatedBuilder(
        animation: _fade,
        builder: (BuildContext context, Widget? child) => ImageFiltered(
          imageFilter: ui.ImageFilter.blur(
            sigmaX: 12 * _fade.value,
            sigmaY: 12 * _fade.value,
          ),
          child: Opacity(opacity: 1 - _fade.value, child: child),
        ),
        child: RawImage(image: snapshot, fit: BoxFit.fill),
      ),
    };
  }
}

/// Fades [image]; an empty box when there is nothing to fade.
class _SnapshotFade extends StatelessWidget {
  const _SnapshotFade({
    required this.image,
    required this.animation,
    required this.curve,
  });

  final ui.Image? image;
  final Animation<double> animation;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final ui.Image? snapshot = image;
    if (snapshot == null) {
      return const SizedBox.shrink();
    }
    return FadeTransition(
      opacity: animation.drive(CurveTween(curve: curve)),
      child: RawImage(image: snapshot, fit: BoxFit.fill),
    );
  }
}

/// Clips to everything *outside* a circle: the old frame with an expanding
/// hole the new frame shows through.
class _InverseCircleClip extends CustomClipper<Path> {
  const _InverseCircleClip(this.centre, this.radius, this.bounds);

  final Offset centre;
  final double radius;
  final Size bounds;

  @override
  Path getClip(Size size) => Path()
    ..addRect(Offset.zero & bounds)
    ..addOval(Rect.fromCircle(center: centre, radius: radius))
    ..fillType = PathFillType.evenOdd;

  @override
  bool shouldReclip(_InverseCircleClip old) =>
      old.centre != centre || old.radius != radius || old.bounds != bounds;
}
