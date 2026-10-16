// P7-H1 home fixes: the hero announcement pill hugs its label (upstream hero
// badge: inline-flex, px-3, h-7, text-sm) with the listed count, and the
// Support card is a working chat (send -> bubble -> typing -> canned reply,
// auto-scroll, counter badge, Send disabled while empty).

import 'package:docs/generated/docs_data.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/widgets/announcement.dart';
import 'package:docs/widgets/collage_home_media.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  testWidgets('announcement pill hugs its label with the listed count', (
    tester,
  ) async {
    await pumpDocsApp(tester, width: 1400);
    expect(
      find.text('${kStats.components} components ready to install'),
      findsOneWidget,
    );
    expect(kStats.components, greaterThan(kStats.listedComponents));

    final Finder pill = find.byType(Announcement);
    expect(pill, findsOneWidget);
    final Rect rect = tester.getRect(pill);
    // Hugs the text + arrow: far from the ~600 px stretched pill.
    expect(rect.width, lessThan(400));
    expect(rect.width, greaterThan(100));
    // h-7 (28 px box).
    expect(rect.height, moreOrLessEquals(28, epsilon: 3));
    // Centred in the hero.
    expect(((rect.left + rect.right) / 2 - 700).abs(), lessThan(2));
  });

  testWidgets('support card sends, types, replies; badge tracks count', (
    tester,
  ) async {
    await pumpDocsApp(tester, width: 1400);
    await tester.ensureVisible(find.byType(HomeChatCard));
    await tester.pumpAndSettle();

    final Finder card = find.byType(HomeChatCard);
    expect(card, findsOneWidget);
    final HomeChatCardState state = tester.state<HomeChatCardState>(card);
    expect(state.messages.length, 3);

    final Finder send = find.descendant(
      of: card,
      matching: find.widgetWithText(Button, 'Send'),
    );
    expect(tester.widget<Button>(send).enabled, isFalse);

    await tester.enterText(
      find.descendant(of: card, matching: find.byType(EditableText)),
      'hello agent',
    );
    await tester.pump();
    expect(state.canSend, isTrue);
    expect(tester.widget<Button>(send).enabled, isTrue);

    await tester.tap(send);
    await tester.pump();
    expect(find.text('hello agent'), findsOneWidget);
    expect(state.messages.length, 4);
    expect(
      find.descendant(of: card, matching: find.text('4')),
      findsOneWidget,
      reason: 'counter badge tracks the message count',
    );

    await tester.pump(const Duration(milliseconds: 800));
    expect(state.typing, isTrue, reason: 'typing indicator after ~800ms');
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump();
    expect(state.typing, isFalse);
    expect(state.messages.length, 5);
    expect(state.messages.last.$2, isFalse, reason: 'agent reply lands');
    expect(find.descendant(of: card, matching: find.text('5')), findsOneWidget);
  });
}
