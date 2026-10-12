// P7-FOCUS: `ShadcnApp` keeps everything unfocusable until the first frame
// completes, so the engine's pre-layout view-focus event cannot throw
// `Bad state: RenderBox was not laid out` on web startup.

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/app/app.dart';
import 'package:flutter_shadcn_kit/registry/components/button/button.dart';
import 'package:flutter_test/flutter_test.dart';

/// Whether any leaf (non-scope) focus node under the view scope can take
/// focus right now.
bool _hasLeafFocusable() {
  final FocusScopeNode scope = FocusManager.instance.rootScope.descendants
      .whereType<FocusScopeNode>()
      .firstWhere((FocusScopeNode scope) => scope.debugLabel == 'View Scope');
  return scope.descendants.any(
    (FocusNode node) =>
        node is! FocusScopeNode &&
        node.canRequestFocus &&
        !node.skipTraversal &&
        node.context != null,
  );
}

void main() {
  testWidgets('nothing is traversable before the first frame settles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ShadcnApp(
        home: Button(onPressed: () {}, child: const Text('Save')),
      ),
    );
    // One frame built: the gate is still closed (it opens post-frame).
    expect(_hasLeafFocusable(), isFalse);
    await tester.pumpAndSettle();
    expect(_hasLeafFocusable(), isTrue);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('autofocus on the first screen still takes focus', (
    WidgetTester tester,
  ) async {
    final FocusNode node = FocusNode();
    addTearDown(node.dispose);
    await tester.pumpWidget(
      ShadcnApp(
        home: Focus(
          focusNode: node,
          autofocus: true,
          child: const SizedBox(width: 10, height: 10),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(node.hasFocus, isTrue);
  });
}
