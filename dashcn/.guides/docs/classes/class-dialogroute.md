---
title: "Class: DialogRoute"
description: "Modal route of a upstream dialog."
---

```dart
/// Modal route of a upstream dialog.
///
/// Extends the widgets [ModalRoute] directly: the modal scope, the initial
/// focus and the barrier plumbing all come from the framework route. The card
/// is built by [_DialogShell], the barrier by [_DialogBarrier], and the
/// transition is a scale plus a fade. Both private widgets read this route.
class DialogRoute<T> extends ModalRoute<T> {
  /// Creates a dialog route. Only [duration] is resolved by the caller; every
  /// other value is read from this route's subtree on each build.
  DialogRoute({required this.builder, required this.widgetTheme, required this.duration, required this.barrierDismissible, required this.useSafeArea, required this.alignment, required this.fullScreen, required this.openerFocus, this.barrierColorOverride, this.barrierLabel, this.themes, this.data, super.settings, super.traversalEdgeBehavior});
  /// Builds the dialog content (the card itself is the shell).
  final WidgetBuilder builder;
  /// Widget leg of the [DialogTheme] resolver; the other legs are read from
  /// this route's subtree.
  final DialogTheme? widgetTheme;
  /// Open and close transition duration, resolved when the route was pushed.
  final Duration duration;
  /// Barrier color override; `null` resolves [DialogTheme.barrierColor].
  final ThemedColor? barrierColorOverride;
  /// Whether tapping the barrier pops the dialog.
  final bool barrierDismissible;
  /// Semantic label of the dismissible barrier; `null` resolves
  /// [ComponentLocalizations.dialogDismiss].
  final String? barrierLabel;
  /// Whether the content respects the device safe area.
  final bool useSafeArea;
  /// Alignment of the card inside the route when not full screen.
  final AlignmentGeometry alignment;
  /// Whether the dialog fills the route (no radius, border, shadow, inset).
  final bool fullScreen;
  /// Focus node focused before the dialog opened, restored on close.
  final FocusNode? openerFocus;
  /// Themes captured from the opening context. Re-injected into the barrier
  /// and the card, so a theme below the navigator stays visible in the route.
  final CapturedThemes? themes;
  /// Data captured from the opening context.
  final CapturedData? data;
  /// Always null: [buildModalBarrier] resolves the color itself so it follows
  /// the ambient theme.
  Color? get barrierColor;
  bool get opaque;
  bool get maintainState;
  Duration get transitionDuration;
  Duration get reverseTransitionDuration;
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);
  /// Resolves the barrier on every barrier build, so a light/dark switch or a
  /// preset change restyles an open dialog.
  Widget buildModalBarrier();
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);
}
```
