// The component page template (spec §2.4, P7-D1 upstream docs layout): one
// route for all 118 components.
//
// Title row + typeset description, the main demo card (the first named
// example, inside the P9-1 device frame), an install block, Usage (snippets),
// Examples (every remaining example as `### <Name>` + its own Preview |
// Code card), API Reference, Theme, and Accessibility (keyboard rows, hidden
// when empty). Prev/next pager at the bottom. Every fact comes from the
// generated data.
//
// Trust scorecards open from a top button in a dialog (desktop) or sheet
// (phone) instead of an inline list. The Playground opens as a right-side
// panel (Figma-like): the sidebar stays put while the content area shows
// the panel on the right.
//
// The example cards live in `widgets/example_preview_card.dart` (P7-D1: one
// card per named example instead of P6-F4's single preview + Select).

import 'package:flutter/widgets.dart';

import '../generated/docs_api.dart';
import '../generated/docs_controls.dart';
import '../generated/docs_data.dart';
import '../generated/docs_tables.dart';
import '../playground/builders.dart';
import '../playground/ui/playground_panel.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_state.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/dialog/dialog.dart' as dashcn_dialog;
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/component_examples_section.dart';
import '../widgets/component_install_block.dart';
import '../widgets/component_preview_card.dart';
import '../widgets/component_sections.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/scorecard/scorecard_card.dart';

/// `/docs/components/<id>` — the component template.
class ComponentPage extends StatefulWidget {
  /// Creates the page for [componentId].
  const ComponentPage({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  State<ComponentPage> createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  bool _playgroundOpen = false;

  void _openScorecards() {
    final double width = MediaQuery.sizeOf(context).width;
    final Widget card = ScorecardCard(componentId: widget.componentId);
    if (width < 640) {
      // Phone: bottom sheet.
      dashcn_dialog.showDialog<void>(
        context: context,
        alignment: Alignment.bottomCenter,
        builder: (BuildContext context) {
          final ThemeData theme = Theme.of(context);
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.9,
              maxWidth: 640,
            ),
            decoration: BoxDecoration(
              color: theme.colors.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border.all(color: theme.colors.border),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      Button(
                        variant: ButtonVariant.ghost,
                        size: ButtonSize.sm,
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                  card,
                ],
              ),
            ),
          );
        },
      );
      return;
    }
    // Desktop: centred dialog.
    dashcn_dialog.showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final ThemeData theme = Theme.of(context);
        return Container(
          constraints: const BoxConstraints(maxWidth: 640, maxHeight: 640),
          decoration: BoxDecoration(
            color: theme.colors.background,
            borderRadius: theme.borderRadiusLg,
            border: Border.all(color: theme.colors.border),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Spacer(),
                    Button(
                      variant: ButtonVariant.ghost,
                      size: ButtonSize.sm,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
                card,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DocsComponent component = kComponents.firstWhere(
      (DocsComponent c) => c.id == widget.componentId,
    );
    final ({String? previousId, String? nextId}) neighbors = componentNeighbors(
      widget.componentId,
    );
    final bool hasPlayground =
        kControlSpecs.containsKey(widget.componentId) &&
        kPlaygroundBuilders.containsKey(widget.componentId);
    final Widget article = DocsArticle(
      hideToc: _playgroundOpen && hasPlayground,
      title: component.name,
      description: component.description,
      previous: neighbors.previousId != null
          ? DocsNavLink(
              label: kComponentLinks
                  .firstWhere(
                    (DocsComponentLink l) => l.id == neighbors.previousId,
                  )
                  .name,
              location: '/docs/components/${neighbors.previousId}',
            )
          : null,
      next: neighbors.nextId != null
          ? DocsNavLink(
              label: kComponentLinks
                  .firstWhere((DocsComponentLink l) => l.id == neighbors.nextId)
                  .name,
              location: '/docs/components/${neighbors.nextId}',
            )
          : null,
      titleActions: <Widget>[
        Badge(
          variant: BadgeVariant.secondary,
          child: Text(fileCountLabel(component.fileCount)),
        ),
        Badge(variant: BadgeVariant.outline, child: Text(component.stability)),
        if (_isWip(component.id)) ...<Widget>[
          Badge(variant: BadgeVariant.outline, child: Text('WIP')),
          _WipNote(),
        ],
      ],
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              Button(
                key: const ValueKey<String>('trust-scorecards-open'),
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: _openScorecards,
                child: const Text('Trust scorecards'),
              ),
              if (hasPlayground)
                Button(
                  key: const ValueKey<String>('playground-open'),
                  variant: ButtonVariant.secondary,
                  size: ButtonSize.sm,
                  onPressed: () => setState(() => _playgroundOpen = true),
                  child: const Text('Playground'),
                ),
            ],
          ),
        ),
        ComponentPreviewCard(componentId: widget.componentId),
        ComponentInstallBlock(componentId: widget.componentId),
        ComponentUsageSection(componentId: widget.componentId),
        ComponentExamplesSection(componentId: widget.componentId),
        ComponentApiSection(componentId: widget.componentId),
        if (_hasMembers(widget.componentId))
          ComponentMembersSection(componentId: widget.componentId),
        if (_hasThemeTable(widget.componentId))
          ComponentThemeSection(componentId: widget.componentId),
        if (_hasKeyboardRows(widget.componentId))
          ComponentAccessibilitySection(componentId: widget.componentId),
      ],
    );
    if (!_playgroundOpen || !hasPlayground) {
      return DocsLayout(child: article);
    }
    // Figma-like: sidebar stays put (DocsLayout), content area shows the
    // article on the left and the playground panel docked on the right.
    // Narrow screens show the panel as a full-width overlay so the Row
    // never overflows a 375 px phone.
    final DocsState state = DocsRouterScope.of(context).state;
    final double contentWidth = MediaQuery.sizeOf(context).width;
    final Widget panel = Container(
      width: contentWidth >= 1024 ? 380 : double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Theme.of(context).colors.border),
        ),
        color: Theme.of(context).colors.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Playground',
                    style: docsText(context, size: 14, weight: FontWeight.w600),
                  ),
                ),
                Gap(Theme.of(context).spacing.xs),
                Button(
                  key: const ValueKey<String>('playground-close'),
                  variant: ButtonVariant.ghost,
                  size: ButtonSize.sm,
                  onPressed: () => setState(() => _playgroundOpen = false),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ListenableBuilder(
                listenable: state,
                builder: (BuildContext context, Widget? _) => PlaygroundPanel(
                  componentId: widget.componentId,
                  initialQuery: state.playgroundQuery,
                  onQueryChanged: state.setPlaygroundQuery,
                  reportUrl: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    if (contentWidth < 1024) {
      return DocsLayout(
        child: Stack(
          children: <Widget>[
            article,
            Positioned.fill(child: panel),
          ],
        ),
      );
    }
    return DocsLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: article),
          panel,
        ],
      ),
    );
  }

  static bool _hasMembers(String id) {
    return kApiTables[id]!.members.isNotEmpty;
  }

  /// Audio/video players are still being polished.
  static bool _isWip(String id) {
    return id == 'audio_player' || id == 'video_player';
  }

  static bool _hasThemeTable(String id) {
    final DocsThemeTable table = kThemeTables[id]!;
    return table.hasTheme && table.fields.isNotEmpty;
  }

  static bool _hasKeyboardRows(String id) {
    return (kKeyboardRows[id] ?? const <DocsKeyboardRow>[]).isNotEmpty;
  }
}

/// WIP note beside the badge: density-capped and truncating so the title
/// row fits at 375 and 1280.
///
/// The badge Wrap measures its children with the Row's remaining width once
/// `docs_article` gives it a Flexible bound; without a cap this note's
/// intrinsic width (~396) forces the Row past 640 by ~300. Capping at 12x
/// the content-padding base (192 at the default density, scaled) and
/// ellipsizing keeps it to one line in both branches.
class _WipNote extends StatelessWidget {
  /// Creates the note.
  const _WipNote();

  @override
  Widget build(BuildContext context) {
    final double densityBase =
        Theme.of(context).density.baseContentPadding *
        Theme.of(context).scaling;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: densityBase * 12),
      child: Text(
        'Work in progress: bugs may occur.',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: docsText(
          context,
          size: 12,
          color: Theme.of(context).colors.mutedForeground,
        ),
      ),
    );
  }
}
