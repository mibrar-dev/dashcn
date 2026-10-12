// Unit tests for the P8-2 codemod's allow-list masking: masked spans must
// hide every allow entry (2+ occurrences, mixed case) and unmask back to the
// exact original (no infinite loop, no text loss).
import 'package:flutter_test/flutter_test.dart';

import '../../tool/rename_api_passes.dart';

void main() {
  const List<String> allow = <String>[
    'design inspired by shadcn/ui.',
    'github.com/mibrar-dev/shadcn_flutter_kit',
  ];

  test('maskAllow hides every occurrence and unmaskAllow restores it', () {
    const String text =
        'See https://github.com/mibrar-dev/shadcn_flutter_kit for more. '
        'Design inspired by shadcn/ui. Second ref: '
        'GITHUB.COM/MIBRAR-DEV/SHADCN_FLUTTER_KIT plus '
        'design INSPIRED by SHADCN/UI. Tail.';
    final masked = maskAllow(text, allow);
    expect(masked.$2.toLowerCase(), isNot(contains('theme')));
    expect(unmaskAllow(masked.$2, masked.$1), text);
  });

  test('maskAllow with no match returns the text unchanged', () {
    const String text = 'plain words without the needle';
    final masked = maskAllow(text, allow);
    expect(masked.$1, isEmpty);
    expect(masked.$2, text);
    expect(unmaskAllow(masked.$2, masked.$1), text);
  });

  test('maskAllow with empty allow list is a no-op', () {
    const String text = 'mentions theme twice: theme';
    final masked = maskAllow(text, const <String>[]);
    expect(masked.$1, isEmpty);
    expect(masked.$2, text);
  });

  test('adjacent occurrences are each masked and restored', () {
    const String text =
        'github.com/mibrar-dev/shadcn_flutter_kit'
        'github.com/mibrar-dev/shadcn_flutter_kit';
    final masked = maskAllow(text, allow);
    expect(masked.$1.length, 2);
    expect(unmaskAllow(masked.$2, masked.$1), text);
  });
}
