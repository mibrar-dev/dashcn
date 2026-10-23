// `/docs/internationalization` — translating the kit: the locale table,
// the language switcher, RTL mirroring and the offline `locale` command.

import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
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
    return DocsLayout(
      child: DocsArticle(
        title: 'Internationalization',
        description:
            'Every user-facing string reads a locale table, with RTL '
            'mirroring and an offline locale installer.',
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          const TypesetParagraph(
            'Every user-facing string in the kit — buttons, placeholders, '
            'aria and semantics labels, pagination, calendar, dialogs, '
            'toasts, empty states, error messages, filter bar, command and '
            'the date and time pickers — comes from a locale table. '
            'DashcnLocalizations.of(context) reads the ambient locale and '
            'falls back to English when no delegate was installed, so '
            'untranslated screens keep working.',
          ),
          const TypesetParagraph(
            'Sixteen locales are complete for every key: ar, he, fa and ur '
            '(right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, '
            'zh-Hans and hi. Each translation file is separate and small; '
            'pt-BR subclasses the pt table and zh-Hans pins the Hans script '
            'subtag, so regional variants resolve without duplicating '
            'strings. No new third-party packages were added: the kit stays '
            'widgets-only on top of Flutter’s flutter_localizations and '
            'intl hooks.',
          ),
          const HeadingAnchor(id: 'switcher', title: 'Language Switcher'),
          const TypesetParagraph(
            'Flip between English, Arabic and German. The pagination labels, '
            'the empty-state copy and the chevrons re-string in place; '
            'Arabic also flips the reading direction.',
          ),
          const _LanguageSwitcherDemo(),
          const HeadingAnchor(id: 'rtl', title: 'RTL Example'),
          const TypesetParagraph(
            'A locale implies its text direction: the kit reads Directionality '
            'from the locale, mirrors chevrons, back arrows and next/previous '
            'controls, and keeps numbers and code left-to-right inside '
            'DashcnLtr. The card below is forced Arabic:',
          ),
          const _RtlExampleCard(),
          DocsCodeFigure(
            code: kI18nSamples['rtl-override']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(
            id: 'per-instance',
            title: 'Per-Instance Override',
          ),
          const TypesetParagraph(
            'Wrap one subtree to preview or ship a single translated surface '
            'without changing the app locale. Missing tables fall back to '
            'English, exactly like the ambient lookup.',
          ),
          DocsCodeFigure(
            code: kI18nSamples['per-instance']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(id: 'cli', title: 'Installing a Locale'),
          const TypesetParagraph(
            'The offline installer writes the locale wiring into your '
            'project: no pasting, no network. Each component records the '
            'strings it reads, including the strings of the components it '
            'depends on, so installing a component installs its translations '
            'too:',
          ),
          DocsCodeFigure(code: kI18nSamples['cli-add']!.code, language: 'sh'),
          const TypesetParagraph(
            'component installs the English base and the strings one '
            'component needs, for every locale the project already has. add '
            'installs a language for every component already in the project, '
            'and components added later receive it automatically. Running '
            'either command again changes nothing.',
          ),
          const TypesetParagraph(
            'Wire the generated file into DashcnApp once; every component '
            'below it re-strings. The public API is backward compatible: '
            'ComponentLocalizations is still the lookup, DashcnLocalizations '
            'is its alias.',
          ),
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
