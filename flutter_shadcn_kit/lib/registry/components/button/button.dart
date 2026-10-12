// The `button` component: the [Button] widget, the [ButtonGroup] layout, the
// per-state paint pipeline feeding the `Clickable` interaction primitive,
// and the async status machine (idle/loading/success/failure).
//
// One constructor plus `variant`/`size` enums replaces the old per-variant
// wrapper classes and named constructors (clean break, no aliases).

import 'dart:async';

import '../../foundation/geometry.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../foundation/gap.dart';
import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'button_defaults.dart';
import 'button_group.dart';
import 'button_layout.dart';
import 'button_status.dart';
import 'button_status_content.dart';
import 'button_style.dart';

export 'button_defaults.dart';
export 'button_group.dart' show ButtonGroup, ButtonGroupData;
export 'button_status.dart';
export 'button_status_content.dart';
export 'button_style.dart';

/// Opacity applied to the whole button while disabled (shadcn `opacity-50`).
const double _buttonDisabledOpacity = 0.5;

/// Cursor for an enabled button; the system arrow while disabled.
const _buttonMouseCursor = StateValue<MouseCursor>(
  rest: SystemMouseCursors.click,
  disabled: SystemMouseCursors.basic,
);

/// A pressable action control.
///
/// Use a [ButtonGroup] to connect several buttons; on/off state belongs to the
/// separate `Toggle` component. Rare gestures (secondary click, tap-down
/// tracking) are available through an outer `GestureDetector`.
///
/// Async work runs through [onPressedAsync]: the button enters loading
/// (spinner + gap + label, hugging its content, disabled), then success
/// (check) or failure (x/alert glyph, destructive tint) before auto-resetting
/// to idle; the width animates between states. Pass [status] to drive the
/// same visuals from parent-owned state.
class Button extends StatefulWidget {
  /// Creates a button.
  const Button({
    super.key,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.onPressed,
    this.onPressedAsync,
    this.status,
    this.successLabel,
    this.failureLabel,
    this.statusResetDuration = buttonDefaultStatusReset,
    this.onStatusChanged,
    this.onAsyncError,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.leading,
    this.trailing,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.theme,
  });

  /// Button content, usually a `Text` or an `Icon`.
  final Widget child;

  /// Visual variant. Defaults to [ButtonVariant.primary].
  final ButtonVariant variant;

  /// Fixed size row. Defaults to [ButtonSize.md].
  final ButtonSize size;

  /// Called on tap. When null (and [onPressedAsync] is null) the button is
  /// disabled unless [enabled] is true.
  final VoidCallback? onPressed;

  /// Async work run on tap. While it runs the button is loading and disabled;
  /// a normal return shows success, a throw shows failure and reports the
  /// error through [onAsyncError]. Ignored for state purposes when [status]
  /// is non-null (controlled mode still runs it as the press trigger).
  final Future<void> Function()? onPressedAsync;

  /// Parent-owned status. Non-null makes the button controlled: it renders
  /// this status and never changes it internally.
  final ButtonStatus? status;

  /// Label shown on success instead of [child]; null keeps [child].
  final Widget? successLabel;

  /// Label shown on failure instead of [child]; null keeps [child].
  final Widget? failureLabel;

  /// Auto-reset delay after success/failure. Null stays on the end state.
  final Duration? statusResetDuration;

  /// Called with every status the button enters, from either leg.
  final ValueChanged<ButtonStatus>? onStatusChanged;

  /// Receives the error thrown by [onPressedAsync] on failure.
  final void Function(Object error, StackTrace stackTrace)? onAsyncError;

  /// Called on long press. Ignored while the button is disabled.
  final VoidCallback? onLongPress;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;

  /// Widget shown before [child].
  final Widget? leading;

  /// Widget shown after [child].
  final Widget? trailing;

  /// Focus node. A node is created internally when [autofocus] is true and
  /// this is null; otherwise the internal `Clickable` owns its own node.
  final FocusNode? focusNode;

  /// Whether the button requests focus when first built.
  final bool autofocus;

  /// Overrides the enabled state; null means a press callback is set. The
  /// button is always disabled while loading, whatever this says.
  final bool? enabled;

  /// Widget-leg style override, merged on top of the component/app/defaults.
  final ButtonVariantStyle? theme;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  FocusNode? _ownedFocusNode;
  late final ButtonStatusController _controller;

  FocusNode? get _focusNode => widget.focusNode ?? _ownedFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = ButtonStatusController(
      resetDuration: widget.statusResetDuration,
      onError: widget.onAsyncError,
    );
    _controller.addListener(_handleStatusNotified);
    _syncAutofocus();
  }

  @override
  void didUpdateWidget(covariant Button oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller
      ..resetDuration = widget.statusResetDuration
      ..onError = widget.onAsyncError;
    if (widget.autofocus != oldWidget.autofocus ||
        widget.focusNode != oldWidget.focusNode) {
      _syncAutofocus();
    }
    // Controlled-leg changes report post-frame: the parent is already
    // rebuilding, so calling back synchronously could nest a setState.
    if (widget.status != oldWidget.status && widget.status != null) {
      final ButtonStatus next = widget.status!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onStatusChanged?.call(next);
      });
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleStatusNotified)
      ..dispose();
    _ownedFocusNode?.dispose();
    super.dispose();
  }

  void _handleStatusNotified() {
    widget.onStatusChanged?.call(_controller.status);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handlePress() async {
    widget.onPressed?.call();
    final Future<void> Function()? work = widget.onPressedAsync;
    if (work == null) {
      return;
    }
    if (widget.status != null) {
      // Controlled: the parent owns the status; run the work as the press
      // trigger, report errors, change nothing internally.
      try {
        await work();
      } catch (error, stackTrace) {
        widget.onAsyncError?.call(error, stackTrace);
      }
      return;
    }
    await _controller.run(work);
  }

  void _syncAutofocus() {
    if (!widget.autofocus) {
      _ownedFocusNode?.dispose();
      _ownedFocusNode = null;
      return;
    }
    if (widget.focusNode != null) {
      final FocusNode node = widget.focusNode!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          node.requestFocus();
        }
      });
      _ownedFocusNode?.dispose();
      _ownedFocusNode = null;
      return;
    }
    final FocusNode node = _ownedFocusNode ??= FocusNode(debugLabel: 'Button');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // The node may have been disposed by a rebuild that turned autofocus
      // off before this frame ran; only focus the live owned node.
      if (mounted && identical(_ownedFocusNode, node)) {
        node.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    final ButtonStatus effective = widget.status ?? _controller.status;
    final bool statusful =
        widget.status != null || widget.onPressedAsync != null;
    final bool enabled =
        (widget.enabled ??
            (widget.onPressed != null || widget.onPressedAsync != null)) &&
        effective != ButtonStatus.loading;
    final ButtonVariantStyle resolved =
        resolveComponentStyle<ButtonTheme, ButtonVariantStyle>(
          context,
          widget: widget.theme,
          select: (t) => t.forVariant(widget.variant),
          defaults: buttonDefaults.forVariant(widget.variant)!,
        );
    final Density density =
        ComponentTheme.maybeOf<ButtonTheme>(context)?.themeDensity ??
        ComponentThemes.maybeOf<ButtonTheme>(context)?.themeDensity ??
        theme.density;
    final ButtonSizeMetrics metrics = buttonMetricsFor(widget.size, density);
    final EdgeInsetsGeometry padding = resolved.padding ?? metrics.padding;
    final BorderRadius radius = _borderRadius(context, theme);
    final double borderWidth = resolved.borderWidth ?? 0;
    final bool hasBorder = resolved.borderColor != null && borderWidth > 0;
    final EdgeInsets resolvedPadding = padding.resolve(
      Directionality.of(context),
    );
    // The border is decoration padding and adds layout; inset the Clickable
    // padding by its width so bordered variants keep their size-table height.
    final EdgeInsets contentPadding = insetBorder(resolvedPadding, borderWidth);
    final ButtonPaintScheme paint = ButtonPaintScheme(
      theme: theme,
      resolved: resolved,
      metrics: metrics,
      radius: radius,
      borderWidth: borderWidth,
      hasBorder: hasBorder,
    );

    Widget content;
    if (!statusful) {
      content = widget.child;
      if (widget.leading != null || widget.trailing != null) {
        final double gap = theme.spacing.sm;
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.leading != null) widget.leading!,
            if (widget.leading != null) Gap(gap),
            content,
            if (widget.trailing != null) Gap(gap),
            if (widget.trailing != null) widget.trailing!,
          ],
        );
      }
    } else {
      content = ButtonStatusContent(
        variant: widget.variant,
        leading: widget.leading,
        trailing: widget.trailing,
        successLabel: widget.successLabel,
        failureLabel: widget.failureLabel,
        iconMode:
            widget.size == ButtonSize.icon &&
            widget.leading == null &&
            widget.trailing == null,
        effective: effective,
        foreground: paint.restForeground(),
        gap: theme.spacing.sm,
        child: widget.child,
      );
    }
    content = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: buttonInnerMin(
          metrics.minWidth,
          resolvedPadding,
          hasBorder ? borderWidth : 0,
          true,
        ),
        minHeight: buttonInnerMin(
          metrics.minHeight,
          resolvedPadding,
          hasBorder ? borderWidth : 0,
          false,
        ),
      ),
      child: Center(widthFactor: 1, heightFactor: 1, child: content),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : _buttonDisabledOpacity,
        child: Clickable(
          enabled: enabled,
          onPressed: enabled ? _handlePress : null,
          onLongPress: enabled ? widget.onLongPress : null,
          onHover: widget.onHover,
          onFocus: widget.onFocusChange,
          focusNode: _focusNode,
          decoration: WidgetStateProperty.resolveWith(paint.decorationFor),
          mouseCursor: _buttonMouseCursor,
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(contentPadding),
          textStyle: WidgetStateProperty.resolveWith(paint.textStyleFor),
          iconTheme: WidgetStateProperty.resolveWith(paint.iconThemeFor),
          child: content,
        ),
      ),
    );
  }

  BorderRadius _borderRadius(BuildContext context, ShadcnThemeData theme) {
    final ButtonGroupData? group = Data.maybeOf<ButtonGroupData>(context);
    final BorderRadius base = theme.borderRadiusMd;
    if (group == null) {
      return base;
    }
    return group.apply(base, Directionality.of(context));
  }
}
