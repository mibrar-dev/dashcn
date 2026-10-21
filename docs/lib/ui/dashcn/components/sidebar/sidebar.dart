// The `sidebar` component: a production dashboard sidebar that renders as a
// fixed column on desktop and inside a drawer or sheet on phone widths.
//
// Structure: a header (logo or app name plus a collapse control), grouped
// navigation sections with 12 px muted labels, 32 px rows with a 16 px icon,
// label, optional badge and optional trailing chevron for sub-menus, and a
// footer account row (avatar, name, email, dropdown). The rail is 240 px
// expanded and 56 px collapsed (icons only, with tooltips).
//
// The same widget works in a drawer: place it directly in an `openDrawer`
// builder — it sizes itself to the rail width and fills the given height,
// with the navigation list scrolling internally. All colours, radius,
// padding and gaps come from the theme; the rail fill goes through the
// surface primitive so surface opacity and blur apply.
//
// Keyboard: <kbd>↑</kbd>/<kbd>↓</kbd> move between visible items,
// <kbd>Home</kbd>/<kbd>End</kbd> jump, <kbd>→</kbd> expands a sub-menu and
// <kbd>←</kbd> collapses it (mirrored in RTL), <kbd>Enter</kbd> activates.
// Row order follows the ambient [Directionality].

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../components/avatar/avatar.dart';
import '../../components/badge/badge.dart';
import '../../components/tooltip/tooltip.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/clickable.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/motion/motion_chevron.dart';
import '../../primitives/surface.dart';
import '../../theme/theme.dart';
import 'sidebar_style.dart';

export 'sidebar_style.dart';

/// One navigation row. [key] (defaults to [label]) is the selection identity
/// reported through [DashboardSidebar.onSelected].
class SidebarItem {
  /// Creates a navigation row.
  const SidebarItem({
    this.id,
    required this.label,
    required this.icon,
    this.badge,
    this.children = const <SidebarItem>[],
  });

  /// Selection identity; defaults to [label].
  final String? id;

  /// Row label.
  final String label;

  /// 16 px leading glyph.
  final IconData icon;

  /// Optional trailing badge text (hidden while collapsed).
  final String? badge;

  /// Optional sub-menu rows; a trailing chevron expands them inline.
  final List<SidebarItem> children;

  /// Whether the row opens a sub-menu.
  bool get hasChildren => children.isNotEmpty;

  /// The identity reported on selection.
  String get key => id ?? label;
}

/// One labelled group of navigation rows.
class SidebarSection {
  /// Creates a navigation group.
  const SidebarSection({this.label, this.items = const <SidebarItem>[]});

  /// Group label (12 px, muted); null renders the rows without a label.
  final String? label;

  /// Rows in this group.
  final List<SidebarItem> items;
}

/// The footer account row.
class SidebarUser {
  /// Creates the footer account.
  const SidebarUser({required this.name, required this.email});

  /// Display name.
  final String name;

  /// Secondary line (usually the email).
  final String email;
}

/// A production dashboard sidebar: header, grouped navigation and an account
/// footer. Place it in a `Row` beside content on desktop, or in an
/// `openDrawer` builder on phone widths — the same widget adapts.
///
/// ```dart
/// DashboardSidebar(
///   sections: const <SidebarSection>[
///     SidebarSection(
///       label: 'Main',
///       items: <SidebarItem>[
///         SidebarItem(label: 'Dashboard', icon: LucideIcons.layoutDashboard),
///         SidebarItem(label: 'Documents', icon: LucideIcons.fileText, badge: '3'),
///       ],
///     ),
///   ],
///   selectedId: 'Dashboard',
///   onSelected: (String id) => setState(() => _selected = id),
///   user: const SidebarUser(name: 'Ibrar Ahmed', email: 'm@example.com'),
/// )
/// ```
class DashboardSidebar extends StatefulWidget {
  /// Creates a dashboard sidebar.
  const DashboardSidebar({
    super.key,
    this.title = 'Acme Inc',
    this.logo,
    required this.sections,
    this.selectedId,
    this.onSelected,
    this.collapsed = false,
    this.onToggleCollapsed,
    this.user,
    this.onUserPressed,
    this.focusNode,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.theme,
  });

  /// Header title next to the logo.
  final String title;

  /// Header mark; defaults to a `command` glyph on the sidebar-primary tile.
  final Widget? logo;

  /// Grouped navigation.
  final List<SidebarSection> sections;

  /// Identity of the highlighted row; matches [SidebarItem.key].
  final String? selectedId;

  /// Called with the tapped row's identity.
  final ValueChanged<String>? onSelected;

  /// Icon-only 56 px rail with tooltips; labels hide.
  final bool collapsed;

  /// Called when the header collapse control is pressed; null hides it.
  final VoidCallback? onToggleCollapsed;

  /// Footer account row; null hides the footer.
  final SidebarUser? user;

  /// Called when the footer account row is pressed (open an account menu).
  final VoidCallback? onUserPressed;

  /// Focus scope of the navigation; created internally when null.
  final FocusScopeNode? focusNode;

  /// Widget-leg surface opacity override.
  final double? surfaceOpacity;

  /// Widget-leg surface blur override.
  final double? surfaceBlur;

  /// Widget-leg theme override, merged on top of the other legs.
  final SidebarTheme? theme;

  @override
  State<DashboardSidebar> createState() => _DashboardSidebarState();
}

/// One visible row: its item, nesting depth and submenu state.
class _VisibleEntry {
  const _VisibleEntry(this.item, this.depth, this.open);

  final SidebarItem item;
  final int depth;
  final bool open;
}

/// One navigation group with its visible rows.
class _VisibleSection {
  const _VisibleSection(this.label, this.entries);

  /// Group label; null renders the rows without a label.
  final String? label;
  final List<_VisibleEntry> entries;
}

class _DashboardSidebarState extends State<DashboardSidebar> {
  final Set<String> _open = <String>{};
  final Map<String, FocusNode> _nodes = <String, FocusNode>{};
  List<_VisibleEntry> _visible = const <_VisibleEntry>[];
  String? _seededFor;

  @override
  void dispose() {
    for (final FocusNode node in _nodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  /// Opens the ancestors of [selectedId] once per selection, so a selected
  /// sub-menu row is visible on first build.
  void _seedOpen() {
    if (_seededFor == widget.selectedId) {
      return;
    }
    _seededFor = widget.selectedId;
    final String? selected = widget.selectedId;
    if (selected == null) {
      return;
    }
    for (final SidebarSection section in widget.sections) {
      for (final SidebarItem item in section.items) {
        if (item.hasChildren &&
            item.children.any((SidebarItem child) => child.key == selected)) {
          _open.add(item.key);
        }
      }
    }
  }

  /// Visible rows grouped by section, honouring the open sub-menus.
  List<_VisibleSection> _grouped() {
    final List<_VisibleSection> out = <_VisibleSection>[];
    for (final SidebarSection section in widget.sections) {
      final List<_VisibleEntry> entries = <_VisibleEntry>[];
      for (final SidebarItem item in section.items) {
        final bool open = _open.contains(item.key);
        entries.add(_VisibleEntry(item, 0, open));
        if (item.hasChildren && open) {
          for (final SidebarItem child in item.children) {
            entries.add(_VisibleEntry(child, 1, false));
          }
        }
      }
      if (entries.isNotEmpty) {
        out.add(_VisibleSection(section.label, entries));
      }
    }
    return out;
  }

  FocusNode _nodeFor(String key) =>
      _nodes.putIfAbsent(key, () => FocusNode(debugLabel: 'SidebarItem'));

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent || _visible.isEmpty) {
      return KeyEventResult.ignored;
    }
    final BuildContext? scopeContext = node.context;
    final bool rtl =
        scopeContext != null &&
        Directionality.of(scopeContext) == TextDirection.rtl;
    int index = -1;
    for (int i = 0; i < _visible.length; i++) {
      if (_nodes[_visible[i].item.key]?.hasFocus ?? false) {
        index = i;
        break;
      }
    }
    final LogicalKeyboardKey key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowDown) {
      final int next = (index < 0
          ? 0
          : (index + 1).clamp(0, _visible.length - 1));
      _nodes[_visible[next].item.key]?.requestFocus();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      final int prev = (index < 0
          ? _visible.length - 1
          : (index - 1).clamp(0, _visible.length - 1));
      _nodes[_visible[prev].item.key]?.requestFocus();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.home) {
      _nodes[_visible.first.item.key]?.requestFocus();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.end) {
      _nodes[_visible.last.item.key]?.requestFocus();
      return KeyEventResult.handled;
    }
    // Expand/collapse a sub-menu; mirrored in RTL.
    final bool expandKeyPressed =
        key ==
        (rtl ? LogicalKeyboardKey.arrowLeft : LogicalKeyboardKey.arrowRight);
    final bool collapseKeyPressed =
        key ==
        (rtl ? LogicalKeyboardKey.arrowRight : LogicalKeyboardKey.arrowLeft);
    if ((expandKeyPressed || collapseKeyPressed) && index >= 0) {
      final SidebarItem item = _visible[index].item;
      if (!item.hasChildren) {
        return KeyEventResult.ignored;
      }
      final bool open = _open.contains(item.key);
      if (expandKeyPressed && !open) {
        setState(() => _open.add(item.key));
        return KeyEventResult.handled;
      }
      if (collapseKeyPressed && open) {
        setState(() => _open.remove(item.key));
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    return KeyEventResult.ignored;
  }

  void _onRowTap(_VisibleEntry entry) {
    _nodeFor(entry.item.key).requestFocus();
    if (entry.item.hasChildren && entry.depth == 0 && !widget.collapsed) {
      setState(() {
        if (_open.contains(entry.item.key)) {
          _open.remove(entry.item.key);
        } else {
          _open.add(entry.item.key);
        }
      });
    }
    widget.onSelected?.call(entry.item.key);
  }

  @override
  Widget build(BuildContext context) {
    _seedOpen();
    final List<_VisibleSection> grouped = _grouped();
    _visible = <_VisibleEntry>[
      for (final _VisibleSection s in grouped) ...s.entries,
    ];
    final ThemeData theme = Theme.of(context);
    final SidebarTheme style =
        resolveComponentStyle<SidebarTheme, SidebarTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: sidebarDefaults,
        );
    final bool collapsed = widget.collapsed;
    final double width =
        (collapsed ? style.collapsedWidth : style.expandedWidth) ??
        (collapsed ? kSidebarCollapsedWidth : kSidebarExpandedWidth);
    final Color background = (style.background ?? sidebarDefaults.background!)
        .resolve(theme.colors);
    final Color border = (style.borderColor ?? sidebarDefaults.borderColor!)
        .resolve(theme.colors);
    final double? opacity = resolveSurfaceOpacity(
      context,
      widget: widget.surfaceOpacity,
      component: style.surfaceOpacity,
    );
    final double? blur = resolveSurfaceBlur(
      context,
      widget: widget.surfaceBlur,
      component: style.surfaceBlur,
    );

    final Widget rail = DecoratedBox(
      decoration: BoxDecoration(
        color: surfaceColor(background, opacity),
        border: BorderDirectional(end: BorderSide(color: border)),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.sm),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget header = _SidebarHeader(
              title: widget.title,
              logo: widget.logo,
              collapsed: collapsed,
              onToggleCollapsed: widget.onToggleCollapsed,
              style: style,
            );
            final Widget nav = _SidebarNav(
              visible: grouped,
              selectedId: widget.selectedId,
              collapsed: collapsed,
              nodeFor: _nodeFor,
              onRowTap: _onRowTap,
              style: style,
            );
            final Widget? footer = widget.user == null
                ? null
                : _SidebarFooter(
                    user: widget.user!,
                    collapsed: collapsed,
                    onUserPressed: widget.onUserPressed,
                    style: style,
                  );
            if (!constraints.maxHeight.isFinite) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  header,
                  Gap(theme.spacing.sm),
                  nav,
                  if (footer != null) ...<Widget>[
                    Gap(theme.spacing.sm),
                    footer,
                  ],
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                header,
                Gap(theme.spacing.sm),
                Expanded(child: nav),
                if (footer != null) ...<Widget>[Gap(theme.spacing.sm), footer],
              ],
            );
          },
        ),
      ),
    );
    return FocusScope(
      node: widget.focusNode,
      onKeyEvent: _handleKey,
      child: SizedBox(
        width: width,
        child: GlassSurface(surfaceBlur: blur, child: rail),
      ),
    );
  }
}

/// Header: logo tile, app name and the collapse control.
class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({
    required this.title,
    required this.logo,
    required this.collapsed,
    required this.onToggleCollapsed,
    required this.style,
  });

  final String title;
  final Widget? logo;
  final bool collapsed;
  final VoidCallback? onToggleCollapsed;
  final SidebarTheme style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double iconSize = style.iconSize ?? kSidebarIconSize;
    final Widget mark = Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: theme.colors.sidebarPrimary,
        borderRadius: theme.borderRadiusSm,
      ),
      child:
          logo ??
          Icon(
            LucideIcons.command,
            size: iconSize,
            color: theme.colors.sidebarPrimaryForeground,
          ),
    );
    final bool canToggle = onToggleCollapsed != null;
    final ComponentLocalizations strings = ComponentLocalizations.of(context);
    if (collapsed) {
      final Widget tile = canToggle
          ? Semantics(
              button: true,
              label: strings.treeExpand,
              child: Clickable(
                onPressed: onToggleCollapsed,
                decoration: const WidgetStatePropertyAll<BoxDecoration>(
                  BoxDecoration(),
                ),
                child: mark,
              ),
            )
          : mark;
      return Tooltip(
        tooltip: (_) => Text(title),
        child: Center(child: tile),
      );
    }
    return Row(
      children: <Widget>[
        mark,
        Gap(theme.spacing.sm),
        Expanded(
          child: Text(
            title,
            style: theme.typography.textSmall.copyWith(
              color: theme.colors.sidebarForeground,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (canToggle)
          Tooltip(
            tooltip: (_) => Text(strings.treeCollapse),
            child: Semantics(
              button: true,
              label: strings.treeCollapse,
              child: Clickable(
                onPressed: onToggleCollapsed,
                decoration: const WidgetStatePropertyAll<BoxDecoration>(
                  BoxDecoration(),
                ),
                // A 48 px hit target around the 16 px glyph: the icon keeps
                // the compact density look while meeting the tap-target floor.
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    LucideIcons.panelLeftClose,
                    size: iconSize,
                    color: theme.colors.sidebarForeground,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Scrollable grouped navigation.
class _SidebarNav extends StatelessWidget {
  const _SidebarNav({
    required this.visible,
    required this.selectedId,
    required this.collapsed,
    required this.nodeFor,
    required this.onRowTap,
    required this.style,
  });

  final List<_VisibleSection> visible;
  final String? selectedId;
  final bool collapsed;
  final FocusNode Function(String key) nodeFor;
  final ValueChanged<_VisibleEntry> onRowTap;
  final SidebarTheme style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color groupLabel =
        (style.groupLabelColor ?? sidebarDefaults.groupLabelColor!).resolve(
          theme.colors,
        );
    final List<Widget> groups = <Widget>[];
    for (final _VisibleSection section in visible) {
      final List<_VisibleEntry> rows = section.entries;
      if (collapsed) {
        if (groups.isNotEmpty) {
          groups.add(_hairline(context));
        }
        for (final _VisibleEntry entry in rows) {
          groups.add(
            _SidebarRow(
              entry: entry,
              selected: entry.item.key == selectedId,
              collapsed: true,
              focusNode: nodeFor(entry.item.key),
              onTap: () => onRowTap(entry),
              style: style,
            ),
          );
        }
        continue;
      }
      if (section.label != null) {
        groups.add(
          Padding(
            padding: EdgeInsets.fromLTRB(
              theme.spacing.sm,
              groups.isEmpty ? theme.spacing.xs : theme.spacing.sm,
              theme.spacing.sm,
              theme.spacing.xs,
            ),
            child: Text(
              section.label!,
              style: theme.typography.xSmall.copyWith(
                fontSize: kSidebarGroupLabelSize,
                color: groupLabel,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      } else if (groups.isNotEmpty) {
        groups.add(Gap(theme.spacing.sm));
      }
      for (int i = 0; i < rows.length; i++) {
        if (i > 0) {
          groups.add(Gap(theme.spacing.xs / 2));
        }
        groups.add(
          _SidebarRow(
            entry: rows[i],
            selected: rows[i].item.key == selectedId,
            collapsed: false,
            focusNode: nodeFor(rows[i].item.key),
            onTap: () => onRowTap(rows[i]),
            style: style,
          ),
        );
      }
    }
    final Widget list = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: groups,
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (!constraints.maxHeight.isFinite) {
          return list;
        }
        return SingleChildScrollView(child: list);
      },
    );
  }

  /// A 1 px group divider for the collapsed rail.
  static Widget _hairline(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Container(
        height: 1,
        margin: EdgeInsets.symmetric(horizontal: theme.spacing.sm),
        color: theme.colors.sidebarBorder,
      ),
    );
  }
}

/// One navigation row: 32 px, 16 px icon, label, optional badge, optional
/// trailing chevron. Collapsed rails show the icon only, with a tooltip.
class _SidebarRow extends StatelessWidget {
  const _SidebarRow({
    required this.entry,
    required this.selected,
    required this.collapsed,
    required this.focusNode,
    required this.onTap,
    required this.style,
  });

  final _VisibleEntry entry;
  final bool selected;
  final bool collapsed;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final SidebarTheme style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double itemHeight = style.itemHeight ?? kSidebarItemHeight;
    final double iconSize = style.iconSize ?? kSidebarIconSize;
    final Color foreground =
        (selected
                ? (style.activeForeground ?? sidebarDefaults.activeForeground!)
                : (style.foreground ?? sidebarDefaults.foreground!))
            .resolve(theme.colors);
    final Color activeBackground =
        (style.activeBackground ?? sidebarDefaults.activeBackground!).resolve(
          theme.colors,
        );
    final BorderRadiusGeometry radius =
        style.itemRadius ?? theme.borderRadiusMd;
    final EdgeInsetsGeometry padding =
        style.itemPadding ?? sidebarDefaults.itemPadding!;

    final Widget icon = Icon(
      entry.item.icon,
      size: iconSize,
      color: foreground,
    );
    final Widget tappable;
    if (collapsed) {
      tappable = Clickable(
        onPressed: onTap,
        focusNode: focusNode,
        shortcuts: _sidebarArrowShortcuts(),
        decoration: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (selected) {
            return BoxDecoration(color: activeBackground, borderRadius: radius);
          }
          return const BoxDecoration();
        }),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: itemHeight),
          child: Center(child: icon),
        ),
      );
      return Semantics(
        button: true,
        selected: selected,
        label: entry.item.label,
        child: Tooltip(tooltip: (_) => Text(entry.item.label), child: tappable),
      );
    }
    tappable = Clickable(
      onPressed: onTap,
      focusNode: focusNode,
      shortcuts: _sidebarArrowShortcuts(),
      decoration: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (selected) {
          return BoxDecoration(color: activeBackground, borderRadius: radius);
        }
        return const BoxDecoration();
      }),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(padding),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: itemHeight),
        child: Row(
          children: <Widget>[
            if (entry.depth > 0)
              SizedBox(width: (iconSize + theme.spacing.sm) * entry.depth),
            icon,
            Gap(theme.spacing.sm),
            Expanded(
              child: Text(
                entry.item.label,
                style: theme.typography.textSmall.copyWith(
                  color: foreground,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (entry.item.badge != null) ...<Widget>[
              Badge(
                variant: BadgeVariant.secondary,
                child: Text(entry.item.badge!),
              ),
              Gap(theme.spacing.sm),
            ],
            if (entry.item.hasChildren)
              MotionChevron(
                expanded: entry.open,
                turns: 0.5,
                child: Icon(
                  LucideIcons.chevronDown,
                  size: iconSize,
                  color: foreground,
                ),
              ),
          ],
        ),
      ),
    );
    return Semantics(
      button: true,
      selected: selected,
      label: entry.item.label,
      child: tappable,
    );
  }
}

/// Marker intent for the sidebar's arrow keys: rows override Clickable's
/// default arrow traversal with this unhandled intent so the keys bubble to
/// the sidebar's scope handler, which moves and expands explicitly.
class _SidebarArrowIntent extends Intent {
  /// Creates the marker intent.
  const _SidebarArrowIntent();
}

/// Arrow bindings shared by every sidebar row (see [_SidebarArrowIntent]).
Map<LogicalKeySet, Intent> _sidebarArrowShortcuts() => <LogicalKeySet, Intent>{
  LogicalKeySet(LogicalKeyboardKey.arrowUp): const _SidebarArrowIntent(),
  LogicalKeySet(LogicalKeyboardKey.arrowDown): const _SidebarArrowIntent(),
  LogicalKeySet(LogicalKeyboardKey.arrowLeft): const _SidebarArrowIntent(),
  LogicalKeySet(LogicalKeyboardKey.arrowRight): const _SidebarArrowIntent(),
};

/// Footer account row: avatar, name, email and the dropdown chevron.
class _SidebarFooter extends StatelessWidget {
  const _SidebarFooter({
    required this.user,
    required this.collapsed,
    required this.onUserPressed,
    required this.style,
  });

  final SidebarUser user;
  final bool collapsed;
  final VoidCallback? onUserPressed;
  final SidebarTheme style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double iconSize = style.iconSize ?? kSidebarIconSize;
    final Widget avatar = Avatar(
      initials: Avatar.getInitials(user.name),
      size: 32,
    );
    final Widget row = Clickable(
      onPressed: onUserPressed,
      decoration: const WidgetStatePropertyAll<BoxDecoration>(BoxDecoration()),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.all(theme.spacing.sm),
      ),
      child: collapsed
          ? Center(child: avatar)
          : Row(
              children: <Widget>[
                avatar,
                Gap(theme.spacing.sm),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: theme.typography.textSmall.copyWith(
                          color: theme.colors.sidebarForeground,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.email,
                        style: theme.typography.xSmall.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.chevronsUpDown,
                  size: iconSize,
                  color: theme.colors.mutedForeground,
                ),
              ],
            ),
    );
    if (collapsed) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(height: 1, color: theme.colors.sidebarBorder),
          Gap(theme.spacing.sm),
          Semantics(
            button: true,
            label: user.name,
            child: Tooltip(tooltip: (_) => Text(user.name), child: row),
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(height: 1, color: theme.colors.sidebarBorder),
        Gap(theme.spacing.xs),
        Semantics(button: true, label: user.name, child: row),
      ],
    );
  }
}
