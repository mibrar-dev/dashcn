// Landing page (spec §2.1, P9-Z hero): announcement badge → H1 → description
// → two CTAs → the live multi-frame hero demo (P9-Z, deferred like the
// other heavy pages) → the live collage. The stats band, marquee, feature
// grid, steps, CTA band and 4-column footer are deleted per spec §5.1; the
// one-line footer lives in the shell.
//
// P7-TH1: the hero CTAs are plain registry `Button`s, so they follow the
// active theme radius (buttons = radiusMd) instead of forcing pills; gaps
// follow the theme spacing.

import 'package:flutter/widgets.dart';

import '../generated/docs_data.dart';
import '../landing/hero_demo.dart' deferred as hero_demo;
import '../routing/docs_router.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/announcement.dart';
import '../widgets/collage.dart';
import '../widgets/docs_footer.dart';
import '../widgets/docs_tokens.dart';

/// `/` — the landing page.
class LandingPage extends StatelessWidget {
  /// Creates the landing page.
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final bool xl = width >= 1280;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            // Spec §2.1: `py-8` base, `md:py-16`, `lg:py-20` on top; the
            // measured gap below the CTAs is 72 px to the first collage card
            // (48 px section padding + the collage's 24 px top padding).
            padding: EdgeInsets.fromLTRB(
              24,
              width >= 768 ? (xl ? 80 : 64) : 32,
              24,
              width >= 768 ? 48 : 32,
            ),
            child: Column(
              children: <Widget>[
                Announcement(
                  label:
                      '${kStats.listedComponents} components ready to install',
                  onPressed: () =>
                      DocsRouterScope.of(context).go(context, '/docs'),
                ),
                Gap(xl ? theme.spacing.lg : theme.spacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 896),
                  child: Text(
                    'Every platform at once',
                    textAlign: TextAlign.center,
                    style: docsText(
                      context,
                      size: xl ? 48 : 30,
                      weight: FontWeight.w600,
                      height: 1.1,
                      letterSpacing: xl ? -2.4 : 0,
                      color: theme.colors.foreground,
                    ),
                  ),
                ),
                Gap(xl ? theme.spacing.lg : theme.spacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 896),
                  child: Text(
                    'The same flow, running live in iPhone, Android and '
                    'desktop frames.\nWidgets-only components you install '
                    'and own.',
                    textAlign: TextAlign.center,
                    style: docsText(
                      context,
                      size: width >= 640 ? 18 : 16,
                      height: 28 / 18,
                    ),
                  ),
                ),
                const Gap(20),
                Wrap(
                  alignment: WrapAlignment.center,
                  // P7-TH1: CTA spacing follows the theme (gap-2).
                  spacing: theme.spacing.sm,
                  runSpacing: theme.spacing.sm,
                  children: <Widget>[
                    _PillButton(
                      label: 'Get Started',
                      primary: true,
                      onPressed: () => DocsRouterScope.of(
                        context,
                      ).go(context, '/docs/installation'),
                    ),
                    _PillButton(
                      label: 'Browse flows',
                      primary: false,
                      onPressed: () => DocsRouterScope.of(
                        context,
                      ).go(context, '/docs/flows'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const _DeferredHeroDemo(),
          const Gap(24),
          const DocsCollage(),
          DocsFooter(
            onDocs: () => DocsRouterScope.of(context).go(context, '/docs'),
            onCli: () => DocsRouterScope.of(context).go(context, '/docs/cli'),
          ),
        ],
      ),
    );
  }
}

/// Key of the loaded hero demo (widget tests drain the deferred chunk by
/// waiting for this key; see `test/support/app_harness.dart`).
const ValueKey<String> kLandingHeroDemoKey = ValueKey<String>(
  'landing-hero-demo',
);

/// The hero demo slot: loads the `landing/hero_demo` chunk on demand and
/// shows a fixed-height placeholder until it arrives, so the landing stays
/// fast (same deferred pattern as the block/flow pages in `main.dart`).
class _DeferredHeroDemo extends StatefulWidget {
  /// Creates the slot.
  const _DeferredHeroDemo();

  @override
  State<_DeferredHeroDemo> createState() => _DeferredHeroDemoState();
}

class _DeferredHeroDemoState extends State<_DeferredHeroDemo> {
  Future<void>? _load;

  @override
  void initState() {
    super.initState();
    _load = hero_demo.loadLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _load,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return hero_demo.LandingHeroDemo(key: kLandingHeroDemoKey);
        }
        return const SizedBox(height: 560);
      },
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.primary,
    required this.onPressed,
  });

  final String label;
  final bool primary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // P7-TH1: plain registry buttons — the radius comes from the active
    // theme (radiusMd), so Theme Studio radius 0 → 1rem reshapes the hero.
    return Button(
      variant: primary ? ButtonVariant.primary : ButtonVariant.secondary,
      size: ButtonSize.md,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
