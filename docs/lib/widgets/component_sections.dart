// The content sections for component pages (spec §2.4): Usage (README
// snippets), API Reference (constructor/function params), Theme (theme
// fields), and Accessibility (keyboard rows, hidden when empty). Every fact
// comes from the generated data.

import 'package:flutter/widgets.dart';

import '../generated/docs_api.dart';
import '../routing/docs_router.dart';
import '../state/docs_strings.dart';
import '../generated/docs_snippets.dart';
import '../generated/docs_tables.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import 'copy_button.dart';
import 'docs_tokens.dart';
import 'heading_anchor.dart';
import 'selectable_code.dart';
import 'typeset.dart';
import 'typeset_tables.dart';

/// The Usage section: install, minimal example and key parameters.
///
/// Shows the important information first (what to install, the minimal
/// example, the key parameters) with the code in a compact snippet below,
/// not a wall of code. Code is syntax-coloured with a copy button.
class ComponentUsageSection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentUsageSection({super.key, required this.componentId});

  final String componentId;

  @override
  Widget build(BuildContext context) {
    final List<DocsSnippet> snippets =
        kDocsSnippets[componentId] ?? const <DocsSnippet>[];
    final DocsApiTable? api = kApiTables[componentId];
    final List<DocsApiParam> params = api?.params ?? const <DocsApiParam>[];
    final List<DocsApiParam> keyParams = params.take(5).toList(growable: false);
    final locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    // Translated usage blurb (`Install with {command}, then …`): split on
    // the placeholder so the command keeps its code style in every locale.
    final List<String> blurbParts = docsChrome(
      locale,
      'cmpUsageBlurb',
    ).split('{command}');
    final String blurbPrefix = blurbParts.isNotEmpty ? blurbParts[0] : '';
    final String blurbSuffix = blurbParts.length > 1
        ? blurbParts.sublist(1).join('{command}')
        : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(id: 'usage', title: docsChrome(locale, 'cmpUsage')),
        TypesetParagraph.rich(<InlineSpan>[
          TextSpan(text: blurbPrefix),
          typesetInlineCodeSpan('dashcn add $componentId'),
          TextSpan(text: blurbSuffix),
        ]),
        if (snippets.isNotEmpty) _CompactSnippet(snippet: snippets.first),
        if (keyParams.isNotEmpty) ...<Widget>[
          Gap(Theme.of(context).spacing.md),
          Text(
            docsChrome(locale, 'cmpKeyParams'),
            style: docsText(context, size: 14, weight: FontWeight.w600),
          ),
          Gap(Theme.of(context).spacing.xs),
          for (final DocsApiParam param in keyParams)
            Padding(
              padding: EdgeInsets.only(bottom: Theme.of(context).spacing.xs),
              child: TypesetParagraph.rich(<InlineSpan>[
                TextSpan(
                  text: '${param.name}: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: param.type.isEmpty ? 'required' : param.type),
                if (param.doc != null && param.doc!.isNotEmpty)
                  TextSpan(text: ' — ${param.doc}'),
              ]),
            ),
        ],
        if (snippets.length > 1)
          Padding(
            padding: EdgeInsets.only(top: Theme.of(context).spacing.md),
            child: Text(
              docsFill(
                docsChrome(locale, 'cmpMore'),
                count: snippets.length - 1,
              ),
              style: docsText(
                context,
                size: 13,
                color: Theme.of(context).colors.mutedForeground,
              ),
            ),
          ),
      ],
    );
  }
}

/// Compact syntax-coloured snippet with a copy button.
class _CompactSnippet extends StatelessWidget {
  const _CompactSnippet({required this.snippet});

  final DocsSnippet snippet;

  @override
  Widget build(BuildContext context) {
    final DocsSiteColors site = DocsSiteColors.of(context);
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: theme.spacing.lg),
      child: Container(
        decoration: BoxDecoration(
          color: site.codeSurface,
          borderRadius: theme.borderRadiusLg,
          border: Border.all(color: theme.colors.border.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.md,
                vertical: theme.spacing.xs,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colors.border.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      snippet.language.isEmpty ? 'dart' : snippet.language,
                      style: docsText(
                        context,
                        size: 11,
                        color: site.codeNumber,
                      ),
                    ),
                  ),
                  CopyButton(
                    text: snippet.code,
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(theme.spacing.md),
              constraints: const BoxConstraints(maxHeight: 320),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableCode(
                    child: Text.rich(
                      TextSpan(
                        children: snippet.spans(
                          plain: theme.typography.mono.copyWith(
                            fontSize: 13,
                            height: 22 / 13,
                            color: theme.colors.foreground,
                          ),
                          comment: theme.typography.mono.copyWith(
                            fontSize: 13,
                            height: 22 / 13,
                            color: site.codeNumber,
                          ),
                          keyword: theme.typography.mono.copyWith(
                            fontSize: 13,
                            height: 22 / 13,
                            color: theme.syntaxColors.keyword,
                          ),
                          string: theme.typography.mono.copyWith(
                            fontSize: 13,
                            height: 22 / 13,
                            color: theme.syntaxColors.string,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The API Reference section: constructor/function params as a typeset table.
class ComponentApiSection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentApiSection({super.key, required this.componentId});

  final String componentId;

  @override
  Widget build(BuildContext context) {
    final DocsApiTable table = kApiTables[componentId]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(
          id: 'api-reference',
          title: docsChrome(
            DocsRouterScope.maybeOf(context)?.state.locale ??
                const Locale('en'),
            'cmpApi',
          ),
        ),
        if (table.hasApiTable) ...<Widget>[
          if (table.summary != null) TypesetParagraph(table.summary!),
          const Gap(16),
          TypesetTable(
            headers: <String>[
              docsChrome(
                DocsRouterScope.maybeOf(context)?.state.locale ??
                    const Locale('en'),
                'thParam',
              ),
              docsChrome(
                DocsRouterScope.maybeOf(context)?.state.locale ??
                    const Locale('en'),
                'thType',
              ),
              docsChrome(
                DocsRouterScope.maybeOf(context)?.state.locale ??
                    const Locale('en'),
                'thDefault',
              ),
              docsChrome(
                DocsRouterScope.maybeOf(context)?.state.locale ??
                    const Locale('en'),
                'thDesc',
              ),
            ],
            rows: <TypesetRow>[
              for (final DocsApiParam param in table.params)
                TypesetRow(<TypesetCell>[
                  TypesetCell(text: param.name, mono: true),
                  TypesetCell(text: param.type, mono: true),
                  TypesetCell(text: param.defaultValue ?? '—'),
                  TypesetCell(text: param.doc ?? ''),
                ]),
            ],
          ),
        ] else
          TypesetParagraph(
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'cmpNoApi',
            ),
          ),
      ],
    );
  }
}

/// The Members section: the declared static methods, factories, constants and
/// functions of a static/factory-first component.
///
/// The rows come from the generated `table.members` list (the codegen reads the
/// manifest's `api.methods` / `api.constants` / `api.functions` entries), so
/// components like `formatter`, `anchor`, `overlay_configuration` and `color`
/// show their real entry points instead of an empty parameter table.
class ComponentMembersSection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentMembersSection({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final DocsApiTable table = kApiTables[componentId]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(
          id: 'members',
          title: docsChrome(
            DocsRouterScope.maybeOf(context)?.state.locale ??
                const Locale('en'),
            'cmpMembers',
          ),
        ),
        TypesetParagraph(
          '${table.members.length} declared '
          '${table.members.length == 1 ? 'entry point' : 'entry points'} on '
          '${table.symbol}.',
        ),
        const Gap(16),
        TypesetTable(
          headers: <String>[
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thMember',
            ),
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thKind',
            ),
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thParams',
            ),
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thDesc',
            ),
          ],
          rows: <TypesetRow>[
            for (final DocsApiMember member in table.members)
              TypesetRow(<TypesetCell>[
                TypesetCell(text: member.name, mono: true),
                TypesetCell(text: _kindLabel(member)),
                TypesetCell(
                  text: member.params.isEmpty
                      ? '—'
                      : member.params
                            .map(
                              (DocsApiParam param) =>
                                  '${param.name}${param.isRequired ? '' : '?'}',
                            )
                            .join(', '),
                  mono: true,
                ),
                TypesetCell(text: member.doc ?? ''),
              ]),
          ],
        ),
      ],
    );
  }

  static String _kindLabel(DocsApiMember member) {
    final String kind = member.kind;
    return member.isStatic && kind != 'constructor' ? 'static $kind' : kind;
  }
}

/// The Theme section: theme fields as a typeset table.
class ComponentThemeSection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentThemeSection({super.key, required this.componentId});

  final String componentId;

  @override
  Widget build(BuildContext context) {
    final DocsThemeTable table = kThemeTables[componentId]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(
          id: 'theme',
          title: docsChrome(
            DocsRouterScope.maybeOf(context)?.state.locale ??
                const Locale('en'),
            'cmpTheme',
          ),
        ),
        TypesetParagraph(
          'The ${table.themeClass} fields resolved by the theme layer. '
          'User-owned ${table.userFile} is never overwritten by CLI updates.',
        ),
        const Gap(16),
        TypesetTable(
          headers: <String>[
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thField',
            ),
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thType',
            ),
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thDesc',
            ),
          ],
          rows: <TypesetRow>[
            for (final DocsThemeField field in table.fields)
              TypesetRow(<TypesetCell>[
                TypesetCell(text: field.name, mono: true),
                TypesetCell(text: field.type, mono: true),
                TypesetCell(text: field.description),
              ]),
          ],
        ),
      ],
    );
  }
}

/// The Accessibility section: keyboard rows as a typeset table.
class ComponentAccessibilitySection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentAccessibilitySection({super.key, required this.componentId});

  final String componentId;

  @override
  Widget build(BuildContext context) {
    final List<DocsKeyboardRow> rows = kKeyboardRows[componentId]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(
          id: 'accessibility',
          title: docsChrome(
            DocsRouterScope.maybeOf(context)?.state.locale ??
                const Locale('en'),
            'cmpA11y',
          ),
        ),
        const Gap(16),
        TypesetTable(
          headers: <String>[
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thKey',
            ),
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'thAction',
            ),
          ],
          rows: <TypesetRow>[
            for (final DocsKeyboardRow row in rows)
              TypesetRow(<TypesetCell>[
                TypesetCell(text: row.keys, mono: true),
                TypesetCell(text: row.action),
              ]),
          ],
        ),
      ],
    );
  }
}
