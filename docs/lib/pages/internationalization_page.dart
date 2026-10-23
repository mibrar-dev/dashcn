// `/docs/internationalization` — translating the kit: the locale table,
// the language switcher, RTL mirroring and the offline `locale` command.

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_content_prose2.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/empty_state/empty_state.dart';
import '../ui/dashcn/components/pagination/pagination.dart';
import '../ui/dashcn/primitives/localizations/localizations.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/code_figure.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_samples.dart';
import '../widgets/docs_shell.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/typeset.dart';

/// `/docs/internationalization` — the i18n guide with a live switcher.
class InternationalizationPage extends StatelessWidget {
  /// Creates the internationalization page.
  const InternationalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/internationalization');
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return DocsLayout(
      child: DocsArticle(
        title: docsContentPage(locale, 'pageI18nTitle'),
        description: docsContentPage(locale, 'pageI18nDesc'),
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          TypesetParagraph(docsProse2(locale, 'proseI18nP1')),
          TypesetParagraph(docsProse2(locale, 'proseI18nP2')),
          HeadingAnchor(
            id: 'switcher',
            title: docsProse2(locale, 'proseI18nH1'),
          ),
          TypesetParagraph(docsProse2(locale, 'proseI18nP3')),
          const _LanguageSwitcherDemo(),
          HeadingAnchor(id: 'rtl', title: docsProse2(locale, 'proseI18nH2')),
          TypesetParagraph(docsProse2(locale, 'proseI18nP4')),
          const _RtlExampleCard(),
          DocsCodeFigure(
            code: kI18nSamples['rtl-override']!.code,
            language: 'dart',
          ),
          HeadingAnchor(
            id: 'per-instance',
            title: docsProse2(locale, 'proseI18nH3'),
          ),
          TypesetParagraph(docsProse2(locale, 'proseI18nP5')),
          DocsCodeFigure(
            code: kI18nSamples['per-instance']!.code,
            language: 'dart',
          ),
          HeadingAnchor(id: 'cli', title: docsProse2(locale, 'proseI18nH4')),
          TypesetParagraph(docsProse2(locale, 'proseI18nP6')),
          DocsCodeFigure(code: kI18nSamples['cli-add']!.code, language: 'sh'),
          TypesetParagraph(docsProse2(locale, 'proseI18nP7')),
          DocsCodeFigure(code: kI18nSamples['wiring']!.code, language: 'dart'),
        ],
      ),
    );
  }
}

/// Live EN / AR / DE switcher around a paginated, localised card.
class _LanguageSwitcherDemo extends StatefulWidget {
  const _LanguageSwitcherDemo();

  @override
  State<_LanguageSwitcherDemo> createState() => _LanguageSwitcherDemoState();
}

class _LanguageSwitcherDemoState extends State<_LanguageSwitcherDemo> {
  String _code = 'en';

  Locale get _locale => switch (_code) {
    'ar' => const Locale('ar'),
    'de' => const Locale('de'),
    _ => const Locale('en'),
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Wrap(
            spacing: 8,
            children: <Widget>[
              for (final String code in <String>['en', 'ar', 'de'])
                Button(
                  variant: code == _code
                      ? ButtonVariant.primary
                      : ButtonVariant.outline,
                  size: ButtonSize.sm,
                  onPressed: () => setState(() => _code = code),
                  child: Text(switch (code) {
                    'ar' => 'العربية',
                    'de' => 'Deutsch',
                    _ => 'English',
                  }),
                ),
            ],
          ),
          const SizedBox(height: 12),
          DashcnLocaleOverride(
            locale: _locale,
            child: Builder(
              builder: (BuildContext context) {
                final ComponentLocalizations strings =
                    ComponentLocalizations.of(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      strings.filterResultsCount(5),
                      style: theme.typography.small.copyWith(
                        color: theme.colors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const EmptyState(variant: EmptyStateVariant.noResults),
                    const SizedBox(height: 8),
                    Pagination(page: 2, totalPages: 20, onPageChanged: (_) {}),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Forced-Arabic card proving RTL mirroring end to end.
class _RtlExampleCard extends StatelessWidget {
  const _RtlExampleCard();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusLg,
      ),
      child: const DashcnLocaleOverride(
        locale: Locale('ar'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            EmptyState(variant: EmptyStateVariant.empty),
            SizedBox(height: 8),
            Pagination(page: 2, totalPages: 20, onPageChanged: _noopPage),
          ],
        ),
      ),
    );
  }
}

/// Pagination callback of the RTL example (stateless placeholder).
void _noopPage(int page) {}
