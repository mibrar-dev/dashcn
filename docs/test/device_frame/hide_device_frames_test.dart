// Switch-aware check for the hidden device-frame picker (kShowDeviceFrames).

import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

Future<DocsRouterDelegate> _pump(WidgetTester tester) async {
  final DocsRouterDelegate delegate = await pumpDocsApp(tester);
  await goTo(tester, delegate, '/docs/components/button');
  return delegate;
}

void main() {
  testWidgets(
    'switch off: no frame chip renders and the preview has no frame',
    (WidgetTester tester) async {
      await _pump(tester);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey<String>('frame-bar-iphone')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey<String>('frame-bar-android')),
        findsNothing,
      );
      expect(docsState.frame, DeviceFrameId.none);
      expect(
        find.byKey(const ValueKey<String>('framed-button-iphone')),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
