// The `eye_dropper` component: [EyeDropperLayer] wraps a subtree and lets the
// user sample any pixel on screen, live across the whole app window.
//
// Ported from `overlay/eye_dropper/**` (old tree). Screen capture, grid
// sampling and the magnified-grid painter live in
// `primitives/screen_capture.dart`; the old `data_widget` package became the
// foundation `Data`/`ForwardableData`, and Material's `Colors` became the kit
// palette.
//
// Whole-app sampling: `ShadcnApp` installs an [EyeDropperLayer] at the root.
// A nested layer delegates its session to the outermost scope, so the capture
// is the app root and the loupe + crosshair cover the entire window — above
// picker popovers too. Without a root layer the session falls back to the
// layer's own subtree.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../foundation/data_messenger.dart';
import '../../primitives/screen_capture.dart';
import '../../primitives/text/text_extension.dart';
import '../../theme/color_tokens.dart';
import '../../theme/color_utils.dart';
import '../../theme/theme.dart';
import '../history/history.dart';
import 'eye_dropper_style.dart';

export 'eye_dropper_style.dart';
export '../../primitives/screen_capture.dart'
    show ScreenSample, eyeDropperCaptureSupported;

/// Builds a preview label widget for the sampled colour.
typedef PreviewLabelBuilder =
    Widget Function(BuildContext context, Color color);

/// Called for every live sample while the pointer moves (before commit).
typedef EyeDropperSampleCallback = void Function(Color color);

/// Eye-dropper sessions managed by an [EyeDropperLayer].
abstract class EyeDropperLayerScope {
  /// Prompts the user to pick a colour from the screen.
  ///
  /// Completes with the sampled colour, or null when the session is cancelled
  /// (Escape / right-click). [onSample] fires live for every hovered pixel so
  /// a colour picker can update its pad, sliders and hex field while moving.
  /// When [historyStorage] is given the committed colour is also pushed to it.
  Future<Color?> promptPickColor([
    ColorHistoryStorage? historyStorage,
    EyeDropperSampleCallback? onSample,
  ]);

  /// Whether screen capture is available on this platform.
  ///
  /// `RenderRepaintBoundary.toImage` works on web and desktop, so this is
  /// always true; the pipette button hides only when no scope exists in the
  /// tree (the detectable impossibility), not on this flag.
  static bool get isCaptureSupported => eyeDropperCaptureSupported;

  /// Nearest scope above [context], or null when absent.
  static EyeDropperLayerScope? maybeFind(BuildContext context) {
    return Data.maybeFind<EyeDropperLayerScope>(context) ??
        Data.maybeFindMessenger<EyeDropperLayerScope>(context);
  }

  /// Finds the outermost [EyeDropperLayerScope] above [context].
  static EyeDropperLayerScope findRoot(BuildContext context) {
    return _resolve(
      Data.maybeFindRoot<EyeDropperLayerScope>(context) ??
          Data.maybeFindMessenger<EyeDropperLayerScope>(context),
    );
  }

  /// Finds the nearest [EyeDropperLayerScope] above [context].
  static EyeDropperLayerScope find(BuildContext context) {
    return _resolve(maybeFind(context));
  }

  static EyeDropperLayerScope _resolve(EyeDropperLayerScope? found) {
    if (found == null) {
      throw FlutterError(
        'No EyeDropperLayerScope found in context. Wrap the tree with an '
        'EyeDropperLayer.',
      );
    }
    return found;
  }
}

/// Wraps a subtree and enables sampling colours from it.
///
/// While a picking session is active the layer freezes a screenshot of the
/// app root (or its own subtree when no root layer exists), follows the
/// pointer with a magnified loupe + crosshair and completes the session on
/// tap (click commits, Escape / right-click cancels). Arrow keys nudge 1px,
/// Enter commits.
class EyeDropperLayer extends StatefulWidget {
  /// Creates an eye-dropper layer.
  const EyeDropperLayer({
    super.key,
    required this.child,
    this.previewAlignment,
    this.showPreview,
    this.previewSize,
    this.previewScale,
    this.previewLabelBuilder,
    this.theme,
  });

  /// The subtree that can be sampled.
  final Widget child;

  /// Pins the preview to this alignment; null makes it follow the pointer.
  final AlignmentGeometry? previewAlignment;

  /// Whether the magnified preview is shown. Default: theme value (true).
  final bool? showPreview;

  /// Preview size override. Default: theme value (100x100), scaled.
  final Size? previewSize;

  /// Magnification override. Default: theme value (8).
  final double? previewScale;

  /// Custom label under the preview; defaults to the hex value.
  final PreviewLabelBuilder? previewLabelBuilder;

  /// Widget-leg style override, merged on top of the component/app/defaults.
  final EyeDropperTheme? theme;

  @override
  State<EyeDropperLayer> createState() => _EyeDropperLayerState();
}

/// One picking session: the completer plus the storages that joined it.
class _PickSession {
  _PickSession(this.completer, this.onSample);

  final Completer<Color?> completer;
  final EyeDropperSampleCallback? onSample;
  final Set<ColorHistoryStorage> storages = <ColorHistoryStorage>{};
}

class _EyeDropperLayerState extends State<EyeDropperLayer>
    implements EyeDropperLayerScope {
  final GlobalKey _boundaryKey = GlobalKey();
  final FocusNode _focusNode = FocusNode(debugLabel: 'EyeDropperLayer');

  ScreenCapture? _screen;
  ScreenSample? _preview;
  Offset? _position;
  _PickSession? _session;
  Timer? _refreshTimer;
  bool _recapturing = false;

  @override
  Future<Color?> promptPickColor([
    ColorHistoryStorage? historyStorage,
    EyeDropperSampleCallback? onSample,
  ]) async {
    if (!mounted) return null;
    // Nested layers delegate to the app-root scope so the capture and the
    // loupe cover the whole window, not just this subtree.
    final EyeDropperLayerScope? root = Data.maybeFindRoot<EyeDropperLayerScope>(
      context,
    );
    if (root != null && root != this) {
      return root.promptPickColor(historyStorage, onSample);
    }
    final _PickSession? active = _session;
    if (active != null) {
      final Future<Color?> future = active.completer.future;
      if (historyStorage == null || !active.storages.add(historyStorage)) {
        return future;
      }
      return future;
    }
    final double ratio = MediaQuery.devicePixelRatioOf(context);
    final ScreenCapture? screen = await captureRenderBoundary(
      _boundaryKey,
      pixelRatio: ratio,
    );
    if (!mounted || screen == null) return null;
    final _PickSession session = _PickSession(Completer<Color?>(), onSample);
    if (historyStorage != null) session.storages.add(historyStorage);
    setState(() {
      _session = session;
      _screen = screen;
      _position = null;
      _preview = null;
    });
    _focusNode.requestFocus();
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) => _refreshCapture(),
    );
    final Color? color = await session.completer.future;
    if (!mounted) return color;
    for (final ColorHistoryStorage storage in session.storages) {
      if (color != null) storage.addHistory(color);
    }
    return color;
  }

  Future<void> _refreshCapture() async {
    if (_session == null || _recapturing || !mounted) return;
    _recapturing = true;
    try {
      final double ratio = MediaQuery.devicePixelRatioOf(context);
      final ScreenCapture? screen = await captureRenderBoundary(
        _boundaryKey,
        pixelRatio: ratio,
      );
      if (!mounted || _session == null || screen == null) {
        screen?.dispose();
        return;
      }
      final Offset? position = _position;
      setState(() {
        _screen?.dispose();
        _screen = screen;
        if (position != null) _resample(position);
      });
    } finally {
      _recapturing = false;
    }
  }

  Size get _sampleSize {
    final ShadcnThemeData ambient = ShadcnTheme.of(context);
    final EyeDropperTheme style =
        resolveComponentStyle<EyeDropperTheme, EyeDropperTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: eyeDropperDefaults,
        );
    final Size previewSize =
        (widget.previewSize ?? style.previewSize ?? const Size(100, 100)) *
        ambient.scaling;
    final double previewScale = (widget.previewScale ?? style.previewScale ?? 8)
        .clamp(0.25, 64);
    return Size(
      previewSize.width / previewScale,
      previewSize.height / previewScale,
    );
  }

  bool get _showPreview {
    final EyeDropperTheme style =
        resolveComponentStyle<EyeDropperTheme, EyeDropperTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: eyeDropperDefaults,
        );
    return widget.showPreview ?? style.showPreview ?? true;
  }

  void _resample(Offset logical) {
    final ScreenCapture? screen = _screen;
    if (_session == null || screen == null) return;
    _position = logical;
    if (_showPreview || _session!.onSample != null) {
      _preview = screen.sampleLogical(logical, _sampleSize);
    }
    final EyeDropperSampleCallback? live = _session!.onSample;
    if (live != null && _preview != null) live(_preview!.pickedColor);
  }

  void _updatePreview(Offset logical) {
    if (_session == null || _screen == null || !mounted) return;
    setState(() => _resample(logical));
  }

  void _nudge(Offset delta) {
    final ScreenCapture? screen = _screen;
    if (_session == null || screen == null || !mounted) return;
    final double ratio = screen.pixelRatio <= 0 ? 1 : screen.pixelRatio;
    final Size logicalSize = Size(
      screen.size.width / ratio,
      screen.size.height / ratio,
    );
    final Offset base =
        _position ?? Offset(logicalSize.width / 2, logicalSize.height / 2);
    final Offset next = Offset(
      (base.dx + delta.dx).clamp(0, logicalSize.width - 1),
      (base.dy + delta.dy).clamp(0, logicalSize.height - 1),
    );
    setState(() => _resample(next));
  }

  void _complete(Color? color) {
    final _PickSession? session = _session;
    if (session == null || session.completer.isCompleted) return;
    session.completer.complete(color);
    _refreshTimer?.cancel();
    _refreshTimer = null;
    if (!mounted) {
      _screen?.dispose();
      _screen = null;
      _session = null;
      return;
    }
    setState(() {
      _session = null;
      _screen?.dispose();
      _screen = null;
      _preview = null;
      _position = null;
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    if (_session != null && !_session!.completer.isCompleted) {
      _session!.completer.complete(null);
    }
    _screen?.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (_session == null) return KeyEventResult.ignored;
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.escape:
        _complete(null);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.enter || LogicalKeyboardKey.numpadEnter:
        _complete(_preview?.pickedColor ?? _sampleAt(_position)?.pickedColor);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowLeft:
        _nudge(const Offset(-1, 0));
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowRight:
        _nudge(const Offset(1, 0));
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowUp:
        _nudge(const Offset(0, -1));
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowDown:
        _nudge(const Offset(0, 1));
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }
  }

  ScreenSample? _sampleAt(Offset? logical) {
    final ScreenCapture? screen = _screen;
    if (screen == null || logical == null) return null;
    return screen.sampleLogical(logical, _sampleSize);
  }

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData ambient = ShadcnTheme.of(context);
    final EyeDropperTheme style =
        resolveComponentStyle<EyeDropperTheme, EyeDropperTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: eyeDropperDefaults,
        );
    final Size previewSize =
        (widget.previewSize ?? style.previewSize ?? const Size(100, 100)) *
        ambient.scaling;
    final bool showPreview = widget.showPreview ?? style.showPreview ?? true;

    final ScreenCapture? screen = _screen;
    final ScreenSample? preview = _preview;
    final Offset? position = _position;
    final bool active = _session != null;
    return ForwardableData<EyeDropperLayerScope>(
      data: this,
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _onKey,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: screen == null
              ? null
              : (TapDownDetails details) =>
                    _complete(_sampleAt(details.localPosition)?.pickedColor),
          onSecondaryTapDown: active ? (_) => _complete(null) : null,
          child: MouseRegion(
            hitTestBehavior: HitTestBehavior.translucent,
            onHover: _session == null
                ? null
                : (PointerHoverEvent event) =>
                      _updatePreview(event.localPosition),
            child: IgnorePointer(
              ignoring: active,
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: <Widget>[
                  RepaintBoundary(key: _boundaryKey, child: widget.child),
                  if (screen != null)
                    Positioned.fill(
                      child: RawImage(image: screen.image, fit: BoxFit.fill),
                    ),
                  if (active && position != null)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _CrosshairPainter(
                            position: position,
                            color:
                                style.selectedBorderColor?.resolve(
                                  ambient.colors,
                                ) ??
                                ambient.colors.primary,
                          ),
                        ),
                      ),
                    ),
                  if (showPreview && preview != null && position != null)
                    _buildPreview(
                      context,
                      ambient,
                      style,
                      previewSize,
                      preview,
                      position,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(
    BuildContext context,
    ShadcnThemeData ambient,
    EyeDropperTheme style,
    Size previewSize,
    ScreenSample preview,
    Offset position,
  ) {
    final ShadcnColors colors = ambient.colors;
    final Widget previewBox = SizedBox(
      width: previewSize.width,
      height: previewSize.height,
      child: CustomPaint(
        painter: PixelGridPainter(
          colors: preview.colors,
          gridSize: preview.size,
          borderColor: style.borderColor?.resolve(colors) ?? colors.border,
          borderWidth: (style.borderWidth ?? 1) * ambient.scaling,
          selectedBorderColor:
              style.selectedBorderColor?.resolve(colors) ?? colors.primary,
          selectedBorderWidth:
              (style.selectedBorderWidth ?? 2) * ambient.scaling,
          backgroundColor:
              style.backgroundColor?.resolve(colors) ?? colors.background,
        ),
      ),
    );
    final TextDirection dir =
        Directionality.maybeOf(context) ?? TextDirection.ltr;
    final Widget label =
        widget.previewLabelBuilder?.call(context, preview.pickedColor) ??
        Directionality(
          textDirection: dir,
          child: Text(colorToHex(preview.pickedColor)).small().muted(),
        );
    final Widget stack = Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        previewBox,
        Positioned(bottom: -18 * ambient.scaling, child: label),
      ],
    );
    final AlignmentGeometry? alignment = widget.previewAlignment;
    if (alignment != null) {
      return Positioned.fill(
        child: Padding(
          padding: EdgeInsets.all(
            ambient.density.baseContainerPadding * ambient.scaling * 2,
          ),
          child: Align(alignment: alignment, child: stack),
        ),
      );
    }
    return Positioned(top: position.dy, left: position.dx, child: stack);
  }
}

/// Full-window crosshair through the sampled [position].
class _CrosshairPainter extends CustomPainter {
  const _CrosshairPainter({required this.position, required this.color});

  final Offset position;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, position.dy),
      Offset(size.width, position.dy),
      paint,
    );
    canvas.drawLine(
      Offset(position.dx, 0),
      Offset(position.dx, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CrosshairPainter old) =>
      old.position != position || old.color != color;
}

/// Prompts the user to pick a colour from the screen.
///
/// Uses the nearest [EyeDropperLayer] (delegating to the app-root scope for a
/// whole-window capture); optionally pushes the picked colour to [storage] and
/// streams live samples to [onSample]. Completes with null when cancelled.
Future<Color?> pickColorFromScreen(
  BuildContext context, [
  ColorHistoryStorage? storage,
  EyeDropperSampleCallback? onSample,
]) {
  return EyeDropperLayerScope.find(context).promptPickColor(storage, onSample);
}
