---
title: "Class: AppPageRoute"
description: "A route that displays a full-screen page with the upstream transition."
---

```dart
/// A route that displays a full-screen page with the upstream transition.
///
/// The registry replacement for `MaterialPageRoute`; it depends on nothing
/// outside `package:flutter/widgets.dart`.
///
/// ```dart
/// Navigator.of(context).push(
///   AppPageRoute(builder: (context) => const SettingsPage()),
/// );
/// ```
///
/// See also:
///
/// * [AppPage], the [Page] equivalent for declarative navigation (Router,
///   `go_router`, `Navigator.pages`).
class AppPageRoute<T> extends PageRoute<T> {
  /// Creates a page route that renders [builder] with the upstream transition.
  AppPageRoute({required this.builder, super.settings, this.maintainState = true, super.fullscreenDialog, this._opaque = true, this.transitionDuration = kPageTransitionDuration, this.barrierLabel});
  /// Builds the primary content of the route.
  final WidgetBuilder builder;
  final bool maintainState;
  final Duration transitionDuration;
  final String? barrierLabel;
  bool get opaque;
  Color? get barrierColor;
  /// Whether this route animates into [nextRoute].
  ///
  /// The old implementation answered `nextRoute is AppPageRoute`, so pushing
  /// a dialog, a drawer or any other route on top of a page skipped the page's
  /// exit transition. The framework default (`true`) is used instead.
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute);
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);
  String get debugLabel;
}
```
