// The `gooey_toast` component: gooey-style transient notifications whose
// compact pill morphs into an expanded body.
//
// This file owns the public surface — [GooeyToastLayer], the
// [GooeyToastController] lookup and the one-card renderer — and re-exports the
// theme (`gooey_toast_style.dart`), the content types
// (`gooey_toast_options.dart`) and the controller/render contract
// (`gooey_toast_controller.dart`). The metaball machinery is the
// `primitives/gooey/` layer; the controller inserts its entries into the ROOT
// overlay, so toasts anchor to the window edge instead of the local box.

import 'package:flutter/widgets.dart';

import '../../primitives/gooey/gooey_chip.dart';
import '../../primitives/gooey/gooey_frame.dart';
import '../../primitives/gooey/gooey_surface.dart';
import '../../primitives/gooey/gooey_swipe.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'gooey_toast_controller.dart';
import 'gooey_toast_options.dart';
import 'gooey_toast_style.dart';

export 'gooey_toast_controller.dart';
export 'gooey_toast_options.dart';
export 'gooey_toast_style.dart';

/// Nearest [GooeyToastController] from a [GooeyToastLayer].
GooeyToastController? gooeyToastControllerOf(BuildContext context) =>
    GooeyToastScope.maybeOf(context)?.controller;

/// Theme of the nearest [GooeyToastLayer], resolved from the global tokens.
GooeyToastTheme gooeyToastThemeOfScoped(BuildContext context) =>
    GooeyToastScope.maybeOf(context)?.theme ?? gooeyToastThemeOf(context);

/// Shows a gooey toast through the enclosing layer's controller.
///
/// `behavior` defaults to `transition` when the caller reuses an id, so a
/// second `show` with the same id animates the pill instead of stacking a
/// duplicate; pass `stack`/`dismissPrevious` explicitly to override that.
String showGooeyToast(
  BuildContext context,
  GooeyToastOptions options, {
  String? id,
  GooeyToastNewToastBehavior? behavior,
  Duration? duration,
  bool autoDismiss = true,
  VoidCallback? onDismissed,
}) {
  final GooeyToastScope? scope = GooeyToastScope.maybeOf(context);
  assert(scope != null, 'No GooeyToastLayer found above this context');
  return scope!.controller.showGooeyToast(
    context,
    options,
    id: id,
    behavior: behavior,
    duration: duration,
    autoDismiss: autoDismiss,
    onDismissed: onDismissed,
  );
}

/// Resolves the compact-pill anchor for the ambient direction: the shared
/// `GooeySurface` primitive takes a physical [Alignment], so the directional
/// [GooeyToastPosition.alignment] is resolved here against the current
/// `Directionality`.
Alignment _compactAlignmentOf(
  BuildContext context,
  GooeyToastPosition position,
) {
  final bool rtl = Directionality.of(context) == TextDirection.rtl;
  return switch (position) {
    GooeyToastPosition.left =>
      rtl ? Alignment.centerRight : Alignment.centerLeft,
    GooeyToastPosition.center => Alignment.center,
    GooeyToastPosition.right =>
      rtl ? Alignment.centerLeft : Alignment.centerRight,
  };
}

/// Hosts a [GooeyToastController] and renders its toasts above [child].
///
/// Wrap the app (or a demo viewport): the controller inserts into the root
/// overlay, so toasts anchor to the window edge and never cover their own
/// trigger. Disposing the layer's controller clears its toasts.
class GooeyToastLayer extends StatefulWidget {
  /// Creates a gooey toast layer.
  const GooeyToastLayer({
    super.key,
    required this.child,
    this.controller,
    this.theme,
  });

  /// Content below the toasts.
  final Widget child;

  /// Injected controller; one is owned when null.
  final GooeyToastController? controller;

  /// Widget-leg theme override.
  final GooeyToastTheme? theme;

  @override
  State<GooeyToastLayer> createState() => _GooeyToastLayerState();
}

class _GooeyToastLayerState extends State<GooeyToastLayer> {
  GooeyToastController? _owned;

  GooeyToastController get _controller => widget.controller ?? _owned!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _owned = GooeyToastController();
    }
  }

  @override
  void didUpdateWidget(covariant GooeyToastLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == oldWidget.controller) {
      return;
    }
    if (oldWidget.controller == null) {
      _owned?.dispose();
      _owned = null;
    }
    if (widget.controller == null) {
      _owned = GooeyToastController();
    }
  }

  @override
  void dispose() {
    _owned?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GooeyToastTheme theme = gooeyToastThemeOf(
      context,
      widget: widget.theme,
    );
    return GooeyToastScope(
      controller: _controller,
      theme: theme,
      child: widget.child,
    );
  }
}

/// Renders one live toast: the metaball surface wrapped in the swipe-to-dismiss
/// gesture. There is no close button (dismiss is by timeout, swipe or the
/// controller's `dismiss`), matching the reference.
///
/// Owned by the controller's overlay entries; the compact pill and body are
/// the shared `GooeySurface` primitive, so the backdrop blur, the reduced-motion
/// policy and the density spacing all come from the ambient theme rather than
/// from this component.
class GooeyToastCard extends StatelessWidget {
  /// Creates a toast card.
  const GooeyToastCard({
    super.key,
    required this.payload,
    required this.controller,
  });

  /// Resolved content and geometry of this toast.
  final GooeyToastPayload payload;

  /// Controller that owns the toast.
  final GooeyToastController controller;

  @override
  Widget build(BuildContext context) {
    final GooeyToastPayload payload = this.payload;
    final ShadcnThemeData ambient = ShadcnTheme.of(context);
    final GooeyToastTheme theme = gooeyToastThemeOf(context);
    final ShadcnColors colors = ambient.colors;
    // Resolve the tone against a theme that carries only this toast's fill:
    // the global `ComponentThemes` leg still supplies the tone refs.
    final GooeyToastTheme toneTheme = gooeyToastThemeOf(
      context,
    ).copyWith(fill: () => payload.fill);
    final Color tone = payload.state.tone(toneTheme, colors);
    // The title shares the status tone with the icon (the reference behaviour);
    // `ensureToneContrast` has already lifted the tone to the 3:1 floor.
    final TextStyle titleStyle = gooeyTitleTextStyle.copyWith(color: tone);
    final TextStyle descriptionStyle = gooeyDescriptionTextStyle.copyWith(
      color:
          (theme.descriptionColor ??
                  const ThemedColor.ref(ColorRef.mutedForeground))
              .resolve(colors),
    );
    final double surfaceBlur = (ambient.surfaceBlur ?? 0)
        .clamp(0.0, 36.0)
        .toDouble();
    final Color baseFill = payload.fill.resolve(colors);
    // Composite the gooey shape layers fully opaque, then fade the whole group:
    // painting the crisp layer translucent exposes a gray rim, because the
    // gooey threshold erodes the silhouette and the band between the eroded
    // edge and the crisp edge would only be covered once at partial alpha.
    final double blurFactor = 1 - (surfaceBlur / 36) * 0.35;
    final double fillAlpha =
        (baseFill.a *
                (ambient.surfaceOpacity ?? 1).clamp(0.0, 1.0).toDouble() *
                blurFactor)
            .clamp(0.0, 1.0)
            .toDouble();
    final bool reducedMotion =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final List<BoxShadow> shadows = reducedMotion
        ? const <BoxShadow>[]
        : ambient.tokens.shadows.shadowLg;
    final bool loading = payload.state == GooeyToastState.loading;
    final TextDirection direction = Directionality.of(context);
    final GooeyAutopilot? autopilot = payload.autopilot;
    final Widget surface = GooeySurface(
      title: payload.title,
      titleStyle: titleStyle,
      morphKey: payload.stateTag ?? '${payload.title}|${payload.state.name}',
      leading: payload.compactChild == null
          ? GooeyStateIcon(
              icon: payload.icon ?? payload.state.iconIn(direction),
              color: tone,
              loading: loading,
            )
          : const SizedBox.shrink(),
      description: payload.description,
      descriptionStyle: descriptionStyle,
      body: payload.expandedChild,
      action: payload.action == null
          ? null
          : GooeyActionChip(
              label: payload.action!.label,
              color: tone,
              onPressed: payload.action!.onPressed,
            ),
      expandable: !loading,
      width: payload.width,
      fill: ThemedColor.value(baseFill.withValues(alpha: 1)),
      fillAlpha: fillAlpha,
      roundness: payload.shapeStyle.roundness(
        payload.roundness,
        kGooeySurfacePillHeight,
      ),
      shadows: shadows,
      compactAlignment: _compactAlignmentOf(context, payload.position),
      expandUp: payload.expandUp,
      enableGooeyBlur: !reducedMotion,
      surfaceBlur: surfaceBlur,
      openDuration: reducedMotion
          ? Duration.zero
          : payload.animationStyle.duration,
      openCurve: payload.animationStyle.curve,
      bodyAnimation: reducedMotion
          ? GooeySurfaceBodyAnimation.none
          : payload.bodyAnimationStyle.animation(),
      expandDelay: autopilot?.resolvedExpandDelay,
      collapseDelay: autopilot?.resolvedCollapseDelay,
      compactMorph: payload.compactMorph,
      onInteractionChanged: (bool interacting) =>
          controller.setInteracting(payload.id, interacting),
      onExpansionChanged: payload.onExpansionChanged,
    );
    return GooeySwipe(
      directions: payload.placement.dismissDirections,
      onDismissed: () => controller.dismiss(payload.id),
      child: surface,
    );
  }
}
