// Background-scale capability for drawer/sheet routes.
//
// When a drawer or sheet opens, the app content behind scales down slightly
// (≈0.95) with rounded corners and dims — like vaul / the shadcn drawer.
// The scale follows the panel route's own animation, so it animates in and
// out with the sheet (including drag scrubs); reduced motion disables the
// transform; `enabled: false` opts out.
//
// Wiring (app root):
// ```dart
// final DrawerScaleObserver observer = DrawerScaleObserver();
// ShadcnApp(
//   navigatorObservers: <NavigatorObserver>[observer],
//   home: DrawerBackgroundScale(observer: observer, child: shell),
// );
// ```
//
// The observer only reacts to `ShadcnDrawerRoute` (drawer + sheet), so
// dialogs, popovers and pages never scale the background.

import 'package:flutter/widgets.dart';

import '../../primitives/drawer_route/drawer_panel.dart';

/// Observes drawer/sheet routes and publishes their open progress 0..1.
///
/// Bind it to the app navigator (`ShadcnApp(navigatorObservers:)`) and hand
/// it to [DrawerBackgroundScale]. Progress follows the topmost drawer route's
/// animation, so scrubs and reversals track frame-by-frame.
class DrawerScaleObserver extends NavigatorObserver {
  /// Open progress of the topmost drawer/sheet route (0 closed, 1 open).
  final ValueNotifier<double> progress = ValueNotifier<double>(0);

  final Map<Route<dynamic>, VoidCallback> _detach =
      <Route<dynamic>, VoidCallback>{};

  void _bind(Route<dynamic> route) {
    if (route is! ShadcnDrawerRoute<dynamic>) {
      return;
    }
    final Animation<double>? animation = route.animation;
    if (animation == null) {
      progress.value = 1;
      return;
    }
    void listener() {
      progress.value = animation.value.clamp(0.0, 1.0);
    }

    animation.addListener(listener);
    _detach[route] = () => animation.removeListener(listener);
    listener();
  }

  void _unbind(Route<dynamic> route) {
    final VoidCallback? remove = _detach.remove(route);
    remove?.call();
    if (_detach.isEmpty) {
      progress.value = 0;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _bind(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _unbind(route);
    if (previousRoute != null &&
        previousRoute is ShadcnDrawerRoute<dynamic> &&
        !_detach.containsKey(previousRoute)) {
      _bind(previousRoute);
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _unbind(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) {
      _unbind(oldRoute);
    }
    if (newRoute != null) {
      _bind(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

/// Scales, rounds and dims [child] while a drawer/sheet route is open.
///
/// Place at the app root (above the shell, below the theme). Non-drawer
/// routes never trigger it.
class DrawerBackgroundScale extends StatelessWidget {
  /// Creates the background wrapper.
  const DrawerBackgroundScale({
    super.key,
    required this.child,
    required this.observer,
    this.enabled = true,
    this.scale = 0.95,
    this.cornerRadius = 16,
    this.dimOpacity = 0.25,
  });

  /// Content behind drawers/sheets (the app shell).
  final Widget child;

  /// Observer bound to the app navigator.
  final DrawerScaleObserver observer;

  /// Opt-out: `false` never transforms, even with a drawer open.
  final bool enabled;

  /// Scale of the background when fully open. Default 0.95.
  final double scale;

  /// Corner radius at full open, scaled by the progress.
  final double cornerRadius;

  /// Black dim opacity at full open, scaled by the progress.
  final double dimOpacity;

  @override
  Widget build(BuildContext context) {
    final bool reduced = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return ValueListenableBuilder<double>(
      valueListenable: observer.progress,
      builder: (BuildContext context, double progress, Widget? cached) {
        // Stable structure: the wrapper chain (Stack > ClipRRect >
        // Transform) is ALWAYS mounted with the same keys; only paint-level
        // values (scale, radius, dim alpha) follow the progress. Mounting or
        // unmounting ancestors around the whole shell reparents its entire
        // render subtree on the push/pop frame, which trips a framework
        // semantics assertion (`identical(childRenderObject,
        // parentRenderObject)` in computeChildGeometry) under large trees.
        // At rest everything is identity/transparent, so the wrappers are
        // layout-, paint- and hit-test-neutral.
        final bool active = enabled && !reduced && progress > 0;
        final double s = active ? 1 - (1 - scale) * progress : 1.0;
        final double radius = active ? cornerRadius * progress : 0;
        final double dim = active
            ? (dimOpacity * progress).clamp(0.0, 1.0).toDouble()
            : 0;
        return Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Transform.scale(
                key: const ValueKey<String>('drawer-background-scale'),
                scale: s,
                child: cached,
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                ignoring: dim <= 0,
                child: ColoredBox(
                  color: const Color(0xFF000000).withValues(alpha: dim),
                ),
              ),
            ),
          ],
        );
      },
      child: child,
    );
  }
}
