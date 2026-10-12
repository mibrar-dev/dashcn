// End-to-end test for the `auth-01` flow.
//
// Walks every screen in light + dark and LTR + RTL: sign in (invalid then
// valid), OTP verify, forgot password, and sign up with social buttons.
// Asserts the callbacks fire with the right data.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/flows/auth-01/flow.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flows_support.dart';

const ValueKey<String> _signinEmail = ValueKey<String>('auth01.signin.email');
const ValueKey<String> _signinPassword = ValueKey<String>(
  'auth01.signin.password',
);
const ValueKey<String> _signupName = ValueKey<String>('auth01.signup.name');
const ValueKey<String> _signupEmail = ValueKey<String>('auth01.signup.email');
const ValueKey<String> _signupPassword = ValueKey<String>(
  'auth01.signup.password',
);
const ValueKey<String> _otpCode = ValueKey<String>('auth01.otp.code');
const ValueKey<String> _forgotEmail = ValueKey<String>('auth01.forgot.email');

void main() {
  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('walk ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        final signedIn = <List<String>>[];
        final signedUp = <List<String>>[];
        final verified = <String>[];
        final reset = <String>[];
        final social = <String>[];
        var otpDone = 0;
        await pumpFlow(
          tester,
          Auth01Flow(
            onSignIn: (String email, String password) async {
              signedIn.add(<String>[email, password]);
            },
            onSignUp: (String name, String email, String password) async {
              signedUp.add(<String>[name, email, password]);
            },
            onVerifyOtp: (String code) async => verified.add(code),
            onResetPassword: (String email) async => reset.add(email),
            onSocialSignIn: (String provider) async => social.add(provider),
            onOtpVerified: () => otpDone++,
          ),
          brightness: brightness,
          direction: direction,
        );

        // Sign in: an invalid submit stays, a valid one reaches OTP.
        expect(find.text('Sign in'), findsWidgets);
        await tester.tap(find.text('Sign in').last);
        await flowSettle(tester);
        expect(signedIn, isEmpty);
        expect(find.text('Check your inbox'), findsNothing);
        await tester.enterText(fieldOf(_signinEmail), 'ada@example.com');
        await tester.enterText(fieldOf(_signinPassword), 'password123');
        await tester.tap(find.text('Sign in').last);
        await flowSettle(tester);
        expect(signedIn, <List<String>>[
          <String>['ada@example.com', 'password123'],
        ]);
        expect(find.text('Check your inbox'), findsOneWidget);

        // OTP: completing the code verifies.
        await tester.enterText(fieldOf(_otpCode), '123456');
        await flowSettle(tester);
        expect(verified, <String>['123456']);
        expect(otpDone, 1);
        expect(find.text('Code verified. You are signed in.'), findsOneWidget);
        await tester.tap(find.text('Back'));
        await flowSettle(tester);

        // Forgot password: valid email sends the link.
        await tester.tap(find.text('Forgot password?'));
        await flowSettle(tester);
        expect(find.text('Reset password'), findsOneWidget);
        await tester.enterText(fieldOf(_forgotEmail), 'ada@example.com');
        await tester.tap(find.text('Send reset link'));
        await flowSettle(tester);
        expect(reset, <String>['ada@example.com']);
        expect(
          find.text('Reset link sent. Check your inbox to continue.'),
          findsOneWidget,
        );
        await tester.tap(find.text('Back to sign in'));
        await flowSettle(tester);

        // Social button reports the provider.
        await tester.tap(find.text('Continue with Google'));
        await flowSettle(tester);
        expect(social, <String>['google']);

        // Sign up: valid form signs up and reaches OTP.
        await tester.tap(find.text('Create one'));
        await flowSettle(tester);
        expect(find.text('Create an account'), findsOneWidget);
        await tester.enterText(fieldOf(_signupName), 'Ada Lovelace');
        await tester.enterText(fieldOf(_signupEmail), 'ada@example.com');
        await tester.enterText(fieldOf(_signupPassword), 'password123');
        await tester.tap(find.text('Create account'));
        await flowSettle(tester);
        expect(signedUp, <List<String>>[
          <String>['Ada Lovelace', 'ada@example.com', 'password123'],
        ]);
        expect(find.text('Check your inbox'), findsOneWidget);
      });
    }
  }

  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('form errors show only after submit ${brightness.name} '
          '${direction.name}', (WidgetTester tester) async {
        await pumpFlow(
          tester,
          Auth01Flow(),
          brightness: brightness,
          direction: direction,
        );

        // Sign in starts pristine; an empty submit reveals the errors.
        expect(find.text('This field cannot be empty.'), findsNothing);
        await tester.tap(find.text('Sign in').last);
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsWidgets);

        // Sign up starts pristine; an empty submit reveals the errors.
        await tester.tap(find.text('Create one'));
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsNothing);
        await tester.tap(find.text('Create account'));
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsWidgets);

        // OTP has no validator, so it never shows an error.
        await tester.enterText(fieldOf(_signupName), 'Ada Lovelace');
        await tester.enterText(fieldOf(_signupEmail), 'ada@example.com');
        await tester.enterText(fieldOf(_signupPassword), 'password123');
        await tester.tap(find.text('Create account'));
        await flowSettle(tester);
        expect(find.text('Check your inbox'), findsOneWidget);
        expect(find.text('This field cannot be empty.'), findsNothing);
        await tester.tap(find.text('Back'));
        await flowSettle(tester);

        // Back lands on sign up; pop once more to sign in, then forgot.
        await tester.tap(find.text('Sign in').last);
        await flowSettle(tester);
        // Forgot password starts pristine; empty submit reveals the error.
        await tester.tap(find.text('Forgot password?'));
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsNothing);
        await tester.tap(find.text('Send reset link'));
        await flowSettle(tester);
        expect(find.text('This field cannot be empty.'), findsWidgets);
      });
    }
  }
}
