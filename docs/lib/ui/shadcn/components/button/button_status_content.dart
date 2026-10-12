// The status content for the `button` component (`P7-S1`, dynamic width per
// user 2026-10-11): the button ALWAYS hugs its current content — idle shows
// the label (+ its own leading/trailing) only, loading shows the spinner +
// gap + label, success/failure show the status icon + gap + label. The width
// change animates smoothly ([AnimatedSize] over the status transition,
// instant under reduced motion) and the icon cross-fades; there is no
// reserved/min-width slot, so siblings in a row move with the animation.
// Full-width buttons (expand / tight parent) keep the parent width: the
// `Center` in `Button` still stretches the content box, only the row inside
// hugs.
//
// Split from `button_status.dart` (the machine) so each file stays under the
// size guide. Not independently installable; ships inside `button`.

import 'package:flutter/widgets.dart';

import '../spinner/spinner.dart';
import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'button_status.dart';
import 'button_style.dart';

/// Cross-fading leading icon for a statusful button.
///
/// Shows [idle] (the button's own leading, possibly null) while
/// [status] is idle and the status glyph otherwise; the widget hugs
/// whichever child is live — nothing is reserved. Non-idle icons carry
/// the live-region announcement. The spinner is only built while loading,
/// so an idle button never hosts a ticking animation.
class ButtonStatusIcon extends StatelessWidget {
  /// Creates a status icon.
  const ButtonStatusIcon({
    super.key,
    required this.idle,
    required this.status,
    required this.statusIcon,
    required this.transition,
  });

  /// Widget shown while idle (the button's leading; null shows nothing).
  final Widget? idle;

  /// Current machine state.
  final ButtonStatus status;

  /// Icon shown while non-idle (spinner, check or failure glyph).
  final Widget statusIcon;

  /// Cross-fade duration; zero swaps instantly (reduced motion).
  final Duration transition;

  @override
  Widget build(BuildContext context) {
    final bool active = status != ButtonStatus.idle;
    final String? announcement = buttonStatusAnnouncement(status);
    return AnimatedSwitcher(
      duration: transition,
      // The exit drops instantly: a fading-out spinner would linger in
      // the tree (and in the semantics announcements) while the next
      // state is already live. Entries still animate over `transition`.
      reverseDuration: Duration.zero,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) =>
          currentChild ?? const SizedBox.shrink(),
      // A boundary: the announcement keeps its exact label instead of
      // merging with the button label at an ancestor.
      child: active
          ? Semantics(
              key: ValueKey<ButtonStatus>(status),
              container: true,
              liveRegion: true,
              label: announcement,
              child: statusIcon,
            )
          : (idle == null
                ? const SizedBox.shrink(key: ValueKey<String>('status-no-idle'))
                : KeyedSubtree(
                    key: const ValueKey<String>('status-idle'),
                    child: idle!,
                  )),
    );
  }
}

/// The button label, cross-fading to [successLabel]/[failureLabel] when set.
///
/// Only the shown label is laid out, so the button hugs the live label's
/// width; the swap fades over [transition] (instant under reduced motion).
/// With no overrides the idle label renders directly (no extra layer).
class ButtonStatusLabel extends StatelessWidget {
  /// Creates a status label.
  const ButtonStatusLabel({
    super.key,
    required this.effective,
    required this.transition,
    required this.idle,
    this.successLabel,
    this.failureLabel,
  });

  /// Current machine state.
  final ButtonStatus effective;

  /// Cross-fade duration; zero swaps instantly (reduced motion).
  final Duration transition;

  /// Label for idle/loading (and success/failure without an override).
  final Widget idle;

  /// Optional label replacing [idle] on success.
  final Widget? successLabel;

  /// Optional label replacing [idle] on failure.
  final Widget? failureLabel;

  @override
  Widget build(BuildContext context) {
    Widget shown = idle;
    if (effective == ButtonStatus.success && successLabel != null) {
      shown = successLabel!;
    } else if (effective == ButtonStatus.failure && failureLabel != null) {
      shown = failureLabel!;
    }
    if (successLabel == null && failureLabel == null) {
      return shown;
    }
    return AnimatedSwitcher(
      duration: transition,
      reverseDuration: Duration.zero,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) =>
          currentChild ?? const SizedBox.shrink(),
      child: KeyedSubtree(
        key: ValueKey<ButtonStatus>(
          identical(shown, idle) ? ButtonStatus.idle : effective,
        ),
        child: shown,
      ),
    );
  }
}

/// Statusful button content: a hugging row that animates its width.
///
/// Icon buttons (icon mode: icon size, no leading/trailing) swap the child
/// itself inside the fixed size-table box. Otherwise the row is
/// `[leading|status icon] gap [label] [gap trailing]` wrapped in
/// [AnimatedSize] (ease-out over the status transition; instant under
/// reduced motion), so the button hugs each state's content and glides
/// between widths. The row follows the ambient text direction, so the
/// icon mirrors under RTL.
class ButtonStatusContent extends StatelessWidget {
  /// Creates statusful content.
  const ButtonStatusContent({
    super.key,
    required this.variant,
    this.leading,
    this.trailing,
    required this.child,
    this.successLabel,
    this.failureLabel,
    required this.iconMode,
    required this.effective,
    required this.foreground,
    required this.gap,
  });

  /// Button variant (drives the destructive-variant failure tint).
  final ButtonVariant variant;

  /// Widget shown before the label while idle.
  final Widget? leading;

  /// Widget shown after the label in every state.
  final Widget? trailing;

  /// Idle label (and the icon-mode child).
  final Widget child;

  /// Optional label replacing [child] on success.
  final Widget? successLabel;

  /// Optional label replacing [child] on failure.
  final Widget? failureLabel;

  /// Whether to swap the child itself (icon button without adornments).
  final bool iconMode;

  /// Current machine state.
  final ButtonStatus effective;

  /// Resolved rest foreground for status icons that inherit it.
  final Color foreground;

  /// Gap between the icon and the label (and before the trailing).
  final double gap;

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    final ButtonStatusStyle statusStyle =
        resolveComponentStyle<ButtonTheme, ButtonStatusStyle>(
          context,
          select: (ButtonTheme t) => t.status,
          defaults: buttonStatusDefaults,
        );
    final bool reducedMotion =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final Duration transition = reducedMotion
        ? Duration.zero
        : (statusStyle.transitionDuration ?? buttonDefaultStatusTransition);
    final Widget icon = resolveButtonStatusIcon(
      status: effective,
      style: statusStyle,
      colors: theme.colors,
      foreground: foreground,
      destructiveVariant: variant == ButtonVariant.destructive,
      reducedMotion: reducedMotion,
    );
    if (iconMode) {
      // Icon buttons keep the fixed size-table box; only the glyph
      // cross-fades inside it.
      return AnimatedSwitcher(
        duration: transition,
        reverseDuration: Duration.zero,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) =>
            currentChild ?? const SizedBox.shrink(),
        child: effective == ButtonStatus.idle
            ? KeyedSubtree(
                key: const ValueKey<String>('status-icon-idle'),
                child: child,
              )
            : Semantics(
                key: ValueKey<ButtonStatus>(effective),
                container: true,
                liveRegion: true,
                label: buttonStatusAnnouncement(effective),
                child: icon,
              ),
      );
    }
    final bool showIcon = effective != ButtonStatus.idle || leading != null;
    // AnimatedSize cannot run a zero-duration animation: it would complete
    // synchronously inside its own layout (self-mutation). Reduced motion
    // renders the hugging row directly — the swap is instant by design.
    final Widget row = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (showIcon)
          ButtonStatusIcon(
            idle: leading,
            status: effective,
            statusIcon: icon,
            transition: transition,
          ),
        if (showIcon) Gap(gap),
        // The label shrinks instead of overflowing: it hugs its full width
        // when there is room (its max intrinsic width is the full label, so
        // roomy layouts are pixel-identical) and wraps when the parent is
        // narrower than the content (a 320px docs stage, a tight block
        // column). Caller-owned labels wrap by default; single-line labels
        // keep their own overflow contract.
        Flexible(
          child: ButtonStatusLabel(
            effective: effective,
            transition: transition,
            idle: child,
            successLabel: successLabel,
            failureLabel: failureLabel,
          ),
        ),
        if (trailing != null) ...<Widget>[Gap(gap), trailing!],
      ],
    );
    if (transition == Duration.zero) {
      return row;
    }
    return AnimatedSize(
      duration: transition,
      curve: Curves.easeOut,
      alignment: Alignment.center,
      child: row,
    );
  }
}

/// Builds the status icon for a non-idle [status].
///
/// Loading shows the [Spinner] in the button foreground (or
/// [ButtonStatusStyle.loadingColor]); under reduced motion it shows the
/// static [ButtonStatusStyle.loadingIcon] glyph instead. Success shows the
/// check glyph in the foreground; failure shows the failure glyph in the
/// destructive token — except for the destructive variant, which is already
/// red and keeps the foreground.
Widget resolveButtonStatusIcon({
  required ButtonStatus status,
  required ButtonStatusStyle style,
  required ShadcnColors colors,
  required Color foreground,
  required bool destructiveVariant,
  required bool reducedMotion,
}) {
  final double iconSize = style.statusIconSize ?? buttonDefaultStatusIconSize;
  switch (status) {
    case ButtonStatus.idle:
      return const SizedBox.shrink();
    case ButtonStatus.loading:
      final Color color = style.loadingColor?.resolve(colors) ?? foreground;
      if (reducedMotion) {
        return Icon(
          style.loadingIcon ?? buttonDefaultLoadingIcon,
          size: iconSize,
          color: color,
        );
      }
      return Spinner(
        size: style.spinnerSize ?? buttonDefaultSpinnerSize,
        color: color,
      );
    case ButtonStatus.success:
      return Icon(
        style.successIcon ?? buttonDefaultSuccessIcon,
        size: iconSize,
        color: style.successColor?.resolve(colors) ?? foreground,
      );
    case ButtonStatus.failure:
      final Color fallback = destructiveVariant
          ? foreground
          : colors.destructive;
      return Icon(
        style.failureIcon ?? buttonDefaultFailureIcon,
        size: iconSize,
        color: style.failureColor?.resolve(colors) ?? fallback,
      );
  }
}
