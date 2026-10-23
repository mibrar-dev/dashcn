// The shared paint of a toolbar item: the pressable surface, the optional
// tooltip and the semantics wrapper.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../primitives/clickable.dart';
import '../../primitives/touch_hit_area.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../tooltip/tooltip.dart';
import 'toolbar_style.dart';

/// The shared paint of a toolbar item: the pressable surface, the optional
/// tooltip and the semantics wrapper.
class ToolbarItemSurface extends StatelessWidget {
  /// Creates an item surface.
  const ToolbarItemSurface({
    super.key,
    required this.style,
    required this.content,
    required this.enabled,
    required this.onPressed,
    required this.focusNode,
    required this.statesController,
    required this.semanticLabel,
    required this.toggled,
    this.shortcuts,
    this.actions,
    this.onFocus,
    this.onHover,
    this.tooltip,
  });

  /// The resolved item style.
  final ToolbarStyle style;

  /// The item's inner content.
  final Widget content;

  /// Whether the item accepts input.
  final bool enabled;

  /// Called on tap.
  final VoidCallback? onPressed;

  /// The item's focus node.
  final FocusNode focusNode;

  /// The item's state controller.
  final WidgetStatesController statesController;

  /// Accessible name of the item.
  final String? semanticLabel;

  /// Whether the item is a toggle that is currently on.
  final bool? toggled;

  /// The arrow-key map of the toolbar's roving group.
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// The action map of the toolbar's roving group.
  final Map<Type, Action<Intent>>? actions;

  /// Called when the item gains focus.
  final ValueChanged<bool>? onFocus;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;

  /// Hover label of the item.
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final double box = style.itemSize ?? 36;
    final double iconSize = style.iconSize ?? 18;
    final double touchVertical = math.max(
      0,
      (touchMinEdge(ambient.platform) - box) / 2,
    );

    Color? colorFor(StateValue<ThemedColor>? value, Set<WidgetState> states) {
      return value?.resolve(states)?.resolve(ambient.colors);
    }

    final Widget button = TouchHitArea(
      vertical: touchVertical,
      child: Semantics(
        button: true,
        enabled: enabled,
        toggled: toggled,
        label: semanticLabel,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Clickable(
            enabled: enabled,
            statesController: statesController,
            onPressed: enabled ? onPressed : null,
            onHover: onHover,
            onFocus: onFocus,
            focusNode: focusNode,
            shortcuts: shortcuts,
            actions: actions,
            mouseCursor: const StateValue<MouseCursor>(
              rest: SystemMouseCursors.click,
              disabled: SystemMouseCursors.basic,
            ),
            decoration: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
              return BoxDecoration(
                color: colorFor(style.itemBackground, s),
                borderRadius: ambient.borderRadiusMd,
              );
            }),
            textStyle: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
              final Color? color = colorFor(style.itemForeground, s);
              return (style.textStyle ?? toolbarDefaultTextStyle).copyWith(
                color: color,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
              final Color? color = colorFor(style.itemForeground, s);
              return IconThemeData(color: color, size: iconSize);
            }),
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.zero,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box),
              child: content,
            ),
          ),
        ),
      ),
    );

    final String? tooltip = this.tooltip;
    if (tooltip == null) {
      return button;
    }
    return Tooltip(
      tooltip: (BuildContext context) => Text(tooltip),
      semanticLabel: semanticLabel ?? tooltip,
      child: button,
    );
  }
}
