// The scope data and the pressable item of the `toolbar` component.
//
// An item reads its visuals from the toolbar that owns it (through the
// `ToolbarItemData` scope) and falls back to the ambient theme when it is
// used on its own. Every interactive item registers with the toolbar's
// roving group, so the arrow keys walk the items.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../primitives/roving_group.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'toolbar_item_surface.dart';
import 'toolbar_style.dart';

/// What the toolbar tells its items about itself.
class ToolbarItemData {
  /// Creates the scope data.
  const ToolbarItemData({
    required this.index,
    required this.axis,
    this.itemStyle,
    this.groupStyle,
    this.separatorStyle,
    this.onFocused,
    this.focusedIndex = -1,
    this.shortcuts,
    this.actions,
  });

  /// The item's position in the toolbar.
  final int index;

  /// The toolbar's axis.
  final Axis axis;

  /// The resolved item style; null lets the item resolve its own.
  final ToolbarStyle? itemStyle;

  /// The resolved group style.
  final ToolbarStyle? groupStyle;

  /// The resolved separator style.
  final ToolbarStyle? separatorStyle;

  /// Called with the index of the item that gained focus.
  final ValueChanged<int>? onFocused;

  /// The index of the item that currently holds focus; -1 when none does.
  final int focusedIndex;

  /// The arrow-key map of the toolbar's roving group.
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// The action map of the toolbar's roving group.
  final Map<Type, Action<Intent>>? actions;
}

/// An action inside a toolbar.
///
/// The item is a square icon button when [label] is null and a labelled
/// button otherwise.
class ToolbarItem extends StatefulWidget {
  /// Creates a toolbar item.
  const ToolbarItem({
    super.key,
    required this.child,
    this.label,
    this.onPressed,
    this.enabled = true,
    this.tooltip,
    this.semanticLabel,
    this.style,
    this.focusNode,
    this.onHover,
    this.onFocusChange,
  });

  /// The item's content, usually an `Icon`.
  final Widget child;

  /// Optional text shown next to [child].
  final Widget? label;

  /// Called on tap. A null callback disables the item.
  final VoidCallback? onPressed;

  /// Whether the item accepts input.
  final bool enabled;

  /// Hover label of the item.
  final String? tooltip;

  /// Accessible name of the item.
  final String? semanticLabel;

  /// Widget-leg style override for this item.
  final ToolbarStyle? style;

  /// Focus node. A node is created internally when null.
  final FocusNode? focusNode;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;

  @override
  State<ToolbarItem> createState() => _ToolbarItemState();
}

class _ToolbarItemState extends State<ToolbarItem> {
  final WidgetStatesController _states = WidgetStatesController();
  FocusNode? _ownedFocusNode;
  RovingGroupRegistry<int>? _registry;
  int _index = 0;
  int _focusedIndex = -1;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ToolbarItemData? data = Data.maybeOf<ToolbarItemData>(context);
    _index = data?.index ?? 0;
    _focusedIndex = data?.focusedIndex ?? -1;
    _registry = Data.maybeOf<RovingGroupRegistry<int>>(context);
  }

  @override
  void dispose() {
    _registry?.unregister(this);
    _ownedFocusNode?.dispose();
    _states.dispose();
    super.dispose();
  }

  void _register() {
    final RovingGroupRegistry<int>? registry = _registry;
    if (registry == null) {
      return;
    }
    registry.register(
      RovingItem<int>(
        key: this,
        value: _index,
        enabled: widget.enabled && widget.onPressed != null,
        selected: _focusedIndex == _index,
        requestFocus: () => _focusNode.requestFocus(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _register();
    final ToolbarItemData? data = Data.maybeOf<ToolbarItemData>(context);
    final ToolbarStyle style = _resolveStyle(context, data);
    final bool enabled = widget.enabled && widget.onPressed != null;
    return ToolbarItemSurface(
      style: style,
      content: _content(context, style),
      enabled: enabled,
      onPressed: widget.onPressed,
      focusNode: _focusNode,
      statesController: _states,
      semanticLabel: widget.semanticLabel ?? _labelText,
      toggled: null,
      shortcuts: data?.shortcuts,
      actions: data?.actions,
      tooltip: widget.tooltip,
      onHover: widget.onHover,
      onFocus: (bool focused) {
        if (focused) {
          data?.onFocused?.call(_index);
        }
        widget.onFocusChange?.call(focused);
      },
    );
  }

  ToolbarStyle _resolveStyle(BuildContext context, ToolbarItemData? data) {
    final ToolbarStyle own = resolveComponentStyle<ToolbarTheme, ToolbarStyle>(
      context,
      widget: widget.style,
      select: (ToolbarTheme t) => t.item,
      defaults: toolbarDefaults.item!,
    );
    final ToolbarStyle? inherited = data?.itemStyle;
    if (inherited == null) {
      return own;
    }
    return own.merge(inherited);
  }

  Widget _content(BuildContext context, ToolbarStyle style) {
    final double box = style.itemSize ?? 36;
    final double gap = style.gap ?? toolbarDefaultGap;
    final Widget? label = widget.label;
    if (label == null) {
      // An icon-only item is a square box; the padding is inside it.
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: box, minHeight: box),
        child: Center(widthFactor: 1, heightFactor: 1, child: widget.child),
      );
    }
    return Padding(
      padding: toolbarItemPadding(context, style),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.child,
          SizedBox(width: gap),
          label,
        ],
      ),
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

/// The density-scaled padding inside a toolbar item.
EdgeInsets toolbarItemPadding(BuildContext context, ToolbarStyle style) {
  final ThemeData ambient = Theme.of(context);
  final EdgeInsetsGeometry padding =
      style.itemPadding ?? const EdgeInsets.symmetric(horizontal: 8);
  return resolveEdgeInsets(
    padding,
    ambient.density.baseContentPadding * ambient.scaling,
  ).resolve(Directionality.of(context));
}

/// Builds one toolbar item wrapped in the toolbar's item scope.
///
/// The scope tells the item which part of the toolbar it sits in (its
/// [ToolbarItemData.index], the axis and the styles) and hands it the
/// keyboard shortcuts and the roving-focus actions.
Widget buildToolbarScopedItem({
  required int index,
  required Axis axis,
  required ToolbarStyle itemStyle,
  required ToolbarStyle groupStyle,
  required ToolbarStyle separatorStyle,
  required Map<LogicalKeySet, Intent> shortcuts,
  required Map<Type, Action<Intent>> actions,
  required ValueChanged<int> onFocused,
  required int focusedIndex,
  required Widget child,
}) {
  return Data<ToolbarItemData>.inherit(
    data: ToolbarItemData(
      index: index,
      axis: axis,
      itemStyle: itemStyle,
      groupStyle: groupStyle,
      separatorStyle: separatorStyle,
      onFocused: onFocused,
      focusedIndex: focusedIndex,
      shortcuts: shortcuts,
      actions: actions,
    ),
    child: child,
  );
}
