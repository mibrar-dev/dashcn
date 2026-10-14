---
title: "Class: AppPageTransition"
description: "The upstream page transition: a fade combined with a short vertical slide."
---

```dart
/// The upstream page transition: a fade combined with a short vertical slide.
///
/// Shared by [AppPageRoute] and [AppPage] so a route and a declarative
/// page look identical. Built from one [SlideTransition], so a page adds
/// exactly one [Transform] to the tree.
///
/// The tween pairs are instance fields rather than `static final`: they are
/// `Animatable`s, which cannot be `const`, and a lazily-initialised static
/// would be global mutable state.
class AppPageTransition extends StatelessWidget {
  /// Creates a upstream page transition.
  const AppPageTransition({super.key, required this.animation, required this.child});
  /// Drives the incoming page.
  final Animation<double> animation;
  /// The page content.
  final Widget child;
  Widget build(BuildContext context);
}
```
