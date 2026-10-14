// The command palette's data model: entries built from the generated registry
// data (Pages / Components / Blocks / Flows / Starters / Presets, spec §5.3
// D2 delta + P6-B3 + P9-3b + P9-Z2).
// Split from `palette.dart` to keep both files under the ~400-line rule.

import 'package:flutter/widgets.dart';

import '../generated/docs_blocks.dart';
import '../generated/docs_data.dart';
import '../generated/docs_flows.dart';
import '../generated/docs_starters.dart';
import '../generated/docs_tables.dart';
import '../routing/docs_nav.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import 'docs_tokens.dart';

class PaletteEntry {
  const PaletteEntry({
    required this.group,
    required this.label,
    required this.route,
    required this.icon,
    this.tag,
    this.action,
    this.category,
    this.keywords = const <String>[],
  });

  final PaletteGroup group;
  final String label;
  final String route;
  final IconData icon;
  final String? tag;
  final String? action;

  /// Component category — the sub-group heading inside the Components group.
  final String? category;
  final List<String> keywords;

  bool matches(String query) {
    if (label.toLowerCase().contains(query)) {
      return true;
    }
    if (tag != null && tag!.toLowerCase().contains(query)) {
      return true;
    }
    if (category != null && category!.toLowerCase().contains(query)) {
      return true;
    }
    return keywords.any(
      (String keyword) => keyword.toLowerCase().contains(query),
    );
  }
}

List<PaletteEntry> buildPaletteEntries() {
  final List<PaletteEntry> items = <PaletteEntry>[];
  final Set<String> seen = <String>{};
  for (final DocsNavLink link in <DocsNavLink>[
    ...kHeaderNav,
    ...kDocsSections,
  ]) {
    if (!seen.add(link.location)) {
      continue;
    }
    items.add(
      PaletteEntry(
        group: PaletteGroup.pages,
        label: link.label,
        route: link.location,
        icon: paletteIconFor(link.location),
      ),
    );
  }
  for (final DocsCliCommand command in kCliCommands) {
    items.add(
      PaletteEntry(
        group: PaletteGroup.pages,
        label: command.label,
        route: '/docs/cli',
        icon: LucideIcons.terminal,
        tag: 'CLI',
        action: command.invocation,
        keywords: <String>[command.summary, command.usage],
      ),
    );
  }
  // Grouped by category (count descending, then id) so the palette renders the
  // same sub-headings the sidebar shows; building blocks (`listed: false`) are
  // not searchable here.
  for (final DocsComponentCategory group in kComponentCategoryGroups) {
    for (final DocsComponentLink component in group.components) {
      items.add(
        PaletteEntry(
          group: PaletteGroup.components,
          label: component.name,
          route: '/docs/components/${component.id}',
          icon: LucideIcons.component,
          tag: '${fileCountOf(component.id)} files',
          action: installCommandOf(component.id),
          category: group.id,
          // Names + tags only, mirroring the generated search index: the long
          // description would make incidental matches dominate.
          keywords: <String>[component.id],
        ),
      );
    }
  }
  for (final DocsBlock block in kBlocks) {
    items.add(
      PaletteEntry(
        group: PaletteGroup.blocks,
        label: block.name,
        route: '/blocks/${block.id}',
        icon: LucideIcons.blocks,
        tag: 'block',
        action: block.install,
        category: block.category,
        keywords: <String>[block.id],
      ),
    );
  }
  for (final DocsFlow flow in kFlows) {
    items.add(
      PaletteEntry(
        group: PaletteGroup.flows,
        label: flow.name,
        route: '/docs/flows/${flow.id}',
        icon: LucideIcons.smartphone,
        tag: 'flow',
        action: flow.install,
        keywords: <String>[flow.id],
      ),
    );
  }
  for (final DocsStarter starter in kStarters) {
    items.add(
      PaletteEntry(
        group: PaletteGroup.starters,
        label: starter.name,
        route: '/docs/starters/${starter.id}',
        icon: LucideIcons.rocket,
        tag: 'starter',
        action: starter.install,
        keywords: <String>[
          starter.id,
          starter.description,
          ...starter.flows,
          ...starter.tags,
        ],
      ),
    );
  }
  for (final DocsPreset preset in kPresets) {
    items.add(
      PaletteEntry(
        group: PaletteGroup.presets,
        label: preset.name,
        route: '/themes',
        icon: LucideIcons.palette,
        tag: 'preset',
        action: preset.id,
        keywords: <String>[preset.id],
      ),
    );
  }
  return items;
}

/// `dashcn add <id>` for [componentId].
String installCommandOf(String componentId) => 'dashcn add $componentId';

/// Installed Dart file count for [componentId].
int fileCountOf(String componentId) => kComponents
    .firstWhere((DocsComponent component) => component.id == componentId)
    .fileCount;

IconData paletteIconFor(String location) {
  return switch (location) {
    '/' => LucideIcons.house,
    '/docs' => LucideIcons.fileText,
    '/docs/components' => LucideIcons.component,
    '/blocks' => LucideIcons.blocks,
    '/docs/flows' => LucideIcons.smartphone,
    '/themes' => LucideIcons.palette,
    '/docs/installation' => LucideIcons.download,
    _ => LucideIcons.fileText,
  };
}
