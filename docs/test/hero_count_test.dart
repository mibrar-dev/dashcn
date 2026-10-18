// Home hero count (live-qa #2).
//
<<<<<<< HEAD
// Root cause: the landing pill counted `kStats.listedComponents` (86,
// `listed: true` only) but worded it as installable components, while the
// registry manifest holds 121 installable `components` entries (35
// `listed: false` building blocks in `Utilities` and friends stay
// installable but unbrowsable).
// Fix: the pill now shows `kStats.components` (121) with the same
=======
// Root cause: the landing pill counted `kStats.listedComponents` (85,
// `listed: true` only) but worded it as installable components, while the
// registry manifest holds 120 installable `components` entries (35
// `listed: false` building blocks in `Utilities` and friends stay
// installable but unbrowsable).
// Fix: the pill now shows `kStats.components` (120) with the same
>>>>>>> origin/main
// "ready to install" wording, which honestly matches the installable set.

import 'package:docs/generated/docs_data.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  test('generated stats distinguish installable vs listed', () {
<<<<<<< HEAD
    expect(kStats.components, 122);
    expect(kStats.listedComponents, 87);
=======
    expect(kStats.components, 122);
    expect(kStats.listedComponents, 87);
>>>>>>> origin/main
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
<<<<<<< HEAD
    expect(find.textContaining('86 components ready to install'), findsNothing);
=======
    expect(find.textContaining('85 components ready to install'), findsNothing);
>>>>>>> origin/main
  });
}
