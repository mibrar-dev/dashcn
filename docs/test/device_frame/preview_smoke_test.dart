// P9-1 preview smoke test: every representative preview loads and pumps
// unframed with no errors.
//
// Loads go through the isolate warm cache ([loadWarmPreview]): co-issued
// deferred loads resolve together, while a second distinct chunk issued
// after the first completed hangs the engine, so the first caller warms
// all six at once and the rest are cache hits.

import 'package:docs/ui/dashcn/components/spinner/spinner.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'frame_harness.dart';

void main() {
  group('preview smoke', () {
    for (final String previewId in kMatrixPreviewIds) {
      testWidgets('$previewId loads and pumps', (WidgetTester tester) async {
        // Placeholder first: loads only resolve while frames pump, and a
        // looping spinner keeps them scheduled.
        await pumpFramedScene(tester, const Center(child: Spinner()));
        final Widget preview = await loadWarmPreview(tester, previewId);
        expect(preview, isNotNull);
        await pumpFramedScene(tester, preview);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expectNoTestErrors(tester, 'smoke $previewId');
      }, timeout: const Timeout(Duration(seconds: 90)));
    }
  });
}
