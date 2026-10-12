// The `sidebar-03` block: a whole app shell — header, grouped sidebar,
// content.
//
// A block is layer 4 of the registry: it may import foundation, theme,
// primitives and components, never another block. Its public widget is the
// preview - the docs page renders it exactly as an app would.
//
// From 840px the shell is a header row over a full-height grouped sidebar
// beside the content; below that a menu button in the header opens the
// sidebar as a drawer. The content is a sample workspace with stats,
// projects and activity, filling the rest of the page and scrolling
// internally.

import 'package:flutter/widgets.dart';

import '../../components/avatar/avatar.dart';
import '../../components/breadcrumb/breadcrumb.dart';
import '../../components/button/button.dart';
import '../../components/drawer/drawer.dart';
import '../../components/input/input.dart';
import 'sidebar_03_content.dart';
import 'sidebar_03_sidebar.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';

/// A complete application shell: header, sidebar and a sample screen.
class Sidebar03 extends StatefulWidget {
  /// Creates the block.
  const Sidebar03({super.key});

  @override
  State<Sidebar03> createState() => _Sidebar03State();
}

class _Sidebar03State extends State<Sidebar03> {
  int _selected = 0;

  void _openNav() {
    openDrawer(
      context: context,
      position: OverlayPosition.start,
      builder: (BuildContext context) => SingleChildScrollView(
        child: Sidebar03Sidebar(
          selected: _selected,
          onSelected: (int index) {
            setState(() => _selected = index);
            closeDrawer(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    return ColoredBox(
      color: theme.colors.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool inset = constraints.maxWidth >= 840;
            final bool bounded = constraints.maxHeight.isFinite;
            final Widget content = Sidebar03Content(selected: _selected);
            if (!bounded) {
              final Widget body;
              if (!inset) {
                body = Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _Sidebar03Header(selected: _selected, onMenu: _openNav),
                    Gap(theme.spacing.md),
                    content,
                  ],
                );
              } else {
                body = Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _Sidebar03Header(selected: _selected),
                    Gap(theme.spacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 260,
                          child: Sidebar03Sidebar(
                            selected: _selected,
                            onSelected: (int index) =>
                                setState(() => _selected = index),
                          ),
                        ),
                        Gap(theme.spacing.md),
                        Expanded(child: content),
                      ],
                    ),
                  ],
                );
              }
              return Padding(
                padding: EdgeInsets.all(theme.spacing.md),
                child: body,
              );
            }
            if (!inset) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      theme.spacing.md,
                      theme.spacing.md,
                      theme.spacing.md,
                      0,
                    ),
                    child: _Sidebar03Header(
                      selected: _selected,
                      onMenu: _openNav,
                    ),
                  ),
                  Gap(theme.spacing.md),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        theme.spacing.md,
                        0,
                        theme.spacing.md,
                        theme.spacing.md,
                      ),
                      child: content,
                    ),
                  ),
                ],
              );
            }
            // Desktop app shell: header fixed on top, sidebar full height
            // beside content that scrolls internally and fills the rest.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    theme.spacing.md,
                    theme.spacing.md,
                    theme.spacing.md,
                    0,
                  ),
                  child: _Sidebar03Header(selected: _selected),
                ),
                Gap(theme.spacing.md),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      theme.spacing.md,
                      0,
                      theme.spacing.md,
                      theme.spacing.md,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          width: 260,
                          child: SingleChildScrollView(
                            child: Sidebar03Sidebar(
                              selected: _selected,
                              onSelected: (int index) =>
                                  setState(() => _selected = index),
                            ),
                          ),
                        ),
                        Gap(theme.spacing.md),
                        Expanded(child: SingleChildScrollView(child: content)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Sidebar03Header extends StatelessWidget {
  const _Sidebar03Header({required this.selected, this.onMenu});

  static const List<String> _titles = <String>[
    'Dashboard',
    'Documents',
    'Reports',
    'Settings',
  ];

  final int selected;

  /// When non-null (mobile), a menu trigger replaces the product mark.
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        borderRadius: theme.borderRadiusLg,
        border: Border.all(color: theme.colors.border),
      ),
      // The 200 px search field collapses below 500 px (like the reference
      // header), so the trigger, breadcrumb and avatar always fit a phone.
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool showSearch = constraints.maxWidth >= 500;
          final VoidCallback? onMenu = this.onMenu;
          return Row(
            children: <Widget>[
              if (onMenu != null) ...<Widget>[
                Button(
                  variant: ButtonVariant.ghost,
                  size: ButtonSize.icon,
                  onPressed: onMenu,
                  child: const Icon(LucideIcons.menu, size: 18),
                ),
                Gap(theme.spacing.md),
              ] else ...<Widget>[
                Icon(
                  LucideIcons.command,
                  size: 18,
                  color: theme.colors.foreground,
                ),
                Gap(theme.spacing.md),
              ],
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Breadcrumb(
                    children: <Widget>[
                      Text(
                        'Acme',
                        style: theme.typography.textSmall.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                      const Gap(0, crossAxisExtent: 8),
                      Text(
                        _titles[selected],
                        style: theme.typography.textSmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (showSearch) ...<Widget>[
                Gap(theme.spacing.md),
                const SizedBox(width: 200, child: Input(hintText: 'Search')),
              ],
              Gap(theme.spacing.md),
              const Avatar(initials: 'AC'),
            ],
          );
        },
      ),
    );
  }
}
