// `/docs/scorecards` — "How we measure" (P9-5b): what each scorecard metric
// is, how it is produced, its limits, and the overview table of all
// components with their badges, sortable by failures.
//
// Every fact comes from `lib/generated/docs_scorecards.dart` (P9-5a harness
// output); nothing here is hand-typed.

import 'package:flutter/widgets.dart';

import '../generated/docs_data.dart';
import '../generated/docs_scorecards.dart';
import '../routing/docs_nav.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/code_figure.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/scorecard/scorecard_badge.dart';
import '../widgets/typeset.dart';

/// `/docs/scorecards` — how trust scorecards are measured.
class ScorecardsPage extends StatelessWidget {
  /// Creates the page.
  const ScorecardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/scorecards');
    return DocsLayout(
      child: DocsArticle(
        title: 'How we measure',
        description:
            'Trust scorecards are measured, reproducible quality facts — '
            'never hand-typed numbers.',
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          const TypesetParagraph(
            'Each component page shows a trust scorecard: accessibility, '
            'right-to-left, frame build time and tests. The numbers come from '
            'a generated harness run over the component previews; a missing '
            'measurement is shown as “Not measured”, never as a pass.',
          ),
          const HeadingAnchor(id: 'metrics', title: 'Metrics'),
          const TypesetParagraph(
            'Accessibility checks the preview with the framework guidelines: '
            'text contrast (4.5 minimum), labeled tap targets, Android tap '
            'targets (48 by 48) and iOS tap targets (44 by 44), plus whether '
            'any semantics label, value, hint or tooltip is present.',
          ),
          const TypesetParagraph(
            'Right-to-left pumps the preview under Right-to-left direction and '
            'checks that it renders with no exception or overflow. Mirroring '
            'compares the first Text x in Left-to-right versus Right-to-left: '
            'a shift means directional content, equal positions mean a '
            'symmetric layout, and no text means not applicable.',
          ),
          const TypesetParagraph(
            'Frame build time pumps 120 frames of 16 ms and reports the p50 '
            'and p90 build times in milliseconds. It is labelled “Frame build '
            'time — test environment (relative)”: relative numbers for '
            'comparing components, not device performance.',
          ),
          const TypesetParagraph(
            'Tests counts registry test cases tagged to the component (file '
            'prefix or folder under test/registry/components, plus tags '
            'component:<id>). Pass reflects the scorecard harness run at '
            'generation time, not the registry suite result.',
          ),
          const TypesetParagraph(
            'Exemptions: a check with a documented reason (a decorative '
            'divider excluded from semantics, a disabled row WCAG exempts '
            'from contrast, a sampling artefact) renders as “Exempt” with '
            'its reason and never counts as a failure.',
          ),
          const HeadingAnchor(id: 'how-produced', title: 'How it is produced'),
          const TypesetParagraph(
            'The kit generator runs a generated harness test with the JSON '
            'reporter, collects one SCORECARD record per component, counts '
            'tests with the analyzer, and writes '
            'lib/src/manifests/scorecards.json. The docs generator then emits '
            'lib/generated/docs_scorecards.dart from that manifest.',
          ),
          const DocsCodeFigure(
            code: 'dart run tool/gen_scorecards.dart',
            language: 'bash',
          ),
          const HeadingAnchor(id: 'limits', title: 'Limits'),
          const TypesetParagraph(
            'Test font: the harness pumps previews under the default theme '
            'fallback with the test font, so muted text near 4.35 to 4.43 '
            'contrast can fail the 4.5 threshold without failing on device '
            'fonts.',
          ),
          const TypesetParagraph(
            'Test environment timing: frame times are measured with a '
            'stopwatch around pumped frames in the test VM. They compare '
            'components relatively; they never predict device frame rates.',
          ),
          const TypesetParagraph(
            'Guideline thresholds: tap-target checks use the mobile '
            'tap-target guideline (44/48 px). They are informational for '
            'desktop-sized controls (36 px buttons and rows) and are never '
            'hidden when they fail.',
          ),
          const HeadingAnchor(id: 'overview', title: 'All components'),
          const TypesetParagraph(
            'Every measured component with its overall badge. Sort by '
            'failures to surface the components with the most failing checks.',
          ),
          const _ScorecardTable(),
        ],
      ),
    );
  }
}

/// Overview table of all scorecards, sortable by failures.
class _ScorecardTable extends StatefulWidget {
  /// Creates the table.
  const _ScorecardTable();

  @override
  State<_ScorecardTable> createState() => _ScorecardTableState();
}

class _ScorecardTableState extends State<_ScorecardTable> {
  bool _sortByFailures = false;

  List<String> get _ids {
    final List<String> ids = kScorecards.keys.toList();
    ids.sort((String a, String b) {
      if (_sortByFailures) {
        final int byFailures = kScorecards[b]!.failureCount.compareTo(
          kScorecards[a]!.failureCount,
        );
        if (byFailures != 0) {
          return byFailures;
        }
      }
      return a.compareTo(b);
    });
    return ids;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<String> ids = _ids;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Gap(16),
        Row(
          children: <Widget>[
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: () =>
                  setState(() => _sortByFailures = !_sortByFailures),
              child: Text(
                _sortByFailures ? 'Sorted by failures' : 'Sort by failures',
              ),
            ),
            const Gap(12),
            Expanded(
              child: Text(
                '${ids.length} components',
                style: docsText(
                  context,
                  size: 12,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final String id in ids)
                _ScorecardRow(
                  key: ValueKey<String>('scorecard-row-$id'),
                  componentId: id,
                ),
            ],
          ),
        ),
        const Gap(16),
        Text(
          _overviewFooter(),
          style: docsText(
            context,
            size: 12,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }

  static String _overviewFooter() {
    final String date = kScorecardsGeneratedAt.length >= 10
        ? kScorecardsGeneratedAt.substring(0, 10)
        : kScorecardsGeneratedAt;
    return 'measured on $date at $kScorecardsCommitShort · '
        '$kScorecardsFlutter';
  }
}

/// One overview row: component name, failures, tests and overall badge.
class _ScorecardRow extends StatelessWidget {
  /// Creates the row.
  const _ScorecardRow({super.key, required this.componentId});

  /// Registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final DocsScorecard? scorecard = kScorecards[componentId];
    final int failures = scorecard?.failureCount ?? 0;
    final int exempt = scorecard?.exemptCount ?? 0;
    final int tests = scorecard?.tests.count ?? 0;
    final bool? passed = scorecard == null
        ? null
        : (failures == 0 ? true : false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              _displayName(componentId),
              style: docsText(context, size: 14),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              exempt > 0
                  ? '$failures ${failures == 1 ? 'failure' : 'failures'} · '
                        '$exempt exempt'
                  : '$failures ${failures == 1 ? 'failure' : 'failures'}',
              style: docsText(context, size: 14),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              '$tests ${tests == 1 ? 'test' : 'tests'}',
              style: docsText(context, size: 14),
            ),
          ),
          ScoreStatusBadge(passed: passed),
        ],
      ),
    );
  }

  static String _displayName(String id) {
    for (final DocsComponent component in kComponents) {
      if (component.id == id) {
        return component.name;
      }
    }
    return id;
  }
}
