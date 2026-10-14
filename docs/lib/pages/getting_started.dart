// `/docs/installation` — getting started (spec §2.6): a typeset page with
// `.step`-numbered H3 counters and code figures. The install mode tabs
// (Package | Own the code) share one command source with the component
// install blocks (`widgets/install_commands.dart`); the steps below walk
// the own-the-code flow. Every command comes from the CLI snapshot.

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/code_figure.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/install_commands.dart';
import '../widgets/typeset.dart';

/// `/docs/installation` — getting started.
class GettingStartedPage extends StatelessWidget {
  /// Creates the installation page.
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/installation');
    return DocsLayout(
      child: DocsArticle(
        title: 'Getting started',
        description:
            'Install the dashcn registry into your Flutter project '
            'and start building with widgets-only components.',
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          const TypesetParagraph(
            'Use the components two ways, from the same source: depend on '
            'the published package and update via semver, or copy the '
            'sources into your project and own them. Pick a tab — the '
            'steps below walk the own-the-code flow.',
          ),
          const _InstallModeTabs(),
          _TemplateParagraph(),
          const _StepCounter(
            number: 1,
            title: 'Create a Flutter project',
            code: 'flutter create my_app',
          ),
          const _StepCounter(
            number: 2,
            title: 'Install the layer core',
            code: 'dashcn init',
          ),
          const _StepCounter(
            number: 3,
            title: 'Add components',
            code: 'dashcn add button',
          ),
          const _StepCounter(
            number: 4,
            title: 'Choose a preset',
            code: 'dashcn theme apply modern-minimal',
          ),
          const HeadingAnchor(id: 'verify', title: 'Verify'),
          const TypesetParagraph(
            'After installation, your project has the registry layer core '
            '(foundation + theme) and the components you added. Run the app '
            'to see the components in action.',
          ),
          const TypesetBullets(
            items: <List<InlineSpan>>[
              <InlineSpan>[
                TextSpan(
                  text: 'Layer core: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text:
                      'foundation, theme and primitives install first; '
                      'components depend on them.',
                ),
              ],
              <InlineSpan>[
                TextSpan(
                  text: 'Lock file: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text:
                      'dashcn.lock v2 records the exact hashes so updates '
                      'stay reviewable.',
                ),
              ],
              <InlineSpan>[
                TextSpan(
                  text: 'User-owned themes: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text:
                      '*_theme.dart files are never overwritten by CLI '
                      'updates.',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Short template pointer below the install tabs (P9-Z2).
class _TemplateParagraph extends StatelessWidget {
  const _TemplateParagraph();

  @override
  Widget build(BuildContext context) {
    return TypesetParagraph.rich(<InlineSpan>[
      const TextSpan(text: 'Start from a template: '),
      typesetLinkSpan('browse the starters', () {
        DocsRouterScope.of(context).go(context, '/docs/starters');
      }),
      const TextSpan(
        text: ' — one command scaffolds a runnable app from flows and blocks.',
      ),
    ]);
  }
}

/// Package | Own the code tabs sharing the install command source.
class _InstallModeTabs extends StatefulWidget {
  const _InstallModeTabs();

  @override
  State<_InstallModeTabs> createState() => _InstallModeTabsState();
}

class _InstallModeTabsState extends State<_InstallModeTabs> {
  // 0 = Package, 1 = Own the code.
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Gap(16),
        // Narrow screens scroll the tabs instead of overflowing.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _ModeTab(
                label: 'Package',
                selected: _tab == 0,
                onTap: () => setState(() => _tab = 0),
              ),
              _ModeTab(
                label: 'Own the code',
                selected: _tab == 1,
                onTap: () => setState(() => _tab = 1),
              ),
            ],
          ),
        ),
        if (_tab == 0)
          const DocsCodeFigure(code: kPackageGettingStarted, language: 'bash')
        else
          const DocsCodeFigure(code: kOwnCodeGettingStarted, language: 'bash'),
        const TypesetParagraph.rich(<InlineSpan>[
          TextSpan(
            text: 'Own-the-code apps stay on the package path too: run ',
          ),
          WidgetSpan(child: TypesetInlineCode('dashcn eject button')),
          TextSpan(text: ' later to turn a package import into owned sources.'),
        ]),
      ],
    );
  }
}

class _ModeTab extends StatelessWidget {
  const _ModeTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Clickable(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? theme.colors.primary : const Color(0x00000000),
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: docsText(
            context,
            size: 14,
            weight: FontWeight.w500,
            color: selected
                ? theme.colors.foreground
                : theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}

/// A `.step`-numbered H3 with a code figure (spec §2.3).
class _StepCounter extends StatelessWidget {
  const _StepCounter({
    required this.number,
    required this.title,
    required this.code,
  });

  final int number;
  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DocsSiteColors site = DocsSiteColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: theme.colors.muted,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colors.border),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$number',
                  style: theme.typography.mono.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Text(
                  title,
                  style: docsText(
                    context,
                    size: 16.875,
                    weight: FontWeight.w600,
                    height: 24.47 / 16.875,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Container(
            decoration: BoxDecoration(
              color: site.codeSurface,
              // P7-TH1: code figures use the card radius token (rounded-lg).
              borderRadius: theme.borderRadiusLg,
              border: Border.all(
                color: theme.colors.border.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        LucideIcons.terminal,
                        size: 16,
                        color: theme.colors.foreground.withValues(alpha: 0.7),
                      ),
                      const Gap(8),
                      // Long commands scroll horizontally instead of
                      // overflowing the 640 px article at 375 (spec §2.3
                      // `pre` overflow).
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            code,
                            style: theme.typography.mono.copyWith(
                              fontSize: 14,
                              height: 24.5 / 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
