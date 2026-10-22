// The charts gallery shell shared by `/charts` (first family) and
// `/charts/<family>` (one family): hero, family tab bar and the section.
//
// Full-width like Blocks/Themes: no docs sidebar. The header keeps `Charts`
// active through the router's `startsWith('/charts')` rule.

import 'package:flutter/widgets.dart';

import '../motion/motion_scope.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/docs_tokens.dart';
import 'charts_data.dart';
import 'charts_section.dart';

/// Outer padding + max width of the charts gallery (mirrors Blocks/Flows).
const double kChartsMaxWidth = 1400;

/// `/charts` when [familyId] is null (first family), `/charts/<family>`
/// otherwise.
class ChartsGallery extends StatefulWidget {
  /// Creates the gallery, optionally scoped to one family.
  const ChartsGallery({super.key, this.familyId});

  /// The family to show, or null for the first family.
  final String? familyId;

  @override
  State<ChartsGallery> createState() => _ChartsGalleryState();
}

class _ChartsGalleryState extends State<ChartsGallery> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _galleryKey = GlobalKey(debugLabel: 'charts-gallery');

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _browse() {
    final BuildContext? context = _galleryKey.currentContext;
    if (context == null) {
      return;
    }
    Scrollable.ensureVisible(
      context,
      duration: this.context.motionDuration(const Duration(milliseconds: 300)),
      curve: Curves.easeOut,
      alignment: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tab bar: the first family is selected by default on `/charts`; only
    // the selected family renders (never all families on one scroll).
    final String selectedId = widget.familyId ?? kChartFamilies.first.id;
    final List<ChartFamily> families = kChartFamilies
        .where((ChartFamily family) => family.id == selectedId)
        .toList(growable: false);
    return SingleChildScrollView(
      controller: _scroll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChartsHero(onBrowse: _browse),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kChartsMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ChartFamilyNav(activeFamilyId: selectedId),
                    Gap(Theme.of(context).spacing.lg),
                    Column(
                      key: _galleryKey,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        for (int i = 0; i < families.length; i++) ...<Widget>[
                          if (i > 0) const Gap(40),
                          ChartFamilySection(
                            key: ValueKey<String>(
                              'chart-family-section-${families[i].id}',
                            ),
                            family: families[i],
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The charts hero: title, one-line subtitle, Browse + Documentation actions.
class ChartsHero extends StatelessWidget {
  /// Creates the hero.
  const ChartsHero({super.key, required this.onBrowse});

  /// Scrolls the page to the gallery.
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final bool wide = width >= 1024;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, wide ? 64 : 32, 24, 32),
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 896),
            child: Text(
              'Charts',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: wide ? 40 : 30,
                weight: FontWeight.w600,
                height: 1.15,
                letterSpacing: wide ? -1 : 0,
                color: theme.colors.foreground,
              ),
            ),
          ),
          Gap(theme.spacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Copy-paste charts for every dataset, from trends to breakdowns.',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: width >= 640 ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const Gap(20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: theme.spacing.sm,
            runSpacing: theme.spacing.sm,
            children: <Widget>[
              Button(
                variant: ButtonVariant.primary,
                size: ButtonSize.md,
                onPressed: onBrowse,
                child: const Text('Browse charts'),
              ),
              Button(
                variant: ButtonVariant.secondary,
                size: ButtonSize.md,
                leading: const Icon(LucideIcons.bookOpen, size: 16),
                onPressed: () => DocsRouterScope.of(
                  context,
                ).go(context, '/docs/components/chart'),
                child: const Text('Documentation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The family tab bar: one tab per family, switching families.
///
/// Horizontally scrollable so phone widths never overflow. The first family
/// is selected by default; only the selected family renders below.
class ChartFamilyNav extends StatelessWidget {
  /// Creates the nav; [activeFamilyId] is the selected tab.
  const ChartFamilyNav({super.key, this.activeFamilyId});

  /// The selected family id.
  final String? activeFamilyId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Semantics(
      label: 'Chart families',
      explicitChildNodes: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (int i = 0; i < kChartFamilies.length; i++) ...<Widget>[
              if (i > 0) Gap(theme.spacing.sm),
              _FamilyPill(
                key: ValueKey<String>(
                  'chart-family-pill-${kChartFamilies[i].id}',
                ),
                family: kChartFamilies[i],
                active: kChartFamilies[i].id == activeFamilyId,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FamilyPill extends StatelessWidget {
  const _FamilyPill({super.key, required this.family, required this.active});

  final ChartFamily family;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Clickable(
      onPressed: () =>
          DocsRouterScope.of(context).go(context, '/charts/${family.id}'),
      decoration: WidgetStateProperty.resolveWith<Decoration?>((
        Set<WidgetState> states,
      ) {
        return BoxDecoration(
          color: active
              ? theme.colors.secondary
              : (states.contains(WidgetState.hovered)
                    ? theme.colors.muted
                    : theme.colors.background),
          border: Border.all(
            color: active ? theme.colors.input : const Color(0x00000000),
          ),
          borderRadius: theme.borderRadiusMd,
        );
      }),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      textStyle: WidgetStatePropertyAll<TextStyle?>(
        docsText(
          context,
          size: 13,
          weight: FontWeight.w500,
          color: active
              ? theme.colors.secondaryForeground
              : theme.colors.mutedForeground,
        ),
      ),
      child: Text(family.title),
    );
  }
}

/// Family ids in nav order (mirrors [kChartLinks]).
List<String> get chartGalleryFamilyIds => <String>[
  for (final DocsNavLink link in kChartLinks) link.location.split('/').last,
];
