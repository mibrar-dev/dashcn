// The `signature_pad` component: [SignaturePad], a widgets-only capture
// surface with midpoint-quadratic smoothing, speed-based stroke width and
// undo/redo/clear through [SignaturePadController].
//
// Ink appearance is frozen per stroke at capture time, so undo/redo and
// export keep the exact look when the ambient theme changes afterwards.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import 'signature_pad_controller.dart';
import 'signature_pad_style.dart';

export 'signature_pad_controller.dart';
export 'signature_pad_style.dart';

/// Fallback pad width when the incoming constraints are unbounded.
const double _signaturePadFallbackWidth = 320;

/// Paints committed [strokes] plus the in-progress [active] stroke with the
/// shared [paintSignatureStrokes] rasterizer, so the pad and PNG export
/// always match. Public so a custom pad layout can reuse it.
class SignaturePadPainter extends CustomPainter {
  /// Creates a painter.
  const SignaturePadPainter({required this.strokes, required this.active});

  /// Committed strokes.
  final List<SignatureStroke> strokes;

  /// In-progress stroke (null while the pointer is up).
  final SignatureStroke? active;

  @override
  void paint(Canvas canvas, Size size) {
    paintSignatureStrokes(
      canvas,
      active == null ? strokes : <SignatureStroke>[...strokes, active!],
    );
  }

  @override
  bool shouldRepaint(covariant SignaturePadPainter oldDelegate) {
    return !identical(oldDelegate.strokes, strokes) ||
        oldDelegate.active != active;
  }
}

/// A freehand signature capture surface.
///
/// Strokes smooth through midpoint quadratics; fast movement narrows the ink
/// from [strokeWidth] towards [minStrokeWidth] unless [variableWidth] is
/// false. The pad reports every mutation (draw, undo, redo, clear, restore)
/// through [onChanged] with the current stroke count.
///
/// ```dart
/// final SignaturePadController controller = SignaturePadController();
/// SignaturePad(controller: controller, onChanged: (count) => ...);
/// Button(onPressed: controller.undo, child: Text('Undo'));
/// ```
class SignaturePad extends StatefulWidget {
  /// Creates a signature pad.
  const SignaturePad({
    super.key,
    this.controller,
    this.strokeColor,
    this.background,
    this.strokeWidth,
    this.minStrokeWidth,
    this.variableWidth,
    this.height = 200,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.semanticsLabel,
    this.theme,
  });

  /// Owns the strokes; created and disposed internally when null.
  final SignaturePadController? controller;

  /// Ink colour override; null resolves the theme's stroke colour.
  final Color? strokeColor;

  /// Pad surface override; null resolves the theme's background.
  final Color? background;

  /// Rest stroke width override; null resolves the theme's width.
  final double? strokeWidth;

  /// At-speed stroke width override; null resolves the theme's minimum.
  final double? minStrokeWidth;

  /// Speed-narrowing override; null resolves the theme's flag.
  final bool? variableWidth;

  /// Pad height in logical pixels (multiplied by `scaling`).
  final double height;

  /// False dims the pad and ignores input.
  final bool enabled;

  /// True ignores input without dimming (a committed signature stays vivid).
  final bool readOnly;

  /// Called with the stroke count after every mutation.
  final ValueChanged<int>? onChanged;

  /// Accessible label; null reads `'Signature pad'`.
  final String? semanticsLabel;

  /// Widget-leg theme override, merged on top of the other legs.
  final SignaturePadTheme? theme;

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  SignaturePadController? _internal;
  SignaturePadController? _listened;
  List<SignaturePoint>? _activePoints;
  Color? _activeColor;
  double? _activeWidth;
  double? _activeMinWidth;
  bool? _activeVariable;

  SignaturePadController get _controller => widget.controller ?? _internal!;

  bool get _interactive => widget.enabled && !widget.readOnly;

  void _listenTo(SignaturePadController controller) {
    if (identical(_listened, controller)) {
      return;
    }
    _listened?.removeListener(_forwardCount);
    _listened = controller;
    controller.addListener(_forwardCount);
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internal = SignaturePadController();
    }
    _listenTo(_controller);
  }

  @override
  void didUpdateWidget(covariant SignaturePad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (widget.controller == null) {
        _internal ??= SignaturePadController();
      } else {
        _internal?.dispose();
        _internal = null;
      }
      _listenTo(_controller);
    }
  }

  @override
  void dispose() {
    _listened?.removeListener(_forwardCount);
    _internal?.dispose();
    super.dispose();
  }

  void _forwardCount() => widget.onChanged?.call(_controller.strokeCount);

  _ResolvedPad _resolve(ThemeData theme) {
    final SignaturePadTheme style =
        resolveComponentStyle<SignaturePadTheme, SignaturePadTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: signaturePadDefaults,
        );
    final ThemeColors colors = theme.colors;
    final double scaling = theme.scaling;
    return _ResolvedPad(
      strokeColor:
          widget.strokeColor ??
          style.strokeColor?.resolve(colors) ??
          signaturePadDefaults.strokeColor!.resolve(colors),
      background:
          widget.background ??
          style.background?.resolve(colors) ??
          signaturePadDefaults.background!.resolve(colors),
      borderColor:
          style.borderColor?.resolve(colors) ??
          signaturePadDefaults.borderColor!.resolve(colors),
      borderWidth:
          (style.borderWidth ?? signaturePadDefaults.borderWidth!) * scaling,
      borderRadius:
          (style.borderRadius ?? signaturePadDefaults.borderRadius!) * scaling,
      strokeWidth: widget.strokeWidth ?? style.strokeWidth ?? 3,
      minWidth: widget.minStrokeWidth ?? style.minStrokeWidth ?? 1,
      variableWidth: widget.variableWidth ?? style.variableWidth ?? true,
    );
  }

  void _beginPan(DragStartDetails details, _ResolvedPad pad) {
    setState(() {
      _activePoints = <SignaturePoint>[
        SignaturePoint(details.localPosition, DateTime.now()),
      ];
      _activeColor = pad.strokeColor;
      _activeWidth = pad.strokeWidth;
      _activeMinWidth = pad.minWidth;
      _activeVariable = pad.variableWidth;
    });
  }

  void _updatePan(DragUpdateDetails details) {
    final List<SignaturePoint>? points = _activePoints;
    if (points == null) {
      return;
    }
    setState(() {
      points.add(SignaturePoint(details.localPosition, DateTime.now()));
    });
  }

  void _endPan() {
    final List<SignaturePoint>? points = _activePoints;
    if (points == null) {
      return;
    }
    setState(() {
      _activePoints = null;
    });
    if (points.isEmpty) {
      return;
    }
    _controller.addStroke(
      SignatureStroke(
        points: points,
        color: _activeColor!,
        width: _activeWidth!,
        minWidth: _activeMinWidth!,
        variableWidth: _activeVariable!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final _ResolvedPad pad = _resolve(theme);
    final SignatureStroke? active =
        _activePoints == null || _activePoints!.isEmpty
        ? null
        : SignatureStroke(
            points: _activePoints!,
            color: _activeColor ?? pad.strokeColor,
            width: _activeWidth ?? pad.strokeWidth,
            minWidth: _activeMinWidth ?? pad.minWidth,
            variableWidth: _activeVariable ?? pad.variableWidth,
          );
    return Semantics(
      label:
          widget.semanticsLabel ??
          ComponentLocalizations.of(context).signaturePadLabel,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      child: Opacity(
        opacity: widget.enabled ? 1 : 0.5,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : _signaturePadFallbackWidth;
            return SizedBox(
              width: width,
              height: widget.height * theme.scaling,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: pad.background,
                  borderRadius: BorderRadius.circular(pad.borderRadius),
                  border: Border.all(
                    color: pad.borderColor,
                    width: pad.borderWidth,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(pad.borderRadius),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: _interactive
                        ? (DragStartDetails details) => _beginPan(details, pad)
                        : null,
                    onPanUpdate: _interactive ? _updatePan : null,
                    onPanEnd: _interactive
                        ? (DragEndDetails _) => _endPan()
                        : null,
                    onPanCancel: _interactive
                        ? () => setState(() => _activePoints = null)
                        : null,
                    child: ListenableBuilder(
                      listenable: _controller,
                      builder: (BuildContext context, Widget? _) {
                        return CustomPaint(
                          painter: SignaturePadPainter(
                            strokes: _controller.strokes,
                            active: active,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Ink and surface values after the four-leg theme resolution.
class _ResolvedPad {
  const _ResolvedPad({
    required this.strokeColor,
    required this.background,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.strokeWidth,
    required this.minWidth,
    required this.variableWidth,
  });

  final Color strokeColor;
  final Color background;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double strokeWidth;
  final double minWidth;
  final bool variableWidth;
}
