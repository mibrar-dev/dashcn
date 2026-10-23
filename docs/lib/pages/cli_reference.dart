// `/docs/cli` — the CLI reference (spec §2.6): a typeset page rendering each
// command section from `cli_snapshot.txt` inside code figures, plus generated
// flags tables. No card layout — prose + numbered headings + code figures per
// the spec's replacement of the old plan's "4 command cards".

import 'package:flutter/widgets.dart';

import '../generated/docs_tables.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_content_prose2.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/typeset.dart';
import '../widgets/typeset_tables.dart';

/// `/docs/cli` — the CLI reference.
class CliReferencePage extends StatelessWidget {
  /// Creates the CLI reference page.
  const CliReferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/cli');
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return DocsLayout(
      child: DocsArticle(
        title: docsContentPage(locale, 'pageCliTitle'),
        description: docsContentPage(locale, 'pageCliDesc'),
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          TypesetParagraph(docsProse2(locale, 'proseCliP1')),
          for (final DocsCliCommand command in kCliCommands) ...<Widget>[
            _CommandSection(command: command),
          ],
        ],
      ),
    );
  }
}

class _CommandSection extends StatelessWidget {
  const _CommandSection({required this.command});

  final DocsCliCommand command;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DocsSiteColors site = DocsSiteColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeadingAnchor(
            id: command.label.replaceAll(' ', '-'),
            title: command.label,
            level: 3,
          ),
          if (command.summary.isNotEmpty) TypesetParagraph(command.summary),
          const Gap(16),
          // Code figure with the help text.
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        LucideIcons.terminal,
                        size: 16,
                        color: theme.colors.foreground.withValues(alpha: 0.7),
                      ),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          command.helpText,
                          style: theme.typography.mono.copyWith(
                            fontSize: 13,
                            height: 20 / 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Flags table.
          if (command.flags.isNotEmpty) ...<Widget>[
            const Gap(16),
            TypesetFlagTable(
              flags: command.flags
                  .map(
                    (DocsCliFlag f) => (
                      name: f.name,
                      alias: f.alias,
                      description: f.description,
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
