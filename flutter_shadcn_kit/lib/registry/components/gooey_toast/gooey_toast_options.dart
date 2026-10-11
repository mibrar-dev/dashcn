// Public content and behaviour types of the `gooey_toast` component: the
// state/position/direction/behaviour enums, the autopilot and morph policies,
// the action and the toast options.
//
// Split out of `gooey_toast.dart` so each file stays readable; that file
// re-exports this one, so existing imports keep working.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/gooey/gooey_content.dart';
import '../../primitives/color_math.dart';
import '../../primitives/toast_queue/toast_placement.dart';
import '../../theme/color_tokens.dart';
import 'gooey_toast_style.dart';

/// Semantic state of a gooey toast; picks the default icon and tone.
enum GooeyToastState {
  success,
  loading,
  error,
  warning,
  info,
  action;

  /// Default compact icon for this state; `action` follows [direction].
  IconData iconIn(TextDirection direction) => switch (this) {
    GooeyToastState.success => LucideIcons.check,
    GooeyToastState.loading => LucideIcons.loaderCircle,
    GooeyToastState.error => LucideIcons.x,
    GooeyToastState.warning => LucideIcons.triangleAlert,
    GooeyToastState.info => LucideIcons.info,
    GooeyToastState.action =>
      direction == TextDirection.rtl
          ? LucideIcons.arrowLeft
          : LucideIcons.arrowRight,
  };

  /// Resolved accent colour for this state.
  ///
  /// Every state defaults to a fixed tone (identical in every mode and preset);
  /// the tone then passes through [ensureToneContrast], so user overrides and
  /// exotic surfaces keep the 3:1 floor too.
  Color tone(GooeyToastTheme theme, ShadcnColors colors) {
    final ThemedColor? ref = switch (this) {
      GooeyToastState.success => theme.successTone,
      GooeyToastState.loading => theme.loadingTone,
      GooeyToastState.error => theme.errorTone,
      GooeyToastState.warning => theme.warningTone,
      GooeyToastState.info => theme.infoTone,
      GooeyToastState.action => theme.actionTone,
    };
    final Color surface = theme.fill?.resolve(colors) ?? colors.popover;
    return ensureToneContrast(
      ref!.resolve(colors),
      surface: surface,
      foreground: colors.foreground,
    );
  }
}

/// Blends [tone] toward [foreground] until its contrast on [surface] reaches
/// [minRatio] (3:1, the non-text UI floor).
///
/// Returns [tone] untouched when it already passes, so stable tones stay
/// identical across modes and presets; returns [foreground] when no blend
/// passes (a surface too close to the tone in both directions).
Color ensureToneContrast(
  Color tone, {
  required Color surface,
  required Color foreground,
  double minRatio = 3,
}) {
  if (contrastRatio(tone, surface) >= minRatio) {
    return tone;
  }
  for (int i = 1; i <= 20; i++) {
    final Color candidate = Color.lerp(tone, foreground, i / 20)!;
    if (contrastRatio(candidate, surface) >= minRatio) {
      return candidate;
    }
  }
  return foreground;
}

/// Horizontal anchor of a gooey toast.
enum GooeyToastPosition {
  left,
  center,
  right;

  /// Screen placement this anchor maps to for [expandDirection].
  ///
  /// `bottom` grows the body downwards from the top edge; `top` grows it
  /// upwards from the bottom edge.
  ToastPlacement placement(GooeyToastExpandDirection expandDirection) {
    final bool top = expandDirection == GooeyToastExpandDirection.bottom;
    return switch (this) {
      GooeyToastPosition.left =>
        top ? ToastPlacement.topLeading : ToastPlacement.bottomLeading,
      GooeyToastPosition.center =>
        top ? ToastPlacement.topCenter : ToastPlacement.bottomCenter,
      GooeyToastPosition.right =>
        top ? ToastPlacement.topTrailing : ToastPlacement.bottomTrailing,
    };
  }
}

/// Vertical growth direction of the expanded body.
enum GooeyToastExpandDirection {
  /// The body grows downwards, anchoring the toast to the top edge.
  bottom,

  /// The body grows upwards, anchoring the toast to the bottom edge.
  top,
}

/// Strategy when a new toast is shown in an occupied slot.
enum GooeyToastNewToastBehavior {
  /// Adds the new toast to the same slot stack.
  stack,

  /// Removes the existing toasts in the slot first.
  dismissPrevious,

  /// Updates the newest toast in the slot in place.
  transition,
}

/// Auto expand/collapse policy of a shown toast.
///
/// Delays are relative to when the toast appears (expand) and when it opens
/// (collapse). `Duration.zero` expands immediately or disables the collapse
/// schedule; a null autopilot disables both, leaving expansion to hover, press
/// and tap only.
class GooeyAutopilot {
  /// Creates an autopilot policy.
  const GooeyAutopilot({
    this.expandDelay = const Duration(milliseconds: 150),
    this.collapseDelay = const Duration(milliseconds: 4000),
  });

  /// Delay before the body expands after the toast appears.
  final Duration? expandDelay;

  /// Delay before the body collapses back once it has expanded.
  final Duration? collapseDelay;

  /// Delay before auto-expansion starts.
  Duration get resolvedExpandDelay =>
      expandDelay ?? const Duration(milliseconds: 150);

  /// Delay before auto-collapse starts.
  Duration get resolvedCollapseDelay =>
      collapseDelay ?? const Duration(milliseconds: 4000);
}

/// Inline action shown in the expanded body.
class GooeyToastAction {
  /// Creates an action.
  const GooeyToastAction({required this.label, required this.onPressed});

  final String label;

  final VoidCallback onPressed;
}

/// Content and behaviour of one gooey toast.
///
/// The toast lifecycle is: enter as a compact pill, morph open after the
/// autopilot expand delay, stay expanded until the collapse delay, collapse
/// back to the pill, then leave when the `duration` expires (6s by default).
/// Hover, press or focus pauses the countdown; swipe in the slot's dismiss
/// direction, the close button, Escape while focused, or
/// `GooeyToastController.dismiss` dismisses early. A `loading` toast never
/// expands; show one, await the work, then show the settled state with
/// [GooeyToastNewToastBehavior.transition] for the promise pattern.
class GooeyToastOptions {
  /// Creates toast options.
  const GooeyToastOptions({
    required this.title,
    this.description,
    this.state = GooeyToastState.success,
    this.position = GooeyToastPosition.center,
    this.expandDirection = GooeyToastExpandDirection.bottom,
    this.duration,
    this.icon,
    this.stateTag,
    this.compactChild,
    this.expandedChild,
    this.action,
    this.autopilot = const GooeyAutopilot(),
    this.persistUntilDismissed = false,
    this.animationStyle,
    this.shapeStyle,
    this.bodyAnimationStyle,
    this.width,
    this.roundness,
    this.compactMorph,
    this.onExpansionChanged,
  });

  final String title;

  final String? description;

  final GooeyToastState state;

  /// Horizontal anchor; `center` renders at the top-center window edge with
  /// the default expand direction.
  final GooeyToastPosition position;

  final GooeyToastExpandDirection expandDirection;

  final Duration? duration;

  final IconData? icon;

  /// Identity of the compact content: change it (with the same toast id) to
  /// morph the pill instead of replacing the toast.
  final Object? stateTag;

  /// Custom compact row replacing the default icon + title.
  final Widget? compactChild;

  final Widget? expandedChild;

  final GooeyToastAction? action;

  /// Auto expand/collapse policy; null leaves expansion to interaction.
  final GooeyAutopilot? autopilot;

  final bool persistUntilDismissed;

  /// Open/close profile override; falls back to the theme, then `sileo`.
  final GooeyToastAnimationStyle? animationStyle;

  /// Corner profile override; falls back to the theme, then `defaultShape`.
  final GooeyToastShapeStyle? shapeStyle;

  /// Body content profile override; falls back to the theme, then `fade`.
  final GooeyToastBodyAnimationStyle? bodyAnimationStyle;

  /// Surface width override; falls back to the theme, then `350`.
  final double? width;

  /// Base roundness override; falls back to the theme, then `18`.
  final double? roundness;

  /// Compact morph override; falls back to the theme, then the default.
  final GooeyCompactMorph? compactMorph;

  /// Called with `true` when the body starts opening and `false` when closed.
  final ValueChanged<bool>? onExpansionChanged;
}

/// Snapshot of one active toast, newest first in
/// `GooeyToastController.activeToasts`.
class GooeyToastDetails {
  /// Creates a snapshot.
  const GooeyToastDetails({
    required this.id,
    required this.stateTag,
    required this.title,
    required this.description,
    required this.state,
    required this.position,
    required this.expandDirection,
    required this.duration,
    required this.persistUntilDismissed,
    required this.updatedAt,
  });

  /// Unique toast id.
  final String id;

  /// State discriminator of the compact content.
  final Object? stateTag;

  /// Current compact title.
  final String title;

  /// Current expanded description.
  final String? description;

  /// Current semantic state.
  final GooeyToastState state;

  /// Horizontal anchor.
  final GooeyToastPosition position;

  /// Vertical growth direction.
  final GooeyToastExpandDirection expandDirection;

  /// Configured lifetime before dismiss.
  final Duration duration;

  /// Whether the toast waits for a manual dismiss.
  final bool persistUntilDismissed;

  /// Timestamp of the last update.
  final DateTime updatedAt;
}
