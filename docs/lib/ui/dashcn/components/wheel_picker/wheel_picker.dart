// The `wheel_picker` component: a scrolling wheel (or a row of wheels) with
// item snapping, a centred selection band, an optional 3D cylinder look,
// optional infinite looping, and a haptic-free selection callback.
//
// Each column is a `ListWheelScrollView` with a `FixedExtentScrollController`
// and `FixedExtentScrollPhysics`, so drag, mouse wheel and fling all snap to
// row boundaries. Keyboard arrows move the selection (up/down) and the active
// column (left/right); tapping a row selects it. The selection reports through
// `onChanged` with the selected index of every column and never fires
// haptics, so the caller decides when to give feedback.
//
// Widgets-only; no Material/Cupertino.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../primitives/motion/motion_scope.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'wheel_picker_style.dart';

export 'wheel_picker_style.dart';

/// Builds the content of one wheel row.
typedef WheelItemBuilder = Widget Function(BuildContext context, int index);

/// Builds the centred selection band.
typedef WheelBandBuilder = Widget Function(BuildContext context);

/// Builds the separator drawn after the column at [index].
typedef WheelSeparatorBuilder =
    Widget Function(BuildContext context, int index);

/// One column of a [WheelPicker]: the rows plus an optional fixed width.
class WheelColumn {
  /// Creates a wheel column.
  const WheelColumn({
    required this.items,
    this.builder,
    this.width,
    this.flex = 1,
    this.semanticLabel,
  });

  /// The row labels, top to bottom.
  final List<String> items;

  /// Custom row content; null renders [items] as text.
  final WheelItemBuilder? builder;

  /// Fixed column width; null shares the row width with [flex].
  final double? width;

  /// Width share when [width] is null.
  final double flex;

  /// Accessible label for the column.
  final String? semanticLabel;
}

/// A scrolling wheel picker with one or more columns.
///
/// ```dart
/// WheelPicker(
///   columns: <WheelColumn>[
///     WheelColumn(items: <String>['01', '02', '03']),
///     WheelColumn(items: <String>['Jan', 'Feb', 'Mar']),
///   ],
///   onChanged: (indices) => print(indices),
/// )
/// ```
///
/// Controlled when [value] is set (the caller owns the selection);
/// uncontrolled with [initialValue] when it is null. [onChanged] reports the
/// selected index of every column and never fires haptics.
class WheelPicker extends StatefulWidget {
  /// Creates a wheel picker.
  const WheelPicker({
    super.key,
    required this.columns,
    this.value,
    this.initialValue,
    this.onChanged,
    this.itemHeight,
    this.visibleItems = 5,
    this.looping = false,
    this.perspective = false,
    this.enabled,
    this.focusNode,
    this.semanticLabel,
    this.bandBuilder,
    this.separatorBuilder,
    this.theme,
  }) : assert(
         visibleItems == null || visibleItems >= 3,
         'visibleItems must be at least 3 so a row can centre.',
       );

  /// The wheel columns, left to right.
  final List<WheelColumn> columns;

  /// The selected index of every column; null makes the picker uncontrolled.
  final List<int>? value;

  /// Initial selection when [value] is null.
  final List<int>? initialValue;

  /// Called with the selected index of every column; never fires haptics.
  final ValueChanged<List<int>>? onChanged;

  /// Row height override; null resolves `WheelPickerTheme.itemHeight`.
  final double? itemHeight;

  /// Number of visible rows override; null resolves the theme (5).
  final int? visibleItems;

  /// Whether each column loops forever instead of clamping at the ends.
  final bool looping;

  /// Whether the wheel renders as a 3D cylinder instead of flat rows.
  final bool perspective;

  /// Overrides the enabled state; null means `onChanged != null`.
  final bool? enabled;

  /// Focus node for keyboard control.
  final FocusNode? focusNode;

  /// Accessible label for the whole picker.
  final String? semanticLabel;

  /// Replaces the centred selection band; null paints the themed band.
  final WheelBandBuilder? bandBuilder;

  /// Replaces the separator after a column; null paints the themed 1px rule.
  final WheelSeparatorBuilder? separatorBuilder;

  /// Widget-leg theme override, merged over the component/app/defaults legs.
  final WheelPickerTheme? theme;

  @override
  State<WheelPicker> createState() => _WheelPickerState();
}

/// Number of times the items repeat when [WheelPicker.looping] is on.
const int _loopRepeats = 10000;

/// Near-zero perspective for the flat (non-3D) wheel; ListWheelScrollView
/// requires `perspective > 0`, and this renders identically to no perspective.
const double _flatPerspective = 0.0001;

/// Very large diameter ratio for the flat wheel. `ListWheelScrollView` rotates
/// rows by up to `asin(1 / diameterRatio)`, so a large value keeps the rows
/// unrotated (a `1.0` ratio would tilt edge rows by a full 90°).
const double _flatDiameterRatio = 100;

/// Column width used when the incoming width is loose or unbounded and the
/// column has no explicit [WheelColumn.width]. Comfortably wider than the 48px
/// minimum touch target.
const double _defaultColumnWidth = 88;

class _WheelPickerState extends State<WheelPicker> {
  late List<FixedExtentScrollController> _controllers;
  late List<int> _selected;
  int _activeColumn = 0;
  bool _focused = false;
  FocusNode? _ownedFocus;

  FocusNode get _focus =>
      widget.focusNode ??
      (_ownedFocus ??= FocusNode(debugLabel: 'WheelPicker'));

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  WheelPickerTheme _style(BuildContext context) =>
      resolveComponentStyle<WheelPickerTheme, WheelPickerTheme>(
        context,
        widget: widget.theme,
        select: (t) => t,
        defaults: wheelPickerDefaults,
      );

  @override
  void initState() {
    super.initState();
    final List<int> initial = _initialIndices();
    _selected = List<int>.of(initial);
    _controllers = <FixedExtentScrollController>[
      for (int i = 0; i < widget.columns.length; i++)
        FixedExtentScrollController(initialItem: _rawIndex(i, initial[i])),
    ];
  }

  @override
  void didUpdateWidget(covariant WheelPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.columns.length != oldWidget.columns.length) {
      _disposeControllers();
      final List<int> initial = _initialIndices();
      _selected = List<int>.of(initial);
      _controllers = <FixedExtentScrollController>[
        for (int i = 0; i < widget.columns.length; i++)
          FixedExtentScrollController(initialItem: _rawIndex(i, initial[i])),
      ];
      return;
    }
    final List<int>? target = widget.value;
    if (target != null && target != oldWidget.value) {
      for (int i = 0; i < target.length && i < _selected.length; i++) {
        if (target[i] != _selected[i]) {
          _selected[i] = target[i];
          _jumpTo(i, target[i]);
        }
      }
    }
    if (!_enabled) {
      _focus.unfocus();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    _ownedFocus?.dispose();
    super.dispose();
  }

  void _disposeControllers() {
    for (final FixedExtentScrollController controller in _controllers) {
      controller.dispose();
    }
  }

  List<int> _initialIndices() {
    final List<int>? initial = widget.value ?? widget.initialValue;
    return <int>[
      for (int i = 0; i < widget.columns.length; i++)
        initial != null &&
                i < initial.length &&
                widget.columns[i].items.isNotEmpty
            ? initial[i].clamp(0, widget.columns[i].items.length - 1)
            : 0,
    ];
  }

  /// The controller item for the selection [index] of [column]: the selection
  /// itself when not looping, or the same item offset into the repeated range
  /// when looping.
  int _rawIndex(int column, int index) {
    if (!widget.looping) {
      return index;
    }
    final int count = widget.columns[column].items.length;
    return count * (_loopRepeats ~/ 2) + index;
  }

  /// The selection for the controller item [raw] of [column].
  int _selectionFor(int column, int raw) {
    final int count = widget.columns[column].items.length;
    return widget.looping ? raw % count : raw;
  }

  void _jumpTo(int column, int index) {
    _controllers[column].jumpToItem(_rawIndex(column, index));
  }

  void _animateTo(int column, int index) {
    final Duration duration = resolveMotionDuration(
      context,
      kWheelPickerSnapDuration,
    );
    // animateToItem asserts duration > Duration.zero; reduced motion snaps.
    if (duration == Duration.zero) {
      _controllers[column].jumpToItem(_rawIndex(column, index));
      return;
    }
    _controllers[column].animateToItem(
      _rawIndex(column, index),
      duration: duration,
      curve: kWheelPickerSnapCurve,
    );
  }

  void _onSelected(int column, int raw) {
    final int index = _selectionFor(column, raw);
    if (index == _selected[column]) {
      return;
    }
    setState(() => _selected[column] = index);
    final List<int> next = List<int>.of(_selected);
    if (next != widget.value) {
      widget.onChanged?.call(next);
    }
  }

  void _select(int column, int index) {
    if (!_enabled) {
      return;
    }
    setState(() => _activeColumn = column);
    _animateTo(column, index);
  }

  void _move(int column, int delta) {
    final int count = widget.columns[column].items.length;
    final int current = _selected[column];
    final int next = widget.looping
        ? (current + delta) % count
        : (current + delta).clamp(0, count - 1);
    if (next == current) {
      return;
    }
    _animateTo(column, next);
  }

  void _moveColumn(int delta) {
    final int count = widget.columns.length;
    setState(() {
      _activeColumn = (_activeColumn + delta) % count;
    });
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent || !_enabled) {
      return KeyEventResult.ignored;
    }
    final int column = _activeColumn;
    final int count = widget.columns[column].items.length;
    final int page = (_style(context).visibleItems ?? 5);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        _move(column, -1);
      case LogicalKeyboardKey.arrowDown:
        _move(column, 1);
      case LogicalKeyboardKey.arrowLeft:
        _moveColumn(-1);
      case LogicalKeyboardKey.arrowRight:
        _moveColumn(1);
      case LogicalKeyboardKey.pageUp:
        _move(column, -page);
      case LogicalKeyboardKey.pageDown:
        _move(column, page);
      case LogicalKeyboardKey.home:
        _move(column, -count);
      case LogicalKeyboardKey.end:
        _move(column, count);
      default:
        return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          _build(context, constraints),
    );
  }

  Widget _build(BuildContext context, BoxConstraints constraints) {
    // Columns share the incoming width only when the caller pins it (a
    // `SizedBox`, an `Expanded`, a stretched column). Under a loose or
    // unbounded width each column sizes to [_defaultColumnWidth] instead, so a
    // wheel placed beside other widgets never eats the whole row.
    final bool bounded = constraints.hasBoundedWidth;
    final bool fill =
        bounded && (constraints.maxWidth - constraints.minWidth).abs() < 0.5;
    final WheelPickerTheme style = _style(context);
    final ThemeData theme = Theme.of(context);
    final double itemHeight = widget.itemHeight ?? style.itemHeight ?? 48;
    final int visibleItems = style.visibleItems ?? 5;
    final double wheelHeight = itemHeight * visibleItems;
    final bool enabled = _enabled;

    final Color foreground =
        (style.foreground ?? const ThemedColor.ref(ColorRef.foreground))
            .resolve(theme.colors);
    final Color mutedForeground =
        (style.mutedForeground ??
                const ThemedColor.ref(ColorRef.mutedForeground))
            .resolve(theme.colors);
    final double fontSize = style.fontSize ?? 16;
    final FontWeight fontWeight = style.fontWeight ?? FontWeight.w600;

    final List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.columns.length; i++) {
      final WheelColumn column = widget.columns[i];
      final int count = column.items.length;
      final int itemCount = widget.looping ? count * _loopRepeats : count;
      Widget wheel = ListWheelScrollView.useDelegate(
        controller: _controllers[i],
        physics: const FixedExtentScrollPhysics(),
        itemExtent: itemHeight,
        diameterRatio: widget.perspective
            ? (style.diameterRatio ?? 1.6)
            : _flatDiameterRatio,
        // ListWheelScrollView requires perspective > 0; the flat default uses a
        // near-zero value that renders identically to no perspective.
        perspective: widget.perspective
            ? (style.perspective ?? 0.003)
            : _flatPerspective,
        offAxisFraction: 0,
        onSelectedItemChanged: (int raw) => _onSelected(i, raw),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (BuildContext context, int raw) {
            final int index = widget.looping ? raw % count : raw;
            final bool isSelected = enabled && index == _selected[i];
            final Widget content =
                column.builder?.call(context, index) ??
                Text(
                  column.items[index],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: isSelected ? fontWeight : FontWeight.w400,
                    color: isSelected ? foreground : mutedForeground,
                  ),
                );
            return Semantics(
              selected: isSelected,
              label: column.items[index],
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: enabled ? () => _select(i, index) : null,
                child: Center(child: content),
              ),
            );
          },
        ),
      );
      Widget sized = column.width != null
          ? SizedBox(width: column.width, height: wheelHeight, child: wheel)
          : SizedBox(height: wheelHeight, child: wheel);
      if (column.width != null) {
        children.add(sized);
      } else if (fill) {
        children.add(
          Flexible(flex: column.flex.round().clamp(1, 1000), child: sized),
        );
      } else {
        children.add(SizedBox(width: _defaultColumnWidth, child: sized));
      }
      if (i < widget.columns.length - 1) {
        children.add(
          widget.separatorBuilder?.call(context, i) ??
              _separator(style, wheelHeight),
        );
      }
    }

    final Widget row = Row(mainAxisSize: MainAxisSize.min, children: children);

    final Color surface =
        (style.surfaceColor ?? const ThemedColor.ref(ColorRef.background))
            .resolve(theme.colors);
    final BorderRadiusGeometry radius =
        style.borderRadius ?? theme.borderRadiusLg;
    final Color selectionColor =
        (style.selectionColor ??
                const ThemedColor.ref(ColorRef.accent, alpha: 0.12))
            .resolve(theme.colors);
    final Color selectionBorderColor =
        (style.selectionBorderColor ?? const ThemedColor.ref(ColorRef.border))
            .resolve(theme.colors);
    final double selectionBorderWidth = style.selectionBorderWidth ?? 1;
    final BorderRadiusGeometry selectionRadius =
        style.selectionBorderRadius ?? theme.borderRadiusMd;
    final Color fadeColor =
        (style.fadeColor ?? const ThemedColor.ref(ColorRef.background)).resolve(
          theme.colors,
        );
    final double fadeHeight = style.fadeHeight ?? 32;

    final Widget band = Positioned(
      top: (wheelHeight - itemHeight) / 2,
      left: 0,
      right: 0,
      height: itemHeight,
      child:
          widget.bandBuilder?.call(context) ??
          DecoratedBox(
            decoration: BoxDecoration(
              color: selectionColor,
              borderRadius: selectionRadius,
              border: Border.all(
                color: selectionBorderColor,
                width: selectionBorderWidth,
              ),
            ),
          ),
    );

    // The overlay (fades + band) is one IgnorePointer'd Stack so every
    // Positioned is a direct child of a Stack, as the parent-data protocol
    // requires.
    final Widget overlay = Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                _fade(fadeColor, fadeHeight, true),
                const Spacer(),
                _fade(fadeColor, fadeHeight, false),
              ],
            ),
            band,
          ],
        ),
      ),
    );

    final Widget picker = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        border: _focused
            ? Border.all(color: theme.colors.accent, width: 2)
            : null,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: <Widget>[
            ColoredBox(color: surface, child: row),
            overlay,
          ],
        ),
      ),
    );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Focus(
        focusNode: _focus,
        canRequestFocus: enabled,
        skipTraversal: false,
        onFocusChange: (bool value) => setState(() => _focused = value),
        onKeyEvent: _onKey,
        child: Semantics(
          label: widget.semanticLabel,
          container: true,
          child: picker,
        ),
      ),
    );
  }

  Widget _separator(WheelPickerTheme style, double height) {
    final Color color =
        (style.separatorColor ?? const ThemedColor.ref(ColorRef.border))
            .resolve(Theme.of(context).colors);
    final double width = style.separatorWidth ?? 1;
    return SizedBox(
      height: height,
      child: ColoredBox(
        color: color,
        child: SizedBox(width: width),
      ),
    );
  }

  Widget _fade(Color color, double height, bool top) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: top ? Alignment.topCenter : Alignment.bottomCenter,
            end: top ? Alignment.bottomCenter : Alignment.topCenter,
            colors: <Color>[color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
