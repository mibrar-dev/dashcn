---
title: "Class: AppPage"
description: "A [Page] that creates a [AppPageRoute]."
---

```dart
/// A [Page] that creates a [AppPageRoute].
///
/// The registry replacement for `MaterialPage`, for use with declarative
/// navigation APIs such as [Navigator.pages] or `go_router`.
///
/// ```dart
/// Navigator(
///   pages: [
///     AppPage(key: const ValueKey('home'), child: const HomePage()),
///     if (showSettings)
///       AppPage(key: const ValueKey('settings'), child: const SettingsPage()),
///   ],
///   onDidRemovePage: (page) {},
/// );
/// ```
class AppPage<T> extends Page<T> {
  /// Creates a page backed by a [AppPageRoute].
  const AppPage({required this.child, this.maintainState = true, this.fullscreenDialog = false, this.transitionDuration = kPageTransitionDuration, super.key, super.canPop, super.onPopInvoked, super.name, super.arguments, super.restorationId});
  /// The content to show for this page.
  final Widget child;
  /// Whether to keep the page's state alive while it is covered.
  final bool maintainState;
  /// Whether the page is presented as a modal dialog.
  final bool fullscreenDialog;
  /// How long the push and pop animation runs for.
  final Duration transitionDuration;
  Route<T> createRoute(BuildContext context);
}
```
