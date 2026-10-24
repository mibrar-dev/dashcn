// Playground scope: which component's playground currently drives the page.
//
// When the component page opens its right-side playground, the playground's
// canvas becomes the single live preview (the left column drops its duplicate
// main preview card) and every example on the page that uses the component
// re-renders from the same playground values — so the page changes together.
// The code tabs keep the original per-example sources, preserving deliberate
// per-example overrides in documentation.
//
// The scope carries the active component id (null = playground closed) and
// the active theme override (null = site theme defaults).
// Live values travel through `DocsState.playgroundQuery` (`p.*` and `t.*`),
// so reload/back-forward keep working and no second source of truth is
// introduced.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/theme/theme.dart';

/// Which playground (if any) drives the surrounding page.
class PlaygroundScope extends InheritedWidget {
  /// Creates the scope.
  const PlaygroundScope({
    super.key,
    required this.activeComponentId,
    this.themeOverride,
    required super.child,
  });

  /// The component id whose playground is open, or null when closed.
  final String? activeComponentId;

  /// The live theme token override for previews and examples, or null.
  final ThemeData? themeOverride;

  /// Whether [componentId]'s playground currently drives the page.
  bool drives(String componentId) => activeComponentId == componentId;

  @override
  bool updateShouldNotify(covariant PlaygroundScope oldWidget) {
    return oldWidget.activeComponentId != activeComponentId ||
        oldWidget.themeOverride != themeOverride;
  }

  /// Nearest scope, or null outside a component page.
  static PlaygroundScope? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<PlaygroundScope>();
  }
}
