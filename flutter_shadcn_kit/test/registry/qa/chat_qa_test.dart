// QA for `chat` previews (P7-Q1).
//
// Regression cover for: reaction chips ignoring keyboard/focus (raw
// GestureDetector → Clickable), the borderless tail nub, the dead
// `avatarAlignment` widget leg, and unscaled reaction metrics.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/button/button.dart';
import 'package:flutter_shadcn_kit/registry/components/chat/chat.dart';
import 'package:flutter_shadcn_kit/registry/components/chat/preview.dart';
import 'package:flutter_shadcn_kit/registry/foundation/component_preview.dart';
import 'package:flutter_shadcn_kit/registry/primitives/clickable.dart';
import 'package:flutter_shadcn_kit/registry/theme/color_tokens.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  ShadcnThemeData data = const ShadcnThemeData(),
  double? width,
}) {
  return ShadcnTheme(
    data: data,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: width == null ? child : SizedBox(width: width, child: child),
      ),
    ),
  );
}

void main() {
  testWidgets('every preview pumps light + dark with no exception', (
    tester,
  ) async {
    for (final preview in chatPreviews) {
      for (final colors in <ShadcnColors>[
        ShadcnColors.lightFallback,
        ShadcnColors.darkFallback,
      ]) {
        await tester.pumpWidget(
          _frame(
            Builder(builder: preview.builder),
            data: ShadcnThemeData(colors: colors),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: '${preview.name} light/dark',
        );
      }
    }
  });

  testWidgets('reaction chip activates by tap and by keyboard', (tester) async {
    int taps = 0;
    await tester.pumpWidget(
      _frame(
        ChatReactionContainer(onTap: () => taps++, child: const Text('x')),
      ),
    );
    await tester.pump();
    await tester.tap(find.byType(ChatReactionContainer));
    expect(taps, 1);
    final Element element = tester.element(find.text('x'));
    Focus.of(element).requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(taps, 2);
  });

  testWidgets('reaction chip without onTap builds no Clickable', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(const ChatReactionContainer(child: Text('x'))),
    );
    await tester.pump();
    expect(find.byType(Clickable), findsNothing);
  });

  testWidgets('widget avatarAlignment reaches the avatars', (tester) async {
    await tester.pumpWidget(
      _frame(
        const ChatGroup(
          avatarAlignment: AlignmentDirectional.bottomCenter,
          avatarPrefix: Text('A'),
          children: <Widget>[ChatBubble(child: Text('hi'))],
        ),
      ),
    );
    await tester.pump();
    final Align align = tester.widget<Align>(
      find
          .descendant(of: find.byType(ChatGroup), matching: find.byType(Align))
          .first,
    );
    expect(align.alignment, AlignmentDirectional.bottomCenter);
  });

  testWidgets('grouped preview fits 375px', (tester) async {
    await tester.pumpWidget(
      _frame(Builder(builder: chatPreviews[3].builder), width: 375),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('live preview sends, types, then replies (fake async)', (
    tester,
  ) async {
    final ComponentPreview live = chatPreviews.firstWhere(
      (ComponentPreview preview) => preview.name == 'Live',
    );
    // An Overlay ancestor: the composer is an EditableText, which builds its
    // selection overlay on focus.
    await tester.pumpWidget(
      _frame(Overlay.wrap(child: Builder(builder: live.builder)), width: 560),
    );
    await tester.pumpAndSettle();

    Button send() => tester.widget<Button>(find.widgetWithText(Button, 'Send'));
    expect(send().enabled, isFalse, reason: 'Send disabled while empty');

    await tester.enterText(find.byType(EditableText), 'hello agent');
    await tester.pump();
    expect(send().enabled, isTrue);

    await tester.tap(find.text('Send'));
    await tester.pump();
    expect(find.text('hello agent'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 800));
    expect(
      find.textContaining('pulling up your payout'),
      findsNothing,
      reason: 'typing indicator first, reply after',
    );
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump();
    expect(
      find.textContaining('pulling up your payout'),
      findsOneWidget,
      reason: 'canned agent reply lands',
    );
  });
}
