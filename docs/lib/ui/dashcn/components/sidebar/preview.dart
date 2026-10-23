// Named examples for the `sidebar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. The shells stretch to their constraints and switch
// to a phone bar + drawer pattern below the density phone breakpoint, so they
// render on a desktop stage, in the docs device frame and at phone widths
// alike. Density tokens size the drawer cap, gaps and glyphs; the dashboard
// content scrolls vertically when the stage height is bounded and uses a
// narrower (collapsed) rail on tight desktop stages, so every example fits
// the standard stage at 375 and 1440 widths.
//
// Every example is self-contained: copy the widget (plus its sample data)
// into an app and it runs.

import 'package:flutter/widgets.dart';

import '../../components/button/button.dart';
import '../../components/drawer/drawer.dart';
import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'sidebar.dart';

/// Width below which the shells switch to the phone bar + drawer pattern.
///
/// Tracks the density phone breakpoint ([kPhoneWidthBreakpoint], 600 px) so
/// the docs 295 px example stage (375 px viewport) and any narrow stage use
/// the phone bar (no 256 px rail) instead of overflowing.
const double kSidebarPhoneWidth = kPhoneWidthBreakpoint;

/// Fallback shell height when the stage leaves the height unbounded.
const double kSidebarFallbackHeight = 360.0;

/// Sample navigation shared by the examples.
List<SidebarSection> _sampleSections([BuildContext? context]) =>
    <SidebarSection>[
      SidebarSection(
        label: docsSample(context, 'Main'),
        items: <SidebarItem>[
          SidebarItem(
            label: docsSample(context, 'Dashboard'),
            icon: LucideIcons.layoutDashboard,
          ),
          SidebarItem(
            label: docsSample(context, 'Documents'),
            icon: LucideIcons.fileText,
            badge: '12',
          ),
          SidebarItem(
            label: docsSample(context, 'Reports'),
            icon: LucideIcons.chartBar,
          ),
        ],
      ),
      SidebarSection(
        label: docsSample(context, 'Account'),
        items: <SidebarItem>[
          SidebarItem(
            label: docsSample(context, 'Settings'),
            icon: LucideIcons.settings,
            children: <SidebarItem>[
              SidebarItem(
                label: docsSample(context, 'Profile'),
                icon: LucideIcons.circleUser,
              ),
              SidebarItem(
                label: docsSample(context, 'Billing'),
                icon: LucideIcons.creditCard,
              ),
            ],
          ),
          SidebarItem(
            label: docsSample(context, 'Help'),
            icon: LucideIcons.circleHelp,
          ),
        ],
      ),
    ];

/// The footer account shared by the examples.
SidebarUser _sampleUser = SidebarUser(
  name: docsSample(null, 'Ibrar Ahmed'),
  email: 'm@example.com',
);

/// Small content panel shown beside the rail. Scrolls internally when the
/// height is bounded, shrink-wraps otherwise.
class _DemoContent extends StatelessWidget {
  const _DemoContent(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density tokens drive the card thumb (control height: 32 compact,
    // 48 touch) and the gaps, so the content tracks compact/touch density
    // instead of hard-coding 32/8.
    final DensityTokens tokens = resolveDensityTokens(context);
    final Widget cards = Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(bottom: theme.spacing.sm),
            padding: EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.card,
              borderRadius: theme.borderRadiusLg,
              border: Border.all(color: theme.colors.border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: tokens.controlHeight,
                  height: tokens.controlHeight,
                  decoration: BoxDecoration(
                    color: theme.colors.accent,
                    borderRadius: theme.borderRadiusSm,
                  ),
                ),
                Gap(tokens.gap),
                Expanded(
                  child: Text(
                    '${'Card'} ${i + 1}',
                    style: theme.typography.textSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return ColoredBox(
      color: theme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget body = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  docsSample(
                    context,
                    docsSample(
                      context,
                      docsSample(context, 'Pick a row in the sidebar to switch sections.'),
                    ),
                  ),
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                cards,
              ],
            );
            if (!constraints.maxHeight.isFinite) {
              return body;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  docsSample(
                    context,
                    docsSample(
                      context,
                      docsSample(context, 'Pick a row in the sidebar to switch sections.'),
                    ),
                  ),
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                Expanded(child: SingleChildScrollView(child: cards)),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Phone-width bar whose menu button opens the sidebar in a drawer, with
/// content below. Fills bounded heights, shrink-wraps otherwise.
class _PhoneDemo extends StatefulWidget {
  const _PhoneDemo({required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<_PhoneDemo> createState() => _PhoneDemoState();
}

class _PhoneDemoState extends State<_PhoneDemo> {
  void _openNav() {
    openDrawer(
      context: context,
      position: OverlayPosition.start,
      builder: (BuildContext drawerContext) => DashboardSidebar(
        sections: _sampleSections(drawerContext),
        selectedId: widget.selected,
        onSelected: (String id) {
          widget.onSelected(id);
          closeDrawer(drawerContext);
        },
        user: _sampleUser,
        onUserPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density-aware menu glyph (16 compact, 24 touch) and gaps.
    final DensityTokens tokens = resolveDensityTokens(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Widget bar = Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          decoration: BoxDecoration(
            color: theme.colors.sidebar,
            borderRadius: theme.borderRadiusLg,
            border: Border.all(color: theme.colors.sidebarBorder),
          ),
          child: Row(
            children: <Widget>[
              Button(
                variant: ButtonVariant.ghost,
                size: ButtonSize.icon,
                onPressed: _openNav,
                child: Icon(LucideIcons.menu, size: resolveIconSize(tokens)),
              ),
              Gap(tokens.gap),
              Expanded(
                child: Text(
                  widget.selected,
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.sidebarForeground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
        if (!constraints.maxHeight.isFinite) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              bar,
              Gap(theme.spacing.md),
              _DemoContent(widget.selected),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            bar,
            Gap(theme.spacing.md),
            Expanded(child: _DemoContent(widget.selected)),
          ],
        );
      },
    );
  }
}

/// Full sidebar beside content on wide stages, phone bar + drawer below
/// [kSidebarPhoneWidth] (the density phone breakpoint). Narrow desktop
/// stages use the collapsed 64 px rail so the 256 px rail never overflows
/// the docs 560 px example stage; the content column scrolls vertically
/// when the stage height is bounded. Collapse control and account footer
/// included.
class _DashboardDemo extends StatefulWidget {
  const _DashboardDemo();

  @override
  State<_DashboardDemo> createState() => _DashboardDemoState();
}

class _DashboardDemoState extends State<_DashboardDemo> {
  String _selected = docsSample(null, 'Dashboard');
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : kPhoneWidthBreakpoint;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : kSidebarFallbackHeight;
        final Widget body;
        if (width < kSidebarPhoneWidth) {
          body = _PhoneDemo(
            selected: _selected,
            onSelected: (String id) => setState(() => _selected = id),
          );
        } else {
          // Docs stages (560 px at 1440 px viewports, 295 px at 375 px
          // viewports which take the phone branch above) stay overflow-free:
          // tight desktop widths keep the collapsed rail (narrower sidebar
          // inside the stage) instead of forcing the full 256 px rail.
          final bool narrowStage = width < 720;
          body = Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DashboardSidebar(
                sections: _sampleSections(context),
                selectedId: _selected,
                onSelected: (String id) => setState(() => _selected = id),
                collapsed: narrowStage ? true : _collapsed,
                onToggleCollapsed: () =>
                    setState(() => _collapsed = !_collapsed),
                user: _sampleUser,
                onUserPressed: () {},
              ),
              Expanded(child: _DemoContent(_selected)),
            ],
          );
        }
        return SizedBox(width: width, height: height, child: body);
      },
    );
  }
}

/// Phone shell: the bar opens the same sidebar in a drawer. Sized to its
/// stage (capped at the density overlay max width) so it reads as a phone
/// mock on desktop stages and full-bleed on phones.
class _DrawerDemo extends StatefulWidget {
  const _DrawerDemo();

  @override
  State<_DrawerDemo> createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<_DrawerDemo> {
  String _selected = docsSample(null, 'Dashboard');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Density-aware phone cap (320 compact, 400 touch) sized to the
        // stage: full-bleed at 375 px viewports (295 px stage), capped mock
        // at 1440 px viewports (560 px stage).
        final DensityTokens tokens = resolveDensityTokens(context);
        final double cap = tokens.overlayMaxWidth;
        final double width = constraints.maxWidth.isFinite
            ? (constraints.maxWidth > cap ? cap : constraints.maxWidth)
            : cap;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 560;
        return SizedBox(
          width: width,
          height: height,
          child: _PhoneDemo(
            selected: _selected,
            onSelected: (String id) => setState(() => _selected = id),
          ),
        );
      },
    );
  }
}

/// Collapsed 64 px icon rail beside content, with tooltips on every row.
/// Below [kSidebarPhoneWidth] the rail stays beside a squeezed content
/// column (both fit the 295 px phone stage).
class _CollapsedDemo extends StatefulWidget {
  const _CollapsedDemo();

  @override
  State<_CollapsedDemo> createState() => _CollapsedDemoState();
}

class _CollapsedDemoState extends State<_CollapsedDemo> {
  String _selected = docsSample(null, 'Dashboard');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 480;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : kSidebarFallbackHeight;
        return SizedBox(
          width: width,
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DashboardSidebar(
                sections: _sampleSections(context),
                selectedId: _selected,
                onSelected: (String id) => setState(() => _selected = id),
                collapsed: true,
                user: _sampleUser,
                onUserPressed: () {},
              ),
              Expanded(child: _DemoContent(_selected)),
            ],
          ),
        );
      },
    );
  }
}

/// Named docs examples for `sidebar`; the first entry is the default.
List<ComponentPreview> get sidebarPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Dashboard'), _dashboard),
  ComponentPreview('Drawer', _drawer),
  ComponentPreview(docsSample(null, 'Collapsed'), _collapsed),
];

Widget _dashboard(BuildContext context) => const _DashboardDemo();

Widget _drawer(BuildContext context) => const _DrawerDemo();

Widget _collapsed(BuildContext context) => const _CollapsedDemo();
