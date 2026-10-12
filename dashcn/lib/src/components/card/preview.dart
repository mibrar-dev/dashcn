// Named examples for the `card` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the footer actions are live — Deploy confirms the card and Cancel
// dismisses it, with a status line that reports what happened.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'card.dart';

/// The full upstream slot composition.
//
// P7-D1b: capped at 320 px (not fixed) so narrow phones shrink it instead of
// overflowing; the stage centres it.
class _CardDefault extends StatefulWidget {
  const _CardDefault();

  @override
  State<_CardDefault> createState() => _CardDefaultState();
}

class _CardDefaultState extends State<_CardDefault> {
  String _status = 'Ready to deploy';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CardHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CardTitle(child: Text('Deployments')),
                      CardDescription(
                        child: Text('Ship a new build to production.'),
                      ),
                    ],
                  ),
                ),
                Gap(spacing.lg),
                const CardContent(
                  child: Text(
                    'Every deploy is immutable; roll back from the history tab.',
                  ),
                ),
                Gap(spacing.lg),
                CardFooter(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Button(
                        size: ButtonSize.sm,
                        variant: ButtonVariant.ghost,
                        onPressed: () =>
                            setState(() => _status = 'Deploy cancelled'),
                        child: const Text('Cancel'),
                      ),
                      Gap(spacing.sm),
                      Button(
                        size: ButtonSize.sm,
                        onPressed: () =>
                            setState(() => _status = 'Deploy queued'),
                        child: const Text('Deploy'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(spacing.md),
        Text(
          _status,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

/// A card whose header carries a clipped media band.
Widget _cardWithMedia(BuildContext context) {
  final theme = Theme.of(context);
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 320),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 96,
            child: ColoredBox(
              color: theme.colors.muted,
              child: Center(
                child: Icon(
                  LucideIcons.image,
                  size: 24,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
          ),
          const CardHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardTitle(child: Text('Cover art')),
                CardDescription(
                  child: Text('Generated from the preset palette.'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// A bare surface whose footer button is live.
class _CardWithFooter extends StatefulWidget {
  const _CardWithFooter();

  @override
  State<_CardWithFooter> createState() => _CardWithFooterState();
}

class _CardWithFooterState extends State<_CardWithFooter> {
  String _status = 'Plan unchanged';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CardTitle(child: Text('Billing')),
                Gap(theme.spacing.xs),
                Text(
                  'Bare card, default padding',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
                Gap(theme.spacing.lg),
                CardFooter(
                  padding: EdgeInsetsDensity.pxAll(0),
                  child: Button(
                    size: ButtonSize.sm,
                    variant: ButtonVariant.outline,
                    onPressed: () =>
                        setState(() => _status = 'Opened the plan'),
                    child: const Text('Manage plan'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _status,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _cardDefault(BuildContext context) => const _CardDefault();

Widget _cardWithFooter(BuildContext context) => const _CardWithFooter();

/// Named docs examples for `card`; the first entry is the default.
const List<ComponentPreview> cardPreviews = <ComponentPreview>[
  ComponentPreview('Default', _cardDefault),
  ComponentPreview('With media', _cardWithMedia),
  ComponentPreview('With footer', _cardWithFooter),
];
