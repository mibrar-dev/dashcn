// The docs-site navigation model: header items, sidebar sections and pager
// order. Component links come from the generated `kComponentLinks`; these page
// links are docs-side route constants, not registry facts.

import 'package:flutter/foundation.dart';

import '../generated/docs_blocks.dart';
import '../generated/docs_data.dart';
import '../generated/docs_flows.dart';
import '../generated/docs_starters.dart';

/// One navigation target (label + in-app location).
@immutable
class DocsNavLink {
  /// Creates a nav link.
  const DocsNavLink({required this.label, required this.location});

  /// Visible label.
  final String label;

  /// Canonical in-app location (`/docs/installation`).
  final String location;

  /// Whether this link is the current page.
  bool isActiveFor(String currentLocation) => currentLocation == location;

  @override
  bool operator ==(Object other) =>
      other is DocsNavLink &&
      other.label == label &&
      other.location == location;

  @override
  int get hashCode => Object.hash(label, location);
}

/// Header items (Home, Docs, Components, Charts, Blocks, Flows, Starters,
/// Themes — spec §5.1 plus the P6-B3 Blocks, P9-3b Flows and P9-Z2 Starters
/// sections).
const List<DocsNavLink> kHeaderNav = <DocsNavLink>[
  DocsNavLink(label: 'Home', location: '/'),
  DocsNavLink(label: 'Docs', location: '/docs'),
  DocsNavLink(label: 'Components', location: '/docs/components'),
  DocsNavLink(label: 'Charts', location: '/charts'),
  DocsNavLink(label: 'Blocks', location: '/blocks'),
  DocsNavLink(label: 'Flows', location: '/docs/flows'),
  DocsNavLink(label: 'Starters', location: '/docs/starters'),
  DocsNavLink(label: 'Themes', location: '/themes'),
];

/// The chart families, in hub-card order: one page per family.
const List<DocsNavLink> kChartLinks = <DocsNavLink>[
  DocsNavLink(label: 'Area', location: '/charts/area'),
  DocsNavLink(label: 'Bar', location: '/charts/bar'),
  DocsNavLink(label: 'Line', location: '/charts/line'),
  DocsNavLink(label: 'Pie', location: '/charts/pie'),
  DocsNavLink(label: 'Scatter', location: '/charts/scatter'),
];

/// The sidebar `Sections` group, top to bottom (spec §1).
const List<DocsNavLink> kDocsSections = <DocsNavLink>[
  DocsNavLink(label: 'Introduction', location: '/docs'),
  DocsNavLink(label: 'Components', location: '/docs/components'),
  DocsNavLink(label: 'Charts', location: '/charts'),
  DocsNavLink(label: 'Installation', location: '/docs/installation'),
  DocsNavLink(
    label: 'Package or own the code?',
    location: '/docs/package-or-own',
  ),
  DocsNavLink(label: 'Alongside Material', location: '/docs/material'),
  DocsNavLink(label: 'Theming', location: '/docs/theming'),
  DocsNavLink(label: 'Dark Mode', location: '/docs/dark-mode'),
  DocsNavLink(label: 'CLI', location: '/docs/cli'),
  DocsNavLink(label: 'How we measure', location: '/docs/scorecards'),
];

/// Pager chain for prose pages.
///
/// The Components index is excluded: its "next" is the first component in
/// [kComponentLinks], matching the reference pager.
const List<DocsNavLink> kDocsPageChain = <DocsNavLink>[
  DocsNavLink(label: 'Introduction', location: '/docs'),
  DocsNavLink(label: 'Installation', location: '/docs/installation'),
  DocsNavLink(
    label: 'Package or own the code?',
    location: '/docs/package-or-own',
  ),
  DocsNavLink(label: 'Alongside Material', location: '/docs/material'),
  DocsNavLink(label: 'Theming', location: '/docs/theming'),
  DocsNavLink(label: 'Dark Mode', location: '/docs/dark-mode'),
  DocsNavLink(label: 'CLI', location: '/docs/cli'),
  DocsNavLink(label: 'How we measure', location: '/docs/scorecards'),
];

/// Previous/next links in [kDocsPageChain] for [location].
({DocsNavLink? previous, DocsNavLink? next}) docsPageNeighbors(
  String location,
) {
  final int index = kDocsPageChain.indexWhere(
    (DocsNavLink link) => link.location == location,
  );
  if (index < 0) {
    return (previous: null, next: null);
  }
  return (
    previous: index > 0 ? kDocsPageChain[index - 1] : null,
    next: index < kDocsPageChain.length - 1 ? kDocsPageChain[index + 1] : null,
  );
}

/// Previous/next chart family ids in [kChartLinks] order (used by the family
/// page pager).
({String? previousId, String? nextId}) chartNeighbors(String id) {
  final int index = kChartLinks.indexWhere(
    (DocsNavLink link) => link.location == '/charts/$id',
  );
  if (index < 0) {
    return (previousId: null, nextId: null);
  }
  String idOf(int i) => kChartLinks[i].location.split('/').last;
  return (
    previousId: index > 0 ? idOf(index - 1) : null,
    nextId: index < kChartLinks.length - 1 ? idOf(index + 1) : null,
  );
}

/// Previous/next component ids in the alphabetical [kComponentLinks] order
/// (used by D4's component page pager).
({String? previousId, String? nextId}) componentNeighbors(String id) {
  final int index = kComponentLinks.indexWhere(
    (DocsComponentLink link) => link.id == id,
  );
  if (index < 0) {
    return (previousId: null, nextId: null);
  }
  return (
    previousId: index > 0 ? kComponentLinks[index - 1].id : null,
    nextId: index < kComponentLinks.length - 1
        ? kComponentLinks[index + 1].id
        : null,
  );
}

/// Previous/next block ids in [kBlocks] order (index-block adjacency, matching
/// the reference's card order).
({String? previousId, String? nextId}) blockNeighbors(String id) {
  final int index = kBlocks.indexWhere((DocsBlock block) => block.id == id);
  if (index < 0) {
    return (previousId: null, nextId: null);
  }
  return (
    previousId: index > 0 ? kBlocks[index - 1].id : null,
    nextId: index < kBlocks.length - 1 ? kBlocks[index + 1].id : null,
  );
}

/// Previous/next flow ids in [kFlows] order (P9-3b).
({String? previousId, String? nextId}) flowNeighbors(String id) {
  final int index = kFlows.indexWhere((DocsFlow flow) => flow.id == id);
  if (index < 0) {
    return (previousId: null, nextId: null);
  }
  return (
    previousId: index > 0 ? kFlows[index - 1].id : null,
    nextId: index < kFlows.length - 1 ? kFlows[index + 1].id : null,
  );
}

/// Previous/next starter ids in [kStarters] order (P9-Z2).
({String? previousId, String? nextId}) starterNeighbors(String id) {
  final int index = kStarters.indexWhere(
    (DocsStarter starter) => starter.id == id,
  );
  if (index < 0) {
    return (previousId: null, nextId: null);
  }
  return (
    previousId: index > 0 ? kStarters[index - 1].id : null,
    nextId: index < kStarters.length - 1 ? kStarters[index + 1].id : null,
  );
}
