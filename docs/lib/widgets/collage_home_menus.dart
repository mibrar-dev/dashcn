// Home showcase: overlay cards, part 2 — menubar, menu, command (P6-H1).
//
// `Menubar` opens real submenu popovers on tap; the dropdown surface shows
// the reference home's opened-menu look inline; the command card opens a
// real `Command` palette through a dialog.

import 'package:flutter/widgets.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/command/command.dart';
import '../ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import '../ui/dashcn/components/menu/menu.dart';
import '../ui/dashcn/components/menubar/menubar.dart';
import '../ui/dashcn/primitives/subfocus_list_item.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Menu bar`: registry menus with real submenu popovers.
class HomeMenubarCard extends StatelessWidget {
  /// Creates the card.
  const HomeMenubarCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeMenuTitle'),
      subtitle: docsHome(locale, 'homeMenuSub'),
      children: <Widget>[
        // `Menubar` sizes its window intrinsically and cannot shrink below
        // its widest row. Clip-free horizontal scroll keeps it reachable in
        // a narrow column instead of overflowing.
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Menubar(
              children: <Widget>[
                MenuButton(
                  subMenu: <Widget>[
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'New release')),
                    ),
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'Open…')),
                    ),
                    MenuSeparator(),
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'Export CSV')),
                    ),
                  ],
                  child: Text(docsSample(context, 'File')),
                ),
                MenuButton(
                  subMenu: <Widget>[
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'Undo')),
                    ),
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'Redo')),
                    ),
                  ],
                  child: Text(docsSample(context, 'Edit')),
                ),
                MenuButton(
                  subMenu: <Widget>[
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'Dashboard')),
                    ),
                    MenuButton(
                      onPressed: _menuNoop,
                      child: Text(docsSample(context, 'Reports')),
                    ),
                  ],
                  child: Text(docsSample(context, 'View')),
                ),
              ],
            ),
          ),
        ),
        Gap(12),
        StudioHelper(
          docsSample(
            context,
            'Menus open anchored popovers, like the desktop app.',
          ),
        ),
      ],
    );
  }
}

void _menuNoop(BuildContext context) {}

/// `Quick actions`: the opened dropdown-menu surface, inline.
class HomeDropdownCard extends StatelessWidget {
  /// Creates the card.
  const HomeDropdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeQuickTitle'),
      subtitle: docsHome(locale, 'homeQuickSub'),
      children: <Widget>[
        SizedBox(
          width: 220,
          child: DropdownMenu(
            children: <Widget>[
              MenuButton(
                onPressed: _menuNoop,
                child: Text(docsSample(context, 'Profile')),
              ),
              MenuButton(
                onPressed: _menuNoop,
                child: Text(docsSample(context, 'Settings')),
              ),
              MenuSeparator(),
              MenuButton(
                trailing: MenuShortcut(shortcut: '⌘Q'),
                onPressed: _menuNoop,
                child: Text(docsSample(context, 'Sign out')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// `Command palette`: a trigger opening a real `Command` dialog.
class HomeCommandCard extends StatelessWidget {
  /// Creates the card.
  const HomeCommandCard({super.key});

  static final List<String> _commands = <String>[
    docsSample(null, 'Go to Dashboard'),
    docsSample(null, 'Create release'),
    docsSample(null, 'Invite teammate'),
    docsSample(null, 'Open settings'),
    docsSample(null, 'Export report'),
  ];

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsHome(locale, 'homePaletteTitle'),
      subtitle: docsHome(locale, 'homePaletteSub'),
      children: <Widget>[
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          leading: const Icon(LucideIcons.search, size: 14),
          // Single surface: `showCommandDialog` presents the `Command`
          // palette through a transparent dialog shell, so only the
          // palette's own border paints (a plain `showDialog` + `Command`
          // would stack the dialog card border behind the palette border).
          onPressed: () => showCommandDialog<void>(
            context: context,
            constraints: const BoxConstraints(maxWidth: 320),
            debounceDuration: Duration.zero,
            searchPlaceholder: Text(docsSample(context, 'Type a command...')),
            builder: (BuildContext context, String? query) async* {
              yield <Widget>[
                for (final String command in _commands)
                  if (query == null ||
                      command.toLowerCase().contains(query.toLowerCase()))
                    SubFocusListItem(
                      title: Text(command),
                      onTap: () => Navigator.pop(context),
                    ),
              ];
            },
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(docsSample(context, 'Commands…')),
              const Gap(12),
              Text(
                '⌘K',
                style: theme.typography.xSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
