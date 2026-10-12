// Named examples for the `empty_state` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// No outer fixed-height box: the full-page sizes want a tall host, so each
// example is laid out in a box the stage already bounds.
//
// P7-C2: every action is live and reports what it did, so the demo shows the
// buttons doing something instead of being decoration.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'empty_state.dart';

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: ShadcnTheme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// The full-page empty state, both actions live.
class _EmptyStateEmpty extends StatefulWidget {
  const _EmptyStateEmpty();

  @override
  State<_EmptyStateEmpty> createState() => _EmptyStateEmptyState();
}

class _EmptyStateEmptyState extends State<_EmptyStateEmpty> {
  String _status = 'Nothing here yet.';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.empty,
          primaryAction: EmptyStateAction(
            label: 'Create project',
            onPressed: () => setState(() => _status = 'Created a project.'),
          ),
          secondaryAction: EmptyStateAction(
            label: 'Import',
            variant: ButtonVariant.outline,
            onPressed: () => setState(() => _status = 'Importing a project.'),
          ),
        ),
        Gap(ShadcnTheme.of(context).spacing.md),
        _StatusLine(_status),
      ],
    );
  }
}

/// The no-results variant, whose action clears the filters.
class _EmptyStateNoResults extends StatefulWidget {
  const _EmptyStateNoResults();

  @override
  State<_EmptyStateNoResults> createState() => _EmptyStateNoResultsState();
}

class _EmptyStateNoResultsState extends State<_EmptyStateNoResults> {
  String _status = 'No results for "rocket".';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.noResults,
          primaryAction: EmptyStateAction(
            label: 'Clear filters',
            onPressed: () => setState(() => _status = 'Filters cleared.'),
          ),
        ),
        Gap(ShadcnTheme.of(context).spacing.md),
        _StatusLine(_status),
      ],
    );
  }
}

/// The error-fallback variant with a footer link.
class _EmptyStateError extends StatefulWidget {
  const _EmptyStateError();

  @override
  State<_EmptyStateError> createState() => _EmptyStateErrorState();
}

class _EmptyStateErrorState extends State<_EmptyStateError> {
  String _status = 'Something went wrong.';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.errorFallback,
          primaryAction: EmptyStateAction(
            label: 'Try again',
            onPressed: () => setState(() => _status = 'Retrying...'),
          ),
          footerAction: EmptyStateAction(
            label: 'Report this',
            variant: ButtonVariant.link,
            onPressed: () => setState(() => _status = 'Report sent.'),
          ),
        ),
        Gap(ShadcnTheme.of(context).spacing.md),
        _StatusLine(_status),
      ],
    );
  }
}

/// The compact scale, with and without the icon container.
Widget _emptyStateCompact(BuildContext context) {
  final spacing = ShadcnTheme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const EmptyState(
        size: EmptyStateSize.compact,
        variant: EmptyStateVariant.empty,
        title: Text('Nothing here yet'),
        primaryAction: EmptyStateAction(label: 'Create'),
      ),
      Gap(spacing.xl),
      const EmptyState(
        size: EmptyStateSize.compact,
        variant: EmptyStateVariant.noResults,
        showIconContainer: false,
        title: Text('No matches'),
        description: Text('Try a different term.'),
      ),
    ],
  );
}

Widget _emptyStateNoResults(BuildContext context) =>
    const _EmptyStateNoResults();

Widget _emptyStateEmpty(BuildContext context) => const _EmptyStateEmpty();

Widget _emptyStateError(BuildContext context) => const _EmptyStateError();

/// Named docs examples for `empty_state`; the first entry is the default.
const List<ComponentPreview> emptyStatePreviews = <ComponentPreview>[
  ComponentPreview('No results', _emptyStateNoResults),
  ComponentPreview('Empty', _emptyStateEmpty),
  ComponentPreview('Error fallback', _emptyStateError),
  ComponentPreview('Compact', _emptyStateCompact),
];
