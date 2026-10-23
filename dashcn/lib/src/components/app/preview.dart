// Gallery preview for the `app` component: a complete [DashcnApp] with a
// small home page. Embedding starts a nested WidgetsApp, which is the only
// way to show the shell honestly; the docs gallery hosts this at root level.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
import 'app.dart';
import '../../foundation/component_preview.dart';

/// Renders the app-shell preview.
class AppPreview extends StatelessWidget {
  /// Creates the preview.
  const AppPreview({super.key});

  @override
  Widget build(BuildContext context) {
    // Inherit the ambient site theme so the banner matches light and dark:
    // `DashcnApp` defaults to the light fallback and resolves via
    // `MediaQuery`, which would paint a white banner on the dark canvas.
    // Passing the outer theme for both legs pins the nested app to it
    // (including the docs per-card brightness invert).
    final ThemeData outer = Theme.of(context);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: DashcnApp(
        title: 'DashcnApp preview',
        theme: outer,
        darkTheme: outer,
        home: Builder(
          builder: (BuildContext context) {
            final ThemeData theme = Theme.of(context);
            return ColoredBox(
              color: theme.colors.background,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colors.card,
                    border: Border.all(color: theme.colors.border),
                    borderRadius: theme.borderRadiusLg,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          docsSample(
                            context,
                            docsSample(
                              context,
                              docsSample(context, 'DashcnApp is wired and running.'),
                            ),
                          ),
                          style: theme.typography.large.copyWith(
                            color: theme.colors.cardForeground,
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
