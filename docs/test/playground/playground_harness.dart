// Shared pump helper for playground widget tests (not a test itself).
//
// Pumps one playground builder inside the kit theme; tests then read the
// built widgets back through finders and their public properties.

import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/builders.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps the playground builder for [id] with [overrides] applied over the
/// spec defaults. Returns the values the builder received.
///
/// The frame includes a [Navigator] (with its overlay) so trigger builders
/// (`dialog`, `popup`) can open their routes on tap. The navigator is keyed
/// per pump: routes cache their page builder, so a fresh navigator forces
/// the new values through.
int _pumpSeq = 0;

Future<PlaygroundValues> pumpPlayground(
  WidgetTester tester,
  String id, [
  Map<String, Object?> overrides = const <String, Object?>{},
]) async {
  final ComponentControls spec = kControlSpecs[id]!;
  final PlaygroundValues values = PlaygroundValues.defaults(spec);
  values.addAll(overrides);
  await tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: ComponentThemes(
        themes: const <ComponentThemeData>[],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Navigator(
              key: ValueKey<String>('playground-nav-${_pumpSeq++}'),
              onGenerateRoute: (RouteSettings settings) =>
                  PageRouteBuilder<void>(
                    settings: settings,
                    pageBuilder: (BuildContext context, _, _) => Builder(
                      builder: (BuildContext context) =>
                          kPlaygroundBuilders[id]!(context, values),
                    ),
                  ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  return values;
}
