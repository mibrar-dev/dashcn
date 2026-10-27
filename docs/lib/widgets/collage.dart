// The landing collage (spec §2.1): a full-bleed live wall of registry
// components — 4 columns at `1400`, 3 at `1024`, 2 at `768`, gap 24 — with a
// bottom gradient fade and a light-mode-only top fade. The wall is a
// `MasonryLayout`, so every card keeps its natural height and the columns
// pack into the shortest gap. Below 768 the wall is replaced by a
// non-interactive static stack clipped to 140vw (the reference uses a baked
// screenshot image; we ship the composed static fallback instead of a binary
// asset — see the D3 report).

import 'package:flutter/widgets.dart';

import '../ui/dashcn/primitives/masonry_layout.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards_controls.dart';
import 'collage_cards_forms.dart';
import 'collage_cards_info.dart';
import 'collage_home_auth.dart';
import 'collage_home_data.dart';
import 'collage_home_feedback.dart';
import 'collage_home_forms.dart';
import 'collage_home_media.dart';
import 'collage_home_menus.dart';
import 'collage_home_misc.dart';
import 'collage_home_money.dart';
import 'collage_home_nav.dart';
import 'collage_home_overlays.dart';
import 'collage_home_settings.dart';
import 'collage_home_stats.dart';
import 'collage_home_time.dart';
import 'package:docs/widgets/preview_scope.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// The landing hero collage.
class DocsCollage extends StatelessWidget {
  /// Creates the collage.
  const DocsCollage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width < 768) {
      return const PreviewScope(child: StaticCollage());
    }
    final int columns = width >= 1400 ? 4 : (width >= 1024 ? 3 : 2);
    return PreviewScope(child: _CollageBody(columns: columns));
  }
}

/// The `<768` static collage preview.
///
/// The reference replaces the live grid with a baked screenshot below `md`;
/// this composed fallback shows a reduced, non-interactive, ticker-off card
/// set instead of shipping a binary asset (recorded in the D3 report).
class StaticCollage extends StatelessWidget {
  /// Creates the static collage.
  const StaticCollage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: IgnorePointer(
        child: TickerMode(
          enabled: false,
          child: _CollageBody(
            columns: 1,
            cards: const <Widget>[
              CollageButtonsCard(),
              CollageInputsCard(),
              CollagePresetsCard(),
              CollageInstallCard(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The grid + fades shared by the live and static variants (private).
class _CollageBody extends StatelessWidget {
  const _CollageBody({required this.columns, this.cards});

  final int columns;
  final List<Widget>? cards;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.colors.brightness == Brightness.dark;
    final double width = MediaQuery.sizeOf(context).width;
    final double bottomFade = width >= 1280 ? 256 : (width >= 1024 ? 320 : 192);
    final List<Widget> effectiveCards =
        cards ??
        // The masonry packs each card into the shortest column, so the
        // build order is the reading order, not a stack assignment. Tall
        // and short cards are interleaved so no column runs away, and the
        // set mirrors the reference home: buttons, forms, stats, overlays,
        // navigation, data display, feedback, settings, date/time, chat.
        <Widget>[
          CollageButtonsCard(),
          HomeAnalyticsCard(),
          HomePayoutCard(),
          CollageInputsCard(),
          HomeContributionCard(),
          HomeDialogCard(),
          CollageGoalCard(),
          HomeTransactionsCard(),
          HomeStatusCard(),
          CollageInstallCard(),
          CollageTabsCard(),
          HomeSavingsCard(),
          HomeMenubarCard(),
          CollagePresetsCard(),
          HomeReportCard(),
          HomeSidebarCard(),
          CollageRadioCard(),
          HomeClaimableCard(),
          HomeCommandCard(),
          CollagePagesCard(),
          HomeUsageCard(),
          HomeLoginCard(),
          CollageRegistryCard(),
          HomeDividendCard(),
          HomeDropdownCard(),
          CollageSwitchesCard(),
          HomeTeamCard(),
          HomeCalendarCard(),
          HomeNotificationsCard(),
          HomeFaqCard(),
          CollageTooltipCard(),
          HomeChatCard(),
          HomeAlertsCard(),
          HomeBrowseCard(),
          HomeSparkCard(
            title: docsSample(context, 'Net Revenue'),
            value: r'$48,320',
            caption: docsSample(context, '+12.4% vs last month'),
            samples: <double>[22, 26, 24, 31, 29, 38, 35, 44, 41, 52],
          ),
          HomeCreateAccountCard(),
          HomeStepperCard(),
          HomeShareCard(),
          CollageTableCard(),
          HomeAlertConfirmCard(),
          HomeOtpCard(),
          HomePreferencesCard(),
          HomeDrawerCard(),
          HomeEmptyCard(),
          HomeCardBalanceCard(),
          HomeDateRangeCard(),
          HomeLoadingCard(),
          HomeContributorsCard(),
          HomeActivityCard(),
          HomeTimeCard(),
          HomeRatingCard(),
          HomeTimelineCard(),
          HomeUploadCard(),
          HomeCookieCard(),
          HomeSparkCard(
            title: docsSample(context, 'Active Listeners'),
            value: '18,204',
            caption: docsSample(context, '+3.1% vs last month'),
            samples: <double>[31, 34, 33, 38, 42, 40, 46, 44, 49, 52],
          ),
        ];
    return DecoratedBox(
      decoration: BoxDecoration(
        color: dark ? theme.colors.background : theme.colors.muted,
      ),
      child: Stack(
        children: <Widget>[
          if (!dark)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 480,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        theme.colors.background,
                        theme.colors.muted,
                        theme.colors.muted.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1600),
                child: MasonryLayout.fixed(
                  crossAxisCount: columns,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  children: effectiveCards,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: bottomFade,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      theme.colors.background,
                      theme.colors.muted.withValues(alpha: 0.8),
                      theme.colors.muted.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
