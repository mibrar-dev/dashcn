// The component page's Playground section (P9-Z).
//
// A live [PlaygroundPanel] for components with a hand-written builder,
// or a quiet "coming soon" note where the panel would render nothing.
// Values seed from the router's playground query (reload/back safe) and
// every change reports back through [DocsState], so the router merges
// `p.*` into the browser URL. Registers the `playground` heading for the
// page's "On this page" TOC.

import 'package:flutter/widgets.dart';

import '../generated/docs_controls.dart';
import '../playground/builders.dart';
import '../playground/ui/playground_panel.dart';
import '../routing/docs_router.dart';
import '../state/docs_state.dart';
import 'heading_anchor.dart';
import 'typeset.dart';

/// Whether [componentId] has a live playground (spec + builder).
bool hasPlayground(String componentId) {
  return kControlSpecs.containsKey(componentId) &&
      kPlaygroundBuilders.containsKey(componentId);
}

/// The Playground section for [componentId].
class ComponentPlaygroundSection extends StatelessWidget {
  /// Creates the section for [componentId].
  const ComponentPlaygroundSection({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const HeadingAnchor(id: 'playground', title: 'Playground'),
        if (!hasPlayground(componentId))
          const TypesetParagraph('Playground coming soon for this component.')
        else
          _LivePlayground(componentId: componentId),
      ],
    );
  }
}

/// The live panel, rebuilt whenever the router's query changes.
class _LivePlayground extends StatelessWidget {
  /// Creates the live panel for [componentId].
  const _LivePlayground({required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final DocsState state = DocsRouterScope.of(context).state;
    return ListenableBuilder(
      listenable: state,
      builder: (BuildContext context, Widget? _) => PlaygroundPanel(
        componentId: componentId,
        initialQuery: state.playgroundQuery,
        onQueryChanged: state.setPlaygroundQuery,
        reportUrl: false,
      ),
    );
  }
}
