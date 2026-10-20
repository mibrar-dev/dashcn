// One chart family section of the charts gallery: a heading plus a responsive
// card grid (3 columns on desktop, 2 on tablet, 1 on phone).
//
// Each card shows the example title, a one-line description, the live chart
// and two actions: Copy (copies the example code) and View code (opens the
// code in a dialog with its own copy button). Live previews and code come
// from the existing `chart` preview and example-source data.

import 'package:flutter/widgets.dart';

import '../generated/docs_example_sources.dart';
import '../generated/docs_previews.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/dialog/dialog.dart';
import '../ui/dashcn/components/divider/divider.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/component_preview_card.dart' show PreviewExampleLoader;
import '../widgets/copy_button.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/example_preview_card.dart' show ExampleSnippetCode;
import '../widgets/preview_stage.dart';
import '../widgets/selectable_code.dart';
import 'charts_blurbs.dart';
import 'charts_data.dart';

/// Minimum stage height of a gallery card (room for axes + labels).
const double kChartGalleryStageHeight = 240;

/// Gap between gallery cards.
const double kChartGalleryGap = 16;

/// One family section: heading + responsive example grid.
class ChartFamilySection extends StatelessWidget {
  /// Creates the section for [family].
  const ChartFamilySection({super.key, required this.family});

  /// The family to render.
  final ChartFamily family;

  @override
  Widget build(BuildContext context) {
    final List<String> names = kComponentPreviews['chart'] ?? const <String>[];
    final List<DocsExampleSource> sources =
        kExampleSources['chart'] ?? const <DocsExampleSource>[];
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          family.title,
          style: docsText(
            context,
            size: 20,
            weight: FontWeight.w600,
            height: 28 / 20,
            letterSpacing: -0.4,
          ),
        ),
        Gap(theme.spacing.xs),
        Text(
          family.description,
          style: docsText(
            context,
            size: 14,
            height: 1.5,
            color: theme.colors.mutedForeground,
          ),
        ),
        Gap(theme.spacing.md),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double maxWidth = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : 1024;
            final int columns = maxWidth >= 1024
                ? 3
                : maxWidth >= 640
                ? 2
                : 1;
            final double tileWidth =
                (maxWidth - kChartGalleryGap * (columns - 1)) / columns;
            return Wrap(
              spacing: kChartGalleryGap,
              runSpacing: kChartGalleryGap,
              children: <Widget>[
                for (final String name in family.examples)
                  SizedBox(
                    width: tileWidth,
                    child: _exampleCard(name, names, sources),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _exampleCard(
    String name,
    List<String> names,
    List<DocsExampleSource> sources,
  ) {
    final int index = names.indexOf(name);
    if (index < 0 || index >= sources.length) {
      return const SizedBox.shrink();
    }
    return ChartExampleCard(
      key: ValueKey<String>('chart-example-$name'),
      name: name,
      exampleIndex: index,
      source: sources[index],
    );
  }
}

/// One gallery card: title + actions, description, live chart.
class ChartExampleCard extends StatelessWidget {
  /// Creates the card for one named example.
  const ChartExampleCard({
    super.key,
    required this.name,
    required this.exampleIndex,
    required this.source,
  });

  /// Example title (`Area Chart - Stacked`).
  final String name;

  /// Index into the `chart` preview list.
  final int exampleIndex;

  /// Generated display source (code for copy + dialog).
  final DocsExampleSource source;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        borderRadius: theme.borderRadiusXl,
        border: Border.all(color: theme.colors.border),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: theme.borderRadiusXl,
        ),
        child: ClipRRect(
          borderRadius: theme.borderRadiusXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: docsText(
                              context,
                              size: 14,
                              weight: FontWeight.w600,
                              height: 20 / 14,
                            ),
                          ),
                        ),
                        Gap(theme.spacing.xs),
                        CopyButton(
                          key: ValueKey<String>(
                            'chart-example-copy-$exampleIndex',
                          ),
                          text: source.code,
                        ),
                        Gap(theme.spacing.xs),
                        Button(
                          key: ValueKey<String>(
                            'chart-example-view-code-$exampleIndex',
                          ),
                          variant: ButtonVariant.ghost,
                          size: ButtonSize.sm,
                          onPressed: () => showChartCodeDialog(
                            context,
                            title: name,
                            code: source.code,
                          ),
                          child: const Text('View code'),
                        ),
                      ],
                    ),
                    Gap(theme.spacing.xs),
                    Text(
                      chartExampleBlurb(name),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: docsText(
                        context,
                        size: 13,
                        height: 1.4,
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              PreviewStage(
                minHeight: kChartGalleryStageHeight,
                child: PreviewExampleLoader(
                  componentId: 'chart',
                  exampleIndex: exampleIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens the example code dialog: title, copy + close, highlighted code.
Future<void> showChartCodeDialog(
  BuildContext context, {
  required String title,
  required String code,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final ThemeData theme = Theme.of(context);
      return ConstrainedBox(
        key: const ValueKey<String>('chart-code-dialog'),
        constraints: const BoxConstraints(maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.h4,
                    ),
                  ),
                  Gap(theme.spacing.sm),
                  CopyButton(
                    text: code,
                    variant: ButtonVariant.outline,
                    size: ButtonSize.sm,
                    showLabel: true,
                    label: 'Copy',
                  ),
                  Gap(theme.spacing.xs),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(LucideIcons.x, size: 14),
                  ),
                ],
              ),
              Gap(theme.spacing.md),
              SizedBox(
                width: 640,
                height: 420,
                child: ClipRRect(
                  borderRadius: theme.borderRadiusLg,
                  child: SingleChildScrollView(
                    child: SelectableCode(
                      child: ExampleSnippetCode(code: code),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
