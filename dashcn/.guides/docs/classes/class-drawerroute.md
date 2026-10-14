---
title: "Class: DrawerRoute"
description: "Reference for DrawerRoute"
---

```dart
class DrawerRoute<T> extends ModalRoute<T> {
  DrawerRoute({required this.builder, required this.position, required this.themeOf, required this.duration, required this.barrierDismissible, required this.useSafeArea, required this.expands, required this.draggable, required this.showDragHandle, required this.isSheet, required this.openerFocus, this.borderRadius, this.maxSize, this.barrierLabel, this.themes, this.data, super.settings, super.traversalEdgeBehavior});
  final WidgetBuilder builder;
  final OverlayPosition position;
  final DrawerRouteTheme Function(BuildContext context) themeOf;
  final Duration duration;
  /// Whether the barrier tap / Escape pops the panel.
  final bool barrierDismissible;
  /// Semantic label of the dismissible barrier.
  final String? barrierLabel;
  final bool useSafeArea;
  final bool expands;
  final bool draggable;
  final bool showDragHandle;
  final bool isSheet;
  final FocusNode? openerFocus;
  final BorderRadius? borderRadius;
  final double? maxSize;
  final CapturedThemes? themes;
  final CapturedData? data;
  Color? get barrierColor;
  bool get opaque;
  bool get maintainState;
  Duration get transitionDuration;
  Duration get reverseTransitionDuration;
  AnimationController? get dragController;
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);
  Widget buildModalBarrier();
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);
}
```
