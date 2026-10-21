// The Flows pages (P9-3b), loaded as one deferred library so the flow
// catalog, the flow sources and the flow widgets stay out of the landing
// route's chunk.
//
// `/docs/flows` — the index: hero and one [FlowCard] per flow.
// `/docs/flows/<id>` — one flow inside the P9-1 iPhone frame (the frame bar
// switches device / All / light-dark / rotate), a screen-map strip (tap
// jumps the live flow via `initialScreen`), install tabs and code per
// screen from the generated mirror sources.

import 'package:flutter/widgets.dart';

import '../flows/flow_demo_data.dart';
import '../flows/flow_screen_table.dart';
import '../generated/docs_flows.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/theme/density_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/announcement.dart';
import '../widgets/block_card.dart';
import '../widgets/copy_button.dart';
import '../widgets/device_frame/device_spec.dart';
import '../widgets/device_frame/framed_preview.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/flow_code_panel.dart';
import '../widgets/flow_install_block.dart';

/// Outer padding + max width of the flows section (mirrors Blocks).
const double kFlowsMaxWidth = 1400;

/// `/docs/flows` — the flows index.
class FlowsIndexPage extends StatelessWidget {
  /// Creates the index page.
  const FlowsIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _FlowsHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kFlowsMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (final DocsFlow flow in kFlows) ...<Widget>[
                      FlowCard(key: ValueKey<String>(flow.id), flow: flow),
                      const Gap(24),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowsHero extends StatelessWidget {
  const _FlowsHero();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final bool wide = width >= 1024;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, wide ? 64 : 32, 24, 32),
      child: Column(
        children: <Widget>[
          Announcement(
            label: '${kFlows.length} flows ready to install',
            onPressed: () =>
                DocsRouterScope.of(context).go(context, '/docs/components'),
          ),
          Gap(wide ? 16 : 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 896),
            child: Text(
              'Flows that feel like apps',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: wide ? 40 : 30,
                weight: FontWeight.w600,
                height: 1.15,
                letterSpacing: wide ? -1 : 0,
                color: theme.colors.foreground,
              ),
            ),
          ),
          const Gap(12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Installable, navigable mini-apps — mobile-first — built from '
              'the kit components. Run one live below, then take it home '
              'with a single command.',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: width >= 640 ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const Gap(20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              Button(
                variant: ButtonVariant.primary,
                size: ButtonSize.md,
                onPressed: () =>
                    DocsRouterScope.of(context).go(context, '/docs/components'),
                child: const Text('View Components'),
              ),
              Button(
                variant: ButtonVariant.secondary,
                size: ButtonSize.md,
                leading: const Icon(LucideIcons.terminal, size: 16),
                onPressed: () =>
                    DocsRouterScope.of(context).go(context, '/docs/cli'),
                child: const Text('CLI reference'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// One flow card: title row, the live first screen in a phone thumbnail,
/// and the install command.
class FlowCard extends StatelessWidget {
  /// Creates the card for [flow].
  const FlowCard({super.key, required this.flow});

  /// The flow to render.
  final DocsFlow flow;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<FlowScreenEntry> screens = flowScreens(flow.id);
    final FlowScreenEntry first = screens.first;
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
                    Row(
                      children: <Widget>[
                        Badge(
                          variant: BadgeVariant.secondary,
                          child: Text('${flow.screens.length} screens'),
                        ),
                        const Gap(8),
                        Badge(
                          variant: BadgeVariant.outline,
                          child: Text(flow.viewport),
                        ),
                        const Spacer(),
                        // Narrow touch viewports use an icon-only copy
                        // button so the badge row never overflows.
                        CopyButton(
                          text: flow.install,
                          showLabel:
                              MediaQuery.widthOf(context) >=
                              kPhoneWidthBreakpoint,
                        ),
                      ],
                    ),
                    const Gap(12),
                    Text(
                      flow.name,
                      style: docsText(
                        context,
                        size: 16,
                        weight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      flow.description,
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
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: FlowThumb(screen: first),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    BlockCommandChip(command: flow.install),
                    Button(
                      variant: ButtonVariant.outline,
                      size: ButtonSize.sm,
                      leading: const Icon(LucideIcons.externalLink, size: 14),
                      onPressed: () => DocsRouterScope.of(
                        context,
                      ).go(context, '/docs/flows/${flow.id}'),
                      child: const Text('Open flow'),
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

/// A phone-frame thumbnail of one screen (passive, scaled to fit).
class FlowThumb extends StatelessWidget {
  /// Creates a thumbnail of [screen].
  const FlowThumb({super.key, required this.screen});

  /// The screen to render.
  final FlowScreenEntry screen;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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

/// `/docs/flows/<id>` — one flow: framed live demo, screen map, install
/// tabs and code per screen.
class FlowPage extends StatefulWidget {
  /// Creates the page for [flowId].
  const FlowPage({super.key, required this.flowId});

  /// The registry flow id (`auth-01`).
  final String flowId;

  @override
  State<FlowPage> createState() => _FlowPageState();
}

class _FlowPageState extends State<FlowPage> {
  DeviceFrameId _frame = DeviceFrameId.iphone;
  DeviceOrientation _orientation = DeviceOrientation.portrait;
  int _screen = 0;

  @override
  Widget build(BuildContext context) {
    final DocsFlow? flow = kFlows
        .where((DocsFlow f) => f.id == widget.flowId)
        .firstOrNull;
    if (flow == null) {
      return _MissingFlow(flowId: widget.flowId);
    }
    final List<FlowScreenEntry> screens = flowScreens(flow.id);
    final int index = _screen.clamp(0, screens.length - 1);
    final FlowScreenEntry entry = screens[index];
    final ({String? previousId, String? nextId}) neighbors = flowNeighbors(
      flow.id,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kFlowsMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _FlowPageHeader(flow: flow),
                const Gap(24),
                FramedPreview(
                  id: 'flow-${flow.id}',
                  frame: _frame,
                  onFrameChanged: (DeviceFrameId value) =>
                      setState(() => _frame = value),
                  orientation: _orientation,
                  onOrientationChanged: (DeviceOrientation value) =>
                      setState(() => _orientation = value),
                  child: KeyedSubtree(
                    key: ValueKey<String>('flow-${flow.id}-${entry.route}'),
                    child: buildDemoFlow(flow.id, initialScreen: entry.route),
                  ),
                ),
                const Gap(24),
                _ScreenMap(
                  screens: screens,
                  selected: index,
                  onSelect: (int i) => setState(() => _screen = i),
                ),
                const Gap(32),
                FlowInstallBlock(flow: flow),
                const Gap(32),
                _Dependencies(flow: flow),
                const Gap(32),
                FlowCodePanel(
                  flowId: flow.id,
                  screenName: entry.name,
                  files: entry.files,
                ),
                const Gap(32),
                _FlowPager(
                  previousId: neighbors.previousId,
                  nextId: neighbors.nextId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FlowPageHeader extends StatelessWidget {
  const _FlowPageHeader({required this.flow});

  final DocsFlow flow;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Badge(
              variant: BadgeVariant.secondary,
              child: Text('${flow.screens.length} screens'),
            ),
            const Gap(8),
            Badge(variant: BadgeVariant.outline, child: Text(flow.viewport)),
            const Spacer(),
            CopyButton(text: flow.install, showLabel: true),
          ],
        ),
        const Gap(12),
        Text(
          flow.name,
          style: docsText(
            context,
            size: 30,
            weight: FontWeight.w600,
            height: 36 / 30,
            letterSpacing: -0.75,
          ),
        ),
        const Gap(8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            flow.description,
            style: docsText(
              context,
              size: 16,
              height: 1.5,
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

/// The screen map: one tappable thumbnail per screen; a tap jumps the live
/// flow above to that screen.
class _ScreenMap extends StatelessWidget {
  const _ScreenMap({
    required this.screens,
    required this.selected,
    required this.onSelect,
  });

  final List<FlowScreenEntry> screens;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Screens',
          style: docsText(
            context,
            size: 14,
            weight: FontWeight.w600,
            color: theme.colors.foreground,
          ),
        ),
        const Gap(12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < screens.length; i++) ...<Widget>[
                if (i > 0) const Gap(12),
                _ScreenMapEntry(
                  screen: screens[i],
                  selected: i == selected,
                  onTap: () => onSelect(i),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ScreenMapEntry extends StatelessWidget {
  const _ScreenMapEntry({
    required this.screen,
    required this.selected,
    required this.onTap,
  });

  final FlowScreenEntry screen;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Clickable(
      key: ValueKey<String>('flow-screen-${screen.name}'),
      onPressed: onTap,
      decoration: WidgetStateProperty.resolveWith<Decoration?>((
        Set<WidgetState> states,
      ) {
        if (selected) {
          return BoxDecoration(
            border: Border.all(color: theme.colors.primary, width: 2),
            borderRadius: theme.borderRadiusLg,
          );
        }
        if (states.contains(WidgetState.hovered)) {
          return BoxDecoration(
            border: Border.all(color: theme.colors.border, width: 2),
            borderRadius: theme.borderRadiusLg,
          );
        }
        return const BoxDecoration();
      }),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.all(2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlowThumb(screen: screen),
          const Gap(8),
          Text(
            screen.name,
            style: docsText(
              context,
              size: 13,
              weight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected
                  ? theme.colors.foreground
                  : theme.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}

/// The flow's manifest dependencies, as text (generated facts).
class _Dependencies extends StatelessWidget {
  const _Dependencies({required this.flow});

  final DocsFlow flow;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<String> parts = <String>[
      if (flow.deps.isNotEmpty) 'Components: ${flow.deps.join(', ')}',
      if (flow.blockDeps.isNotEmpty) 'Blocks: ${flow.blockDeps.join(', ')}',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Installed with this flow',
          style: docsText(
            context,
            size: 14,
            weight: FontWeight.w600,
            color: theme.colors.foreground,
          ),
        ),
        const Gap(8),
        Text(
          parts.isEmpty
              ? 'This flow uses no other components.'
              : parts.join('\n'),
          style: docsText(
            context,
            size: 13,
            height: 1.5,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

/// Previous/next flow pager in [kFlows] order.
class _FlowPager extends StatelessWidget {
  const _FlowPager({required this.previousId, required this.nextId});

  final String? previousId;
  final String? nextId;

  @override
  Widget build(BuildContext context) {
    final Widget previous = previousId == null
        ? const SizedBox.shrink()
        : Button(
            variant: ButtonVariant.secondary,
            size: ButtonSize.sm,
            leading: const Icon(LucideIcons.arrowLeft, size: 16),
            onPressed: () => DocsRouterScope.of(
              context,
            ).go(context, '/docs/flows/$previousId'),
            child: Text(_labelOf(previousId!), overflow: TextOverflow.ellipsis),
          );
    final Widget next = nextId == null
        ? const SizedBox.shrink()
        : Button(
            variant: ButtonVariant.secondary,
            size: ButtonSize.sm,
            trailing: const Icon(LucideIcons.arrowRight, size: 16),
            onPressed: () =>
                DocsRouterScope.of(context).go(context, '/docs/flows/$nextId'),
            child: Text(_labelOf(nextId!), overflow: TextOverflow.ellipsis),
          );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 560) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: previous),
              const Gap(8),
              Align(alignment: Alignment.centerRight, child: next),
            ],
          );
        }
        return Row(children: <Widget>[previous, const Spacer(), next]);
      },
    );
  }

  String _labelOf(String id) =>
      kFlows.firstWhere((DocsFlow f) => f.id == id).name;
}

class _MissingFlow extends StatelessWidget {
  const _MissingFlow({required this.flowId});

  final String flowId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'No flow named `$flowId`.',
              style: docsText(context, size: 16, weight: FontWeight.w600),
            ),
            const Gap(12),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () =>
                  DocsRouterScope.of(context).go(context, '/docs/flows'),
              child: const Text('Back to Flows'),
            ),
          ],
        ),
      ),
    );
  }
}
