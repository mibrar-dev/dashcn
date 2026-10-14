// P7-BF1: no form block opens with its validation errors already on screen.
//
// The user report: login-01 rendered "This field cannot be empty." under both
// Email and Password before anything was typed. A block must look like an
// untouched form on first paint — messages appear only after the user edits a
// field or presses the submit button.
//
// The assertion is structural rather than a list of message strings: every
// form layout renders its feedback through `FormFieldMessages`, so a fresh
// render must not contain one with a non-null message. That holds for any
// validator, localized or custom.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/blocks/account-01/account_01.dart';
import 'package:dashcn/src/blocks/account-02/account_02.dart';
import 'package:dashcn/src/blocks/login-01/login_01.dart';
import 'package:dashcn/src/blocks/login-02/login_02.dart';
import 'package:dashcn/src/blocks/login-03/login_03.dart';
import 'package:dashcn/src/blocks/otp-01/otp_01.dart';
import 'package:dashcn/src/blocks/pricing-01/pricing_01.dart';
import 'package:dashcn/src/blocks/signup-01/signup_01.dart';
import 'package:dashcn/src/blocks/signup-02/signup_02.dart';
import 'package:dashcn/src/components/form/form.dart';
import 'package:flutter_test/flutter_test.dart';

import 'blocks_support.dart';

/// Whether any field in [tester] is currently showing a validation message.
bool _showsAnyFieldMessage(WidgetTester tester) {
  for (final Element element in find.byType(FormFieldMessages).evaluate()) {
    final FormFieldMessages messages = element.widget as FormFieldMessages;
    if (messages.message != null) {
      return true;
    }
  }
  return false;
}

/// Pumps [block] at the stage size and asserts no field shows a message.
Future<void> expectSilent(WidgetTester tester, Widget block) async {
  await pumpForm(tester, block);
  await tester.pump();
  expect(_showsAnyFieldMessage(tester), isFalse, reason: 'first paint');
  expect(tester.takeException(), isNull);
}

/// Pumps [block] under the neutral light preset at tablet width.
Future<void> pumpForm(WidgetTester tester, Widget block) async {
  await pumpBlock(tester, block, blockTheme('neutral', Brightness.light), 768);
}

void main() {
  group('P7-BF1 fresh render', () {
    testWidgets('login-01 shows no field message', (tester) async {
      await expectSilent(tester, const Login01());
      // The exact strings from the user report.
      expect(find.text('This field cannot be empty.'), findsNothing);
    });

    testWidgets('login-02 shows no field message', (tester) async {
      await expectSilent(tester, const Login02());
    });

    testWidgets('login-03 shows no field message', (tester) async {
      await expectSilent(tester, const Login03());
    });

    testWidgets('otp-01 shows no field message', (tester) async {
      await expectSilent(tester, const Otp01());
      // The block runs a resend countdown timer; drop it afterwards.
      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('signup-01 shows no field message', (tester) async {
      await expectSilent(tester, const Signup01());
    });

    testWidgets('signup-02 shows no field message', (tester) async {
      await expectSilent(tester, const Signup02());
    });

    testWidgets('account-01 shows no field message', (tester) async {
      await expectSilent(tester, const Account01());
    });

    testWidgets('account-02 shows no field message', (tester) async {
      await expectSilent(tester, const Account02());
    });

    testWidgets('pricing-01 shows no field message', (tester) async {
      await expectSilent(tester, const Pricing01());
    });
  });
}
