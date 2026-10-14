// The component page's scorecard section (P9-Z).
//
// A [ScorecardCard] for the component under its own `scorecard` heading so
// the page's "On this page" TOC lists it. Placed below the playground and
// above the examples.

import 'package:flutter/widgets.dart';

import 'heading_anchor.dart';
import 'scorecard/scorecard_card.dart';

/// The trust scorecard section for [componentId].
class ComponentScorecardSection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentScorecardSection({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const HeadingAnchor(id: 'scorecard', title: 'Trust scorecard'),
        ScorecardCard(componentId: componentId),
      ],
    );
  }
}
