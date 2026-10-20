// The visual machinery of a text field: the surface shell (decoration,
// gesture detector, focus ring, hover/disabled states, error text) and the
// row that lays out adornments around the editable text.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../focus_outline.dart';
import '../motion/error_shake.dart';
import '../motion/motion_collapse.dart';
import '../motion/motion_enter.dart';
import '../motion/motion_scope.dart';

/// The standard visual shell around a text field's content.
///
/// Paints [decoration], wraps [child] in the gesture detector, draws the focus
/// ring, tracks hover through [onHover] and dims/ignores input while disabled.
/// An optional [errorText] is rendered below the field.
class EditableTextShell extends StatelessWidget {
  /// Creates a shell.
  const EditableTextShell({
    super.key,
    required this.child,
    required this.decoration,
    required this.padding,
    required this.gestureBuilder,
    required this.focused,
    required this.enabled,
    required this.minHeight,
    this.borderRadius,
    this.errorText,
    this.errorStyle,
    this.gap = 4,
    this.hitBehavior = HitTestBehavior.translucent,
    this.onHover,
    this.showFocusRing = true,
  });

  /// The field content, usually an [EditableTextFieldRow].
  final Widget child;

  /// Field surface decoration.
  final Decoration decoration;

  /// Corner radius of the focus ring.
  final BorderRadiusGeometry? borderRadius;

  /// Padding between the surface and [child].
  final EdgeInsetsGeometry padding;

  /// Gesture builder from the [EditableTextHost].
  final TextSelectionGestureDetectorBuilder gestureBuilder;

  /// Whether the focus ring is shown.
  final bool focused;

  /// Whether [focused] paints the ring; false keeps caret/selection only.
  final bool showFocusRing;

  /// Whether the field accepts input; false dims and ignores pointers.
  final bool enabled;

  /// Minimum field height.
  final double minHeight;

  /// Error message rendered below the field.
  final String? errorText;

  /// Style of [errorText].
  final TextStyle? errorStyle;

  /// Gap between the field and [errorText].
  final double gap;

  /// Hit-test behavior of the gesture detector.
  final HitTestBehavior hitBehavior;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;

  @override
  Widget build(BuildContext context) {
    Widget field = Container(
      decoration: decoration,
      child: gestureBuilder.buildGestureDetector(
        behavior: hitBehavior,
        child: Padding(padding: padding, child: child),
      ),
    );
    field = MouseRegion(
      cursor: enabled ? SystemMouseCursors.text : SystemMouseCursors.forbidden,
      onEnter: (_) => onHover?.call(true),
      onExit: (_) => onHover?.call(false),
      child: FocusOutline(
        focused: focused && showFocusRing,
        borderRadius: borderRadius,
        child: field,
      ),
    );
    field = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: field,
    );
    field = Semantics(
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: IgnorePointer(ignoring: !enabled, child: field),
      ),
    );
    final message = errorText;
    // The message stays mounted while its collapse exit plays, so clearing
    // the error shrinks the message away instead of cutting it. The wrapper
    // only mounts while showing or exiting (see [_ShellError]).
    field = _ShellError(
      message: message,
      gap: gap,
      errorStyle: errorStyle,
      child: field,
    );
    return field;
  }
}

/// Error message under the field, mounted only while showing or exiting.
///
/// A wrapper [Column] loosens the field's height constraint (flex lays out
/// non-flex children unbounded), which overflows fixed-height rows that the
/// bare field fits. While settled with no message this returns [child]
/// directly — the pre-motion tree — and only mounts the column for the
/// enter and the collapse exit. Under reduced motion the message cuts
/// instantly, so the column never mounts for the hide.
class _ShellError extends StatefulWidget {
  /// Creates the error wrapper.
  const _ShellError({
    required this.message,
    required this.gap,
    required this.errorStyle,
    required this.child,
  });

  /// Error message rendered below the field; null hides it.
  final String? message;

  /// Gap between the field and [message].
  final double gap;

  /// Style of [message].
  final TextStyle? errorStyle;

  /// The field content.
  final Widget child;

  @override
  State<_ShellError> createState() => _ShellErrorState();
}

class _ShellErrorState extends State<_ShellError> {
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.message != null;
  }

  @override
  void didUpdateWidget(covariant _ShellError oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != null) {
      _open = true;
    }
  }

  void _handleExited() {
    // Runs when the collapse finishes — or synchronously inside the child's
    // update under reduced motion. Always defer past the exiting frame, and
    // schedule that frame: a bare post-frame callback never runs while the
    // scheduler is idle.
    WidgetsBinding.instance.scheduleFrame();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.message == null) {
        setState(() => _open = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? message = widget.message;
    if (message == null && (!_open || motionReduced(context))) {
      return widget.child;
    }
    return ErrorShake(
      trigger: message,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.child,
          MotionCollapse(
            visible: message != null,
            onExited: _handleExited,
            child: message == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(top: widget.gap),
                    child: MotionEnter(
                      child: Text(message, style: widget.errorStyle),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Lays out leading/trailing adornments around an editable child, with a
/// placeholder (widget or hint text) stacked under the text while empty.
class EditableTextFieldRow extends StatelessWidget {
  /// Creates a field row.
  const EditableTextFieldRow({
    super.key,
    required this.editable,
    required this.showPlaceholder,
    this.placeholder,
    this.hintText,
    this.hintStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.gap = 4,
  });

  /// The editable text widget.
  final Widget editable;

  /// Whether the field is empty and the placeholder may show.
  final bool showPlaceholder;

  /// Placeholder widget; wins over [hintText].
  final Widget? placeholder;

  /// Placeholder text.
  final String? hintText;

  /// Style of [hintText].
  final TextStyle? hintStyle;

  /// Alignment of [hintText].
  final TextAlign textAlign;

  /// Maximum lines of [hintText].
  final int? maxLines;

  /// Widgets before the editable text.
  final List<Widget> leading;

  /// Widgets after the editable text.
  final List<Widget> trailing;

  /// Gap between adornments and the text.
  final double gap;

  Widget? _resolvedPlaceholder() {
    if (!showPlaceholder) {
      return null;
    }
    if (placeholder != null) {
      return placeholder;
    }
    final hint = hintText;
    if (hint == null) {
      return null;
    }
    return Text(
      hint,
      style: hintStyle,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

  Widget _group(List<Widget> children) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < children.length; i++) ...<Widget>[
          if (i > 0) Gap(gap),
          children[i],
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = _resolvedPlaceholder();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (leading.isNotEmpty) ...<Widget>[_group(leading), Gap(gap)],
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              if (placeholder != null) IgnorePointer(child: placeholder),
              editable,
            ],
          ),
        ),
        if (trailing.isNotEmpty) ...<Widget>[Gap(gap), _group(trailing)],
      ],
    );
  }
}
