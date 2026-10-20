// Home hero count (live-qa #2).
//
// Root cause: the landing pill counted `kStats.listedComponents`
// (`listed: true` only) but worded it as installable components, while the
// registry manifest holds 125 installable `components` entries (the
// `listed: false` entries — building blocks in `Utilities` and friends plus
// the `chart` component, which has its own Charts section — stay installable
// but unbrowsable).
// Fix: the pill now shows `kStats.components` (125) with the same
// "ready to install" wording, which honestly matches the installable set.

import 'package:docs/generated/docs_data.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  test('generated stats distinguish installable vs listed', () {
    expect(kStats.components, 125);
    expect(kStats.listedComponents, 89);
    expect(kStats.listedComponents, lessThan(kStats.components));
    expect(
      kComponents.length,
      kStats.components,
      reason: 'kStats.components counts every manifest entry',
    );
    expect(
      kComponents.where((DocsComponent c) => c.listed).length,
      kStats.listedComponents,
    );
  });

  testWidgets('landing pill shows the installable count', (tester) async {
    await pumpDocsApp(tester);
    expect(
      find.text('${kStats.components} components ready to install'),
      findsOneWidget,
    );
    expect(find.textContaining('89 components ready to install'), findsNothing);
  });
}
