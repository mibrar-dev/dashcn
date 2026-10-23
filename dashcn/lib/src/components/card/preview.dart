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
  String _status = docsSample(null, 'Ready to deploy');

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
                CardHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CardTitle(
                        child: Text(docsSample(context, 'Deployments')),
                      ),
                      CardDescription(
                        child: Text(
                          docsSample(
                            context,
                            docsSample(
                              context,
                              docsSample(
                                context,
                                docsSample(
                                  context,
                                  'Ship a new build to production.',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(spacing.lg),
                CardContent(
                  child: Text(
                    docsSample(
                      context,
                      docsSample(
                        context,
                        docsSample(
                          context,
                          docsSample(
                            context,
                            'Every deploy is immutable; roll back from the history tab.',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(spacing.lg),
                CardFooter(
                  child: Builder(
                    builder: (context) {
                      // Narrow phone viewports stack the touch-sized footer
                      // actions; wider viewports keep them side by side.
                      final bool stack = MediaQuery.widthOf(context) < 600;
                      final List<Widget> actions = <Widget>[
                        Button(
                          size: ButtonSize.sm,
                          variant: ButtonVariant.ghost,
                          onPressed: () => setState(
                            () => _status = docsSample(
                              context,
                              docsSample(context, 'Deploy cancelled'),
                            ),
                          ),
                          child: Text(docsSample(context, 'Cancel')),
                        ),
                        Button(
                          size: ButtonSize.sm,
                          onPressed: () => setState(
                            () =>
                                _status = docsSample(context, 'Deploy queued'),
                          ),
                          child: Text(docsSample(context, 'Deploy')),
                        ),
                      ];
                      if (!stack) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            actions[0],
                            Gap(spacing.sm),
                            actions[1],
                          ],
                        );
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          actions[0],
                          Gap(spacing.sm),
                          actions[1],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(spacing.md),
        Text(
          docsSample(context, _status),
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
          CardHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardTitle(child: Text(docsSample(context, 'Cover art'))),
                CardDescription(
                  child: Text(
                    docsSample(context, 'Generated from the preset palette.'),
                  ),
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
  String _status = docsSample(null, 'Plan unchanged');

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
                CardTitle(child: Text(docsSample(context, 'Billing'))),
                Gap(theme.spacing.xs),
                Text(
                  docsSample(context, 'Bare card, default padding'),
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
                Gap(theme.spacing.lg),
                CardFooter(
                  padding: EdgeInsetsDensity.pxAll(0),
                  child: Button(
                    size: ButtonSize.sm,
                    variant: ButtonVariant.outline,
                    onPressed: () => setState(
                      () => _status = docsSample(context, 'Opened the plan'),
                    ),
                    child: Text(docsSample(context, 'Manage plan')),
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          docsSample(context, _status),
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _cardDefault(BuildContext context) => const _CardDefault();

Widget _cardWithFooter(BuildContext context) => const _CardWithFooter();

/// Named docs examples for `card`; the first entry is the default.
List<ComponentPreview> get cardPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _cardDefault),
  ComponentPreview(docsSample(null, 'With media'), _cardWithMedia),
  ComponentPreview(docsSample(null, 'With footer'), _cardWithFooter),
];
