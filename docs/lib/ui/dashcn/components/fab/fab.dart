// The `fab` component: [Fab], the floating action button.
//
// A raised, round (or pill) button that floats over the page content. It is
// a *floating surface*, so its fill goes through the shared
// `primitives/surface.dart` primitive (`surfaceColor` + `GlassSurface`) and
// the ambient `ThemeData.surfaceOpacity` / `surfaceBlur` apply to it.
//
// The helpers live next to it: [FabSpeedDial] (the expanding dial),
// [FabPositioner] (the positions helper) and [FabHideOnScroll] (hide on
// scroll).

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../primitives/clickable.dart';
import '../../primitives/surface.dart';
import '../../primitives/touch_hit_area.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../../theme/tokens.dart';
import '../tooltip/tooltip.dart';
import 'fab_content.dart';
import 'fab_style.dart';

export 'fab_content.dart';
export 'fab_hide_on_scroll.dart';
export 'fab_positioner.dart';
export 'fab_speed_dial.dart';
export 'fab_style.dart';

/// Opacity applied to the whole button while disabled.
const double _fabDisabledOpacity = 0.5;

/// Cursor for an enabled button; the system arrow while disabled.
const _fabMouseCursor = StateValue<MouseCursor>(
  rest: SystemMouseCursors.click,
  disabled: SystemMouseCursors.basic,
);

/// A floating action button.
///
/// The button is round when only [icon] is given and becomes a pill when
/// [label] is added. Every visible part is a slot: [icon], [label] and
/// [content] can each be swapped by the caller.
///
/// Pass [semanticLabel] or [tooltip] so assistive technology can announce
/// the button; an icon alone carries no name.
class Fab extends StatefulWidget {
  /// Creates a floating action button.
  const Fab({
    super.key,
    this.icon,
    this.label,
    this.content,
    this.size = FabSize.md,
    this.onPressed,
    this.enabled = true,
    this.tooltip,
    this.semanticLabel,
    this.style,
    this.theme,
    this.focusNode,
    this.autofocus = false,
    this.onHover,
    this.onFocusChange,
    this.shape,
  });

  /// The leading icon slot; usually an `Icon`.
  final Widget? icon;

  /// The trailing label slot. Its presence switches the button to the
  /// extended (pill) shape.
  final Widget? label;

  /// Replaces the whole inner content (icon plus label) when non-null.
  final Widget? content;

  /// Fixed size of the button box. Defaults to [FabSize.md].
  final FabSize size;

  /// Called on tap. A null callback disables the button.
  final VoidCallback? onPressed;

  /// Whether the button accepts input. Defaults to true; a null [onPressed]
  /// also disables it.
  final bool enabled;

  /// Hover label shown after the tooltip delay.
  final String? tooltip;

  /// Accessible name; null falls back to the label's text.
  final String? semanticLabel;

  /// Widget-leg style override, merged over the component/app/defaults.
  final FabStyle? style;

  /// Generic widget-leg style override, merged under [style].
  final FabStyle? theme;

  /// Focus node. A node is created internally when [autofocus] is true and
  /// this is null.
  final FocusNode? focusNode;

  /// Whether the button requests focus when first built.
  final bool autofocus;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;

  /// Forces the painted shape; null derives it from [label].
  final FabShape? shape;

  /// Whether the button paints the extended (pill) shape.
  bool get isExtended => label != null;

  /// The shape this button paints.
  FabShape get resolvedShape =>
      shape ?? (isExtended ? FabShape.extended : FabShape.standard);

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  final WidgetStatesController _states = WidgetStatesController();
  FocusNode? _ownedFocusNode;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  @override
  void didUpdateWidget(covariant Fab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autofocus && !oldWidget.autofocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _ownedFocusNode?.dispose();
    _states.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final bool enabled = widget.enabled && widget.onPressed != null;
    final FabShape shape = widget.resolvedShape;
    final FabStyle resolved = resolveComponentStyle<FabTheme, FabStyle>(
      context,
      widget: widget.style == null
          ? widget.theme
          : (widget.theme == null
                ? widget.style
                : widget.style!.merge(widget.theme!)),
      select: (FabTheme t) => t.forShape(shape),
      defaults: fabDefaults.forShape(shape)!,
    );

    final double box = resolved.size ?? fabBoxFor(widget.size, shape);
    final double iconSize = resolved.iconSize ?? fabIconFor(widget.size, shape);
    final double gap = resolved.gap ?? fabDefaultGap;
    final bool hasBorder =
        resolved.borderColor != null && (resolved.borderWidth ?? 0) > 0;
    final double borderWidth = resolved.borderWidth ?? 0;

    Color? colorFor(StateValue<ThemedColor>? value, Set<WidgetState> states) {
      return value?.resolve(states)?.resolve(ambient.colors);
    }

    final BorderRadiusGeometry radius =
        resolved.borderRadius ?? BorderRadius.circular(box / 2);

    // Touch comfort is an invisible hit-test/semantics expansion, never the
    // painted circle and never layout.
    final double touchVertical = math.max(
      0,
      (touchMinEdge(ambient.platform) - box) / 2,
    );

    final double elevation = resolved.elevation ?? 0;
    // Shadows come from the theme tokens, not a hand-rolled formula: the
    // elevation step picks a shadow scale entry (mini elevation 2 -> Md,
    // standard/extended elevation 3 -> Lg). A per-instance shadowColor tints
    // the token shadows; without one the token colour stands.
    List<BoxShadow> tokenShadowsFor(double level) {
      final ShadowScale base = ambient.tokens.shadows;
      if (level <= 0) return const <BoxShadow>[];
      if (level <= 1) return base.shadowSm;
      if (level <= 2) return base.shadowMd;
      if (level <= 3) return base.shadowLg;
      return base.shadowXl;
    }

    final Color? tint = resolved.shadowColor?.resolve(ambient.colors);
    final List<BoxShadow> shadows = elevation <= 0
        ? const <BoxShadow>[]
        : (tint == null
              ? tokenShadowsFor(elevation)
              : <BoxShadow>[
                  for (final BoxShadow s in tokenShadowsFor(elevation))
                    BoxShadow(
                      color: Color.fromARGB(
                        (s.color.a * 255).round().clamp(0, 255),
                        (tint.r * 255).round().clamp(0, 255),
                        (tint.g * 255).round().clamp(0, 255),
                        (tint.b * 255).round().clamp(0, 255),
                      ),
                      offset: s.offset,
                      blurRadius: s.blurRadius,
                      spreadRadius: s.spreadRadius,
                    ),
                ]);

    final Widget content = buildFabContent(
      context: context,
      content: widget.content,
      icon: widget.icon,
      label: widget.label,
      resolved: resolved,
      box: box,
      gap: gap,
    );

    final Widget button = TouchHitArea(
      vertical: touchVertical,
      child: Semantics(
        button: true,
        enabled: enabled,
        label: widget.semanticLabel ?? _labelText,
        child: Opacity(
          opacity: enabled ? 1 : _fabDisabledOpacity,
          child: Clickable(
            enabled: enabled,
            statesController: _states,
            onPressed: enabled ? widget.onPressed : null,
            onHover: widget.onHover,
            onFocus: widget.onFocusChange,
            focusNode: _focusNode,
            autofocus: widget.autofocus,
            mouseCursor: _fabMouseCursor,
            decoration: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
              final Color? fill = colorFor(resolved.background, s);
              final Color? line = colorFor(resolved.borderColor, s);
              return BoxDecoration(
                color: surfaceColor(
                  fill ?? ambient.colors.primary,
                  resolveSurfaceOpacity(
                    context,
                    widget: resolved.surfaceOpacity,
                  ),
                ),
                borderRadius: radius,
                border: hasBorder
                    ? Border.all(
                        color: line ?? const Color(0x00000000),
                        width: borderWidth,
                      )
                    : null,
              );
            }),
            textStyle: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
              final Color? color = colorFor(resolved.foreground, s);
              return (resolved.textStyle ?? fabDefaultTextStyle).copyWith(
                color: color,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
              final Color? color = colorFor(resolved.foreground, s);
              return IconThemeData(color: color, size: iconSize);
            }),
            child: content,
          ),
        ),
      ),
    );

    // The shadow lives outside the frosted clip so it is never cut off; the
    // fill and its blur live inside it.
    final Widget surfaced = DecoratedBox(
      decoration: BoxDecoration(borderRadius: radius, boxShadow: shadows),
      child: GlassSurface(
        surfaceBlur: resolveSurfaceBlur(context, widget: resolved.surfaceBlur),
        borderRadius: radius,
        child: button,
      ),
    );

    final String? tooltip = widget.tooltip;
    if (tooltip == null) {
      return surfaced;
    }
    return Tooltip(
      tooltip: (BuildContext context) => Text(tooltip),
      semanticLabel: widget.semanticLabel ?? tooltip,
      child: surfaced,
    );
  }

  /// The label's text when the label is a plain `Text`; else null.
  String? get _labelText {
    final Widget? label = widget.label;
    if (label is Text) {
      return label.data;
    }
    return null;
  }
}
