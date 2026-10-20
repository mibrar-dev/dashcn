// The toggle item of the `toolbar` component: an on/off item that is
// controlled with `value`/`onChanged` or uncontrolled with a
// `ToolbarToggleController`.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../primitives/roving_group.dart';
import '../../theme/theme.dart';
import 'toolbar_item.dart';
import 'toolbar_item_surface.dart';
import 'toolbar_style.dart';

/// Holds the on/off value of an uncontrolled [ToolbarToggleItem].
class ToolbarToggleController extends ValueNotifier<bool> {
  /// Creates a controller, off by default.
  ToolbarToggleController([super.value = false]);

  /// Flips the value.
  void toggle() => value = !value;
}

/// A toggle inside a toolbar.
///
/// Controlled with [value] and [onChanged], or uncontrolled with a
/// [controller].
class ToolbarToggleItem extends StatefulWidget {
  /// Creates a toolbar toggle item.
  const ToolbarToggleItem({
    super.key,
    required this.child,
    this.value = false,
    this.controller,
    this.onChanged,
    this.label,
    this.enabled = true,
    this.tooltip,
    this.semanticLabel,
    this.style,
    this.focusNode,
    this.onHover,
    this.onFocusChange,
  }) : assert(
         controller == null || (value == false && onChanged == null),
         'A controller-driven toggle must not also receive value/onChanged',
       );

  /// The item's content, usually an `Icon`.
  final Widget child;

  /// Current value in controlled mode.
  final bool value;

  /// Controller mode: the controller owns the value.
  final ToolbarToggleController? controller;

  /// Called with the next value in controlled mode.
  final ValueChanged<bool>? onChanged;

  /// Optional text shown next to [child].
  final Widget? label;

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
  State<ToolbarToggleItem> createState() => _ToolbarToggleItemState();
}

class _ToolbarToggleItemState extends State<ToolbarToggleItem> {
  final WidgetStatesController _states = WidgetStatesController();
  FocusNode? _ownedFocusNode;
  RovingGroupRegistry<int>? _registry;
  int _index = 0;
  int _focusedIndex = -1;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  bool get _isOn => widget.controller?.value ?? widget.value;

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
        enabled: widget.enabled,
        selected: _focusedIndex == _index,
        requestFocus: () => _focusNode.requestFocus(),
      ),
    );
  }

  void _handleToggle() {
    final ToolbarToggleController? controller = widget.controller;
    if (controller != null) {
      controller.toggle();
      return;
    }
    widget.onChanged?.call(!_isOn);
  }

  @override
  Widget build(BuildContext context) {
    _register();
    final ToolbarItemData? data = Data.maybeOf<ToolbarItemData>(context);
    final ToolbarStyle style = _resolveStyle(context, data);
    final bool enabled =
        widget.enabled &&
        (widget.onChanged != null || widget.controller != null);
    final bool isOn = _isOn;
    final ToolbarStyle onStyle = style.merge(
      const ToolbarStyle(itemBackground: toolbarToggleBackground),
    );
    return ToolbarItemSurface(
      style: isOn ? onStyle : style,
      content: _content(context, style),
      enabled: enabled,
      onPressed: _handleToggle,
      focusNode: _focusNode,
      statesController: _states,
      semanticLabel: widget.semanticLabel ?? _labelText,
      toggled: isOn,
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
