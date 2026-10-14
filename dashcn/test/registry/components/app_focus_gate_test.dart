// P7-FOCUS: `DashcnApp` builds nothing until the first frame completes, so
// the engine's pre-layout view-focus event cannot throw
// `Bad state: RenderBox was not laid out` on web startup.
//
// P7I-fix-focus2: an earlier revision hid the subtree behind
// `Focus(descendantsAreTraversable: false)` for one frame; in release web the
// nodes built in the first frame stayed untraversable (the first Tab skipped
// the whole header). Building nothing until the first post-frame keeps the
// view-focus protection and leaves every node traversable.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/components/button/button.dart';
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
  // The gate is web-only in apps; force it here so the VM test exercises it.
  setUp(() => debugFirstFrameFocusGateOnAllPlatforms = true);
  tearDown(() => debugFirstFrameFocusGateOnAllPlatforms = false);

  testWidgets('nothing is traversable before the first frame settles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      DashcnApp(
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
      DashcnApp(
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

  testWidgets('first-frame nodes are traversable after the first frame', (
    WidgetTester tester,
  ) async {
    // The release-browser ground truth (`browser_check.mjs` shot
    // `13-tab-once`): one Tab must reach the first button, not skip the
    // whole first frame.
    final FocusNode first = FocusNode();
    final FocusNode second = FocusNode();
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    await tester.pumpWidget(
      DashcnApp(
        home: Column(
          children: <Widget>[
            Button(
              focusNode: first,
              onPressed: () {},
              child: const Text('First'),
            ),
            Button(
              focusNode: second,
              onPressed: () {},
              child: const Text('Second'),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(first.hasPrimaryFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(second.hasPrimaryFocus, isTrue);
  });
}
