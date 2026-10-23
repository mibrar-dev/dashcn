// The per-screen code view of a flow page (P9-3b): one section per file of
// the screen, each with its install-root-relative path and its highlighted,
// selectable source.
//
// Sources come from the generated `kFlowFileSources` (verbatim registry
// source + 4-class highlight map), never from a hand-copied copy.

import 'package:flutter/widgets.dart';

import '../flows/flow_sources.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import 'code_spans.dart';
import 'docs_tokens.dart';
import 'heading_anchor.dart';
import 'selectable_code.dart';

/// Code per screen: the [files] of one screen, verbatim.
class FlowCodePanel extends StatelessWidget {
  /// Creates the panel for [flowId]'s screen showing [files].
  const FlowCodePanel({
    super.key,
    required this.flowId,
    required this.screenName,
    required this.files,
  });

  /// The flow id (`auth-01`).
  final String flowId;

  /// The screen name (`Sign in`).
  final String screenName;

  /// Registry-relative basenames (`screens/sign_in_screen.dart`).
  final List<String> files;

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final List<DocsFlowFile> sources =
        kFlowFileSources[flowId] ?? const <DocsFlowFile>[];
    final List<DocsFlowFile> shown = <DocsFlowFile>[
      for (final String name in files)
        ...sources.where(
          (DocsFlowFile file) =>
              file.path.endsWith('/$name') || file.path.endsWith(name),
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        HeadingAnchor(
          id: 'code-$screenName',
          title: "${docsContentPage(locale, 'pageCode')} — $screenName",
        ),
        const Gap(16),
        if (shown.isEmpty)
          Text(
            'No sources listed for this screen.',
            style: docsText(
              context,
              size: 13,
              color: Theme.of(context).colors.mutedForeground,
            ),
          )
        else
          for (final DocsFlowFile file in shown) ...<Widget>[
            _FileSection(file: file),
            const Gap(16),
          ],
      ],
    );
  }
}

/// One file: its path row plus its highlighted source.
class _FileSection extends StatelessWidget {
  const _FileSection({required this.file});

  final DocsFlowFile file;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DocsSiteColors site = DocsSiteColors.of(context);
    final bool dark = site.codeSurface == const Color(0xFF161616);
    final TextStyle base = theme.typography.mono.copyWith(
      fontSize: 13,
      height: 20 / 13,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SelectableCode(
          child: Text(
            file.path,
            style: theme.typography.mono.copyWith(
              fontSize: 12.5,
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
        const Gap(8),
        Container(
          decoration: BoxDecoration(
            color: site.codeSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.colors.border.withValues(alpha: 0.3),
            ),
          ),
          constraints: const BoxConstraints(maxHeight: 420),
          child: ScrollConfiguration(
            behavior: const DocsScrollBehavior(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SelectableCode(
                child: Text.rich(
                  TextSpan(
                    children: codeSpans(
                      code: file.code,
                      tokenClasses: file.tokenClasses,
                      plain: base.copyWith(
                        color: dark
                            ? const Color(0xFFE5E5E5)
                            : const Color(0xFF262626),
                      ),
                      comment: base.copyWith(color: site.codeNumber),
                      keyword: base.copyWith(color: const Color(0xFF79C0FF)),
                      string: base.copyWith(color: const Color(0xFFA5D6FF)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
