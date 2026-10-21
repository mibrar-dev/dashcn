// The `toolbar` component: [Toolbar], a row or column of actions, toggles,
// separators and groups.
//
// The toolbar is responsive: when the items no longer fit the space the
// toolbar was given, the trailing ones move into an overflow menu and a
// "more" button takes their place. The arrow keys walk the items through
// the shared `primitives/roving_group.dart` primitive (mirrored in RTL).

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/measured_extent.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/roving_group.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../menu/menu.dart';
import 'toolbar_items.dart';
import 'toolbar_keys.dart';
import 'toolbar_overflow.dart';
import 'toolbar_surface.dart';

export 'toolbar_items.dart';
export 'toolbar_style.dart';
export 'toolbar_surface.dart';

/// The index the overflow button's extent is stored under.
const int _toolbarOverflowIndex = -1;

/// A row or column of actions.
///
/// The children are [ToolbarItem], [ToolbarToggleItem], [ToolbarSeparator]
/// and [ToolbarGroup] widgets. When the toolbar runs out of room the
/// trailing children move into an overflow menu.
class Toolbar extends StatefulWidget {
  /// Creates a toolbar.
  const Toolbar({
    super.key,
    required this.children,
    this.axis = ToolbarAxis.horizontal,
    this.size = ToolbarSize.md,
    this.overflow = true,
    this.overflowIcon,
    this.overflowLabel,
    this.overflowSemanticLabel,
    this.style,
    this.theme,
  });

  /// The toolbar's items.
  final List<Widget> children;

  /// The direction the items are laid out in.
  final ToolbarAxis axis;

  /// Fixed size of the items.
  final ToolbarSize size;

  /// Whether the toolbar collapses into an overflow menu when it runs out of
  /// room.
  final bool overflow;

  /// The overflow button's icon; null uses a "more" glyph.
  final Widget? overflowIcon;

  /// The overflow button's hover label; null falls back to the locale's
  /// [ComponentLocalizations.toolbarMore].
  final String? overflowLabel;

  /// The overflow button's accessible name; null falls back to the locale's
  /// [ComponentLocalizations.toolbarMoreActions].
  final String? overflowSemanticLabel;

  /// Widget-leg style override for the whole toolbar.
  final ToolbarStyle? style;

  /// Generic widget-leg style override, merged under [style].
  final ToolbarStyle? theme;

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  final RovingGroupRegistry<int> _registry = RovingGroupRegistry<int>();
  final Map<int, double> _extents = <int, double>{};
  int _currentIndex = 0;
  bool _rebuildScheduled = false;

  void _onExtent(int index, double extent) {
    final double? known = _extents[index];
    if (known != null && (known - extent).abs() < 0.5) {
      return;
    }
    _extents[index] = extent;
    if (_rebuildScheduled) {
      return;
    }
    _rebuildScheduled = true;
    // The extent arrives after the layout, in the post-frame phase, so the
    // rebuild can be scheduled right away. Scheduling it here also asks for
    // the frame that re-splits the toolbar: without it a toolbar that
    // nothing else animates would never collapse into its overflow menu.
    if (mounted) {
      setState(() {});
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _rebuildScheduled = false;
    });
  }

  void _onFocused(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ToolbarTheme resolved = _resolveTheme(context);
    final ToolbarStyle containerStyle = resolved.container!;
    final ToolbarStyle itemStyle = resolved.item!;
    final ToolbarStyle groupStyle = resolved.group!;
    final ToolbarStyle separatorStyle = resolved.separator!;
    final bool horizontal = widget.axis == ToolbarAxis.horizontal;
    final Axis axis = horizontal ? Axis.horizontal : Axis.vertical;
    final double gap = containerStyle.gap ?? toolbarDefaultGap;
    final EdgeInsets padding = resolveEdgeInsets(
      containerStyle.padding ?? EdgeInsets.zero,
      ambient.density.baseContentPadding * ambient.scaling,
    ).resolve(Directionality.of(context));
    final bool rtl = Directionality.of(context) == TextDirection.rtl;

    _registry.direction = axis;
    // The roving group reports the member it landed on; the toolbar keeps
    // that position so the next arrow press continues from there.
    _registry.onSelect = (int index) => _onFocused(index);
    final Map<LogicalKeySet, Intent> shortcuts = toolbarShortcuts(axis, rtl);
    final Map<Type, Action<Intent>> actions = toolbarActions(_registry);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = horizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        final int visible = widget.overflow
            ? toolbarVisibleCount(
                total: widget.children.length,
                extents: _extents,
                available: available,
                gap: gap,
                overflowIndex: _toolbarOverflowIndex,
              )
            : widget.children.length;

        final List<Widget> row = <Widget>[];
        for (int i = 0; i < visible && i < widget.children.length; i++) {
          if (row.isNotEmpty) {
            row.add(_spacer(gap, horizontal));
          }
          row.add(
            MeasuredExtent(
              axis: axis,
              onExtent: (double extent) => _onExtent(i, extent),
              content: buildToolbarScopedItem(
                index: i,
                axis: axis,
                itemStyle: itemStyle,
                groupStyle: groupStyle,
                separatorStyle: separatorStyle,
                shortcuts: shortcuts,
                actions: actions,
                onFocused: _onFocused,
                focusedIndex: _currentIndex,
                child: widget.children[i],
              ),
            ),
          );
        }
        final bool hasOverflow = visible < widget.children.length;
        if (hasOverflow) {
          if (row.isNotEmpty) {
            row.add(_spacer(gap, horizontal));
          }
          row.add(
            MeasuredExtent(
              axis: axis,
              onExtent: (double extent) =>
                  _onExtent(_toolbarOverflowIndex, extent),
              content: buildToolbarOverflowButton(
                visible: visible,
                axis: axis,
                itemStyle: itemStyle,
                groupStyle: groupStyle,
                separatorStyle: separatorStyle,
                shortcuts: shortcuts,
                actions: actions,
                icon: widget.overflowIcon ?? const Icon(LucideIcons.ellipsis),
                tooltip:
                    widget.overflowLabel ??
                    ComponentLocalizations.of(context).toolbarMore,
                semanticLabel:
                    widget.overflowSemanticLabel ??
                    ComponentLocalizations.of(context).toolbarMoreActions,
                onPressed: () => _openOverflow(context, visible),
              ),
            ),
          );
        }

        final Widget line = horizontal
            ? Row(mainAxisSize: MainAxisSize.min, children: row)
            : Column(mainAxisSize: MainAxisSize.min, children: row);

        // The line is laid out with unbounded constraints so it never
        // reports a flex overflow; the clip keeps it inside the toolbar.
        final Widget measured = ClipRect(
          child: OverflowBox(
            // The box hugs the items instead of filling the toolbar, so the
            // bar stays as wide as its content.
            fit: OverflowBoxFit.deferToChild,
            alignment: AlignmentDirectional.topStart.resolve(
              Directionality.of(context),
            ),
            minWidth: 0,
            maxWidth: horizontal ? double.infinity : constraints.maxWidth,
            minHeight: 0,
            maxHeight: horizontal ? constraints.maxHeight : double.infinity,
            child: line,
          ),
        );

        return RovingGroupScope<int>(
          registry: _registry,
          child: buildToolbarSurface(
            context: context,
            style: containerStyle,
            padding: padding,
            child: measured,
          ),
        );
      },
    );
  }

  ToolbarTheme _resolveTheme(BuildContext context) {
    return resolveToolbarTheme(
      context: context,
      style: widget.style,
      theme: widget.theme,
      size: widget.size,
    );
  }

  void _openOverflow(BuildContext context, int from) {
    final List<Widget> rows = <Widget>[];
    for (int i = from; i < widget.children.length; i++) {
      rows.add(toolbarMenuRow(widget.children[i]));
    }
    if (rows.isEmpty) {
      return;
    }
    showMenu<void>(
      context: context,
      children: rows,
      alignment: AlignmentDirectional.topEnd,
      anchorAlignment: AlignmentDirectional.bottomEnd,
      offset: const Offset(0, 4),
    );
  }

  Widget _spacer(double gap, bool horizontal) {
    return horizontal ? SizedBox(width: gap) : SizedBox(height: gap);
  }
}
