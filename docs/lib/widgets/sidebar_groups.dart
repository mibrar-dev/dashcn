// The docs sidebar's row model (P6-B3): the Sections / Components / Blocks
// groups as plain data, so the sidebar widget only paints.
//
// Components are grouped by their generated category (P6-B1 taxonomy) and
// building blocks (`listed: false` in the manifest) are omitted — they stay
// installable and reachable through the component pager/API links, but never
// appear in the browsable surfaces. Blocks are grouped by their block family.
//
// Split out of `docs_sidebar.dart` for the ~400-line rule.

import 'package:flutter/widgets.dart';

import '../generated/docs_blocks.dart';
import '../generated/docs_data.dart';
import '../generated/docs_flows.dart';
import '../generated/docs_starters.dart';
import '../routing/docs_nav.dart';
import '../state/docs_strings.dart';
import 'docs_header.dart' show docsSectionLabel;

/// One sidebar row: a group label, a category sub-label, or a link.
@immutable
class SidebarRow {
  const SidebarRow._({
    required this.label,
    required this.location,
    required this.isLabel,
    required this.isSubLabel,
  });

  /// A group label (`Sections`, `Components`, `Blocks`).
  const SidebarRow.label(String text)
    : this._(label: text, location: null, isLabel: true, isSubLabel: false);

  /// A category sub-label inside a group (`Forms & Inputs`, `Dashboard`).
  const SidebarRow.subLabel(String text)
    : this._(label: text, location: null, isLabel: false, isSubLabel: true);

  /// A navigable row.
  const SidebarRow.link({required String text, required String location})
    : this._(
        label: text,
        location: location,
        isLabel: false,
        isSubLabel: false,
      );

  /// Visible label.
  final String label;

  /// In-app location for link rows; null for labels.
  final String? location;

  /// Whether the row is a group label.
  final bool isLabel;

  /// Whether the row is a category sub-label.
  final bool isSubLabel;

  /// Whether the row navigates.
  bool get isLink => !isLabel && !isSubLabel;
}

/// Builds the sidebar rows for [activeLocation], top to bottom.
List<SidebarRow> buildSidebarRows(String activeLocation) {
  return buildSidebarRowsLocalized(activeLocation, const Locale('en'));
}

/// Builds the sidebar rows for [activeLocation] in [locale].
///
/// Group labels, docs-section links, Theme Studio and the import item are
/// translated; component/block/flow/starter names and category ids stay
/// English (registry proper nouns).
List<SidebarRow> buildSidebarRowsLocalized(
  String activeLocation,
  Locale locale,
) {
  String sectionLabel(DocsNavLink link) =>
      docsSectionLabelFor(link.location, locale);
  return <SidebarRow>[
    SidebarRow.label(docsChrome(locale, 'sideSections')),
    for (final DocsNavLink link in kDocsSections)
      SidebarRow.link(text: sectionLabel(link), location: link.location),
    SidebarRow.label(docsChrome(locale, 'navComponents')),
    for (final DocsComponentCategory category
        in kComponentCategoryGroups) ...<SidebarRow>[
      SidebarRow.subLabel(category.id),
      for (final DocsComponentLink component in category.components)
        SidebarRow.link(
          text: component.name,
          location: '/docs/components/${component.id}',
        ),
    ],
    SidebarRow.label(docsChrome(locale, 'navBlocks')),
    for (final DocsBlockCategory category in kBlockCategories) ...<SidebarRow>[
      SidebarRow.subLabel(category.id),
      for (final DocsBlock block in category.blocks)
        SidebarRow.link(text: block.name, location: '/blocks/${block.id}'),
    ],
    SidebarRow.label(docsChrome(locale, 'navFlows')),
    for (final DocsFlow flow in kFlows)
      SidebarRow.link(text: flow.name, location: '/docs/flows/${flow.id}'),
    SidebarRow.label(docsChrome(locale, 'navStarters')),
    for (final DocsStarter starter in kStarters)
      SidebarRow.link(
        text: starter.name,
        location: '/docs/starters/${starter.id}',
      ),
    SidebarRow.label(docsChrome(locale, 'navThemes')),
    SidebarRow.link(
      text: docsChrome(locale, 'sideThemeStudio'),
      location: '/themes',
    ),
    SidebarRow.link(
      text: docsChrome(locale, 'sideImportTheme'),
      location: '/themes?panel=import',
    ),
  ];
}

/// Translated docs-section label for a sidebar [location] in [locale].
String docsSectionLabelFor(String location, Locale locale) {
  if (location == '/docs/components') {
    return docsChrome(locale, 'navComponents');
  }
  return docsSectionLabel(location, locale);
}
