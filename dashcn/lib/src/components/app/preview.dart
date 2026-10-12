// Gallery preview for the `app` component: a complete [DashcnApp] with a
// small home page. Embedding starts a nested WidgetsApp, which is the only
// way to show the shell honestly; the docs gallery hosts this at root level.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
import 'app.dart';

/// Renders the app-shell preview.
class AppPreview extends StatelessWidget {
  /// Creates the preview.
  const AppPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return DashcnApp(
      title: 'DashcnApp preview',
      home: Builder(
        builder: (BuildContext context) {
          final ThemeData theme = Theme.of(context);
          return ColoredBox(
            color: theme.colors.background,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'DashcnApp is wired and running.',
                    style: theme.typography.large.copyWith(
                      color: theme.colors.foreground,
                    ),
                  ),
                  Gap(theme.spacing.sm),
                  Text(
                    ComponentLocalizations.of(context).dialogDismiss,
                    style: theme.typography.small.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
