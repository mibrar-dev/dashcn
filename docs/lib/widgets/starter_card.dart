// One starter card on the Starters index (P9-Z2): the title row, a
// phone-frame thumbnail of the starter's main shell composed from the
// starter's flows with docs demo data (no template rendering at runtime),
// flows/blocks chips, platforms and the create command.

import 'package:flutter/widgets.dart';

import '../flows/flow_screen_table.dart';
import '../generated/docs_starters.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'block_card.dart';
import 'copy_button.dart';
import 'docs_tokens.dart';

/// One starter card: title row, phone thumbnail and the create command.
class StarterCard extends StatelessWidget {
  /// Creates the card for [starter].
  const StarterCard({super.key, required this.starter});

  /// The starter to render.
  final DocsStarter starter;

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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Badge(
                          variant: BadgeVariant.secondary,
                          child: Text('${starter.flows.length} flows'),
                        ),
                        Badge(
                          variant: BadgeVariant.outline,
                          child: Text(
                            starter.blocks.isEmpty
                                ? 'no blocks'
                                : '${starter.blocks.length} blocks',
                          ),
                        ),
                        CopyButton(text: starter.install, showLabel: true),
                      ],
                    ),
                    const Gap(12),
                    Text(
                      starter.name,
                      style: docsText(
                        context,
                        size: 16,
                        weight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      starter.description,
                      style: docsText(
                        context,
                        size: 13,
                        height: 1.4,
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                    const Gap(8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: <Widget>[
                        for (final String flow in starter.flows)
                          Badge(
                            variant: BadgeVariant.outline,
                            child: Text(flow),
                          ),
                        for (final String block in starter.blocks)
                          Badge(
                            variant: BadgeVariant.outline,
                            child: Text(block),
                          ),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      '${starter.platforms.length} platforms · '
                      'theme ${starter.themePreset}',
                      style: docsText(
                        context,
                        size: 12,
                        height: 1.4,
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: StarterThumb(starter: starter),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    BlockCommandChip(command: starter.install),
                    Button(
                      variant: ButtonVariant.outline,
                      size: ButtonSize.sm,
                      leading: const Icon(LucideIcons.externalLink, size: 14),
                      onPressed: () => DocsRouterScope.of(
                        context,
                      ).go(context, '/docs/starters/${starter.id}'),
                      child: const Text('Open starter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A phone-frame thumbnail of the starter's main shell.
///
/// Composed from the starter's flows with docs demo data (never the
/// `.tmpl` templates): saas shows onboarding, chat shows threads, shop shows
/// the cart. Falls back to the first flow's first screen.
class StarterThumb extends StatelessWidget {
  /// Creates a thumbnail for [starter].
  const StarterThumb({super.key, required this.starter});

  /// The starter to preview.
  final DocsStarter starter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FlowScreenEntry screen = _representativeScreen(starter);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusLg,
      ),
      child: ClipRRect(
        borderRadius: theme.borderRadiusLg,
        child: SizedBox(
          width: 180,
          height: 240,
          child: FittedBox(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            child: SizedBox(width: 390, height: 520, child: screen.thumbnail()),
          ),
        ),
      ),
    );
  }
}

/// The representative screen for [starter]'s thumbnail.
FlowScreenEntry _representativeScreen(DocsStarter starter) {
  final String flowId = switch (starter.id) {
    'saas' => 'onboarding-01',
    'chat' => 'chat-01',
    'shop' => 'checkout-01',
    _ => starter.flows.isNotEmpty ? starter.flows.first : 'auth-01',
  };
  final List<FlowScreenEntry> screens = flowScreens(flowId);
  return screens.first;
}
