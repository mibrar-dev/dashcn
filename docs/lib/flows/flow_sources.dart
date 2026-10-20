// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Sources:
//   * dashcn/lib/src/flows/<id>/<file>.dart
//
// Regenerate: dart run tool/gen_docs_data.dart
//
// The Flows code view: one file per flow, verbatim, with the same
// 4-class highlight map the README snippets use (`p`/`c`/`k`/`s`,
// one class per character). Imported by the deferred Flows pages.

/// One flow file: its install-root-relative path and source.
class DocsFlowFile {
  /// Creates a flow file entry.
  const DocsFlowFile({
    required this.path,
    required this.code,
    required this.tokenClasses,
  });

  /// Install-root-relative path (`lib/ui/dashcn/flows/…`).
  final String path;

  /// File source, verbatim.
  final String code;

  /// One highlight class per character of [code].
  final String tokenClasses;

  /// File name without its flow-directory prefix.
  String get name => path.split('/').last;
}

/// Flow files keyed by flow id, in manifest `files` order.
const Map<String, List<DocsFlowFile>>
kFlowFileSources = <String, List<DocsFlowFile>>{
  'auth-01': <DocsFlowFile>[
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/flow.dart',
      code:
          r'''// The `auth-01` flow: sign in, sign up, OTP verify and forgot password.
//
// Entry: [Auth01Flow] owns a nested [Navigator] (`/`, `/signup`, `/otp`,
// `/forgot`). Credentials and results travel through callbacks; the kit
// holds no backend and no demo accounts. Screens navigate with their own
// context, so pushes land on the nested navigator.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';

/// Sign in / sign up / OTP / forgot-password flow with social buttons.
class Auth01Flow extends StatelessWidget {
  /// Creates the flow.
  const Auth01Flow({
    super.key,
    this.onSignIn,
    this.onSignUp,
    this.onVerifyOtp,
    this.onResetPassword,
    this.onSocialSignIn,
    this.onOtpVerified,
    this.initialScreen = '/',
  });

  /// Called with a valid sign-in form; then the flow shows the OTP screen.
  final Future<void> Function(String email, String password)? onSignIn;

  /// Called with a valid sign-up form; then the flow shows the OTP screen.
  final Future<void> Function(String name, String email, String password)?
  onSignUp;

  /// Called when a full OTP code completes.
  final Future<void> Function(String code)? onVerifyOtp;

  /// Called with a valid forgot-password form.
  final Future<void> Function(String email)? onResetPassword;

  /// Called with the provider id (`google`, `apple`) of a social button.
  final Future<void> Function(String provider)? onSocialSignIn;

  /// Called after [onVerifyOtp] completes.
  final VoidCallback? onOtpVerified;

  /// Initial route of the nested navigator (`/`, `/signup`, `/otp`,
  /// `/forgot`); the screen map drives this to jump to a screen.
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/signup':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Auth01SignUpScreen(
                onSignUp: onSignUp,
                onSocialSignIn: onSocialSignIn,
              ),
            );
          case '/otp':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Auth01OtpScreen(
                onVerify: onVerifyOtp,
                onVerified: onOtpVerified,
              ),
            );
          case '/forgot':
            return AppPageRoute(
              settings: settings,
              builder: (_) =>
                  Auth01ForgotPasswordScreen(onResetPassword: onResetPassword),
            );
          case '/':
          default:
            return AppPageRoute(
              settings: settings,
              builder: (_) => Auth01SignInScreen(
                onSignIn: onSignIn,
                onSocialSignIn: onSocialSignIn,
              ),
            );
        }
      },
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccpcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpsssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssspppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccpppkkkkkppppppppppppppppppkkkkkppppppppppkkkkpppppppppppppppkkkkpppppppppppppppkkkkppppppppppppppppppkkkkppppppppppppppppppppppkkkkpppppppppppppppppppppkkkkppppppppppppppppppppkkkkpppppppppppppppppssspppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppkkkkpsssssssssppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpssssssppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpsssssssssppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpsssppppppppppppkkkkkkkppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/screens/forgot_password_screen.dart',
      code:
          r'''// Forgot-password screen of the `auth-01` flow: email form, then a
// confirmation once [Auth01ForgotPasswordScreen.onResetPassword] runs.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';

/// Forgot-password form with a sent-state.
class Auth01ForgotPasswordScreen extends StatefulWidget {
  /// Creates the forgot-password screen.
  const Auth01ForgotPasswordScreen({super.key, this.onResetPassword});

  /// Called with the validated email.
  final Future<void> Function(String email)? onResetPassword;

  @override
  State<Auth01ForgotPasswordScreen> createState() =>
      _Auth01ForgotPasswordScreenState();
}

class _Auth01ForgotPasswordScreenState
    extends State<Auth01ForgotPasswordScreen> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  bool _busy = false;
  bool _sent = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final SubmissionResult result = await _controller.submit(context);
    if (!result.isValid || !mounted) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onResetPassword?.call(
        result.values.getValue(_emailKey) ?? '',
      );
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _sent = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: 'Reset password',
      subtitle: 'We will email you a reset link.',
      children: <Widget>[
        if (_sent)
          Text(
            'Reset link sent. Check your inbox to continue.',
            style: appTheme.typography.textSmall.copyWith(
              color: appTheme.colors.primary,
            ),
          )
        else
          FormScope(
            controller: _controller,
            child: FormItem<String>(
              key: _emailKey,
              label: const Text('Email'),
              validator: const NotEmptyValidator() & const EmailValidator(),
              // Errors surface on submit only: the mount-time report lands as
              // `changed`, so including it would flag pristine fields.
              showErrors: const <FormValidationMode>{
                FormValidationMode.submitted,
              },
              child: const Input(
                key: ValueKey<String>('auth01.forgot.email'),
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        Gap(appTheme.spacing.lg),
        if (!_sent)
          Button(
            onPressed: _busy ? null : _submit,
            child: Text(_busy ? 'Sending…' : 'Send reset link'),
          ),
        Gap(appTheme.spacing.sm),
        Button(
          variant: ButtonVariant.ghost,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back to sign in'),
        ),
      ],
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpssssssssssssssspppcccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppkkkkkppppppkkkkpppppppppppppppppppppppccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssssppppppppppppppppppkkkkkpppppppppppppppppkkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkppppppppppppkkkkkpppppppkkkkkpppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsspppppppppppppppppkkkkkkkpppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppssssssssssssssssppppppppppppppppppsssssssssssssssssssssssssssssssssppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppssssssssssssssssssssssssssssssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssspppppppppppppppppppppppppppppsssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppsssssssssspppsssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppkkkkkppppppssssssssssssssssspppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/screens/otp_screen.dart',
      code:
          r'''// OTP screen of the `auth-01` flow: six-slot code entry with resend.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/input_otp/input_otp.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';

/// OTP verify form; completing the code calls [onVerify] then [onVerified].
class Auth01OtpScreen extends StatefulWidget {
  /// Creates the OTP screen.
  const Auth01OtpScreen({super.key, this.onVerify, this.onVerified});

  /// Called with the completed code.
  final Future<void> Function(String code)? onVerify;

  /// Called after [onVerify] completes.
  final VoidCallback? onVerified;

  @override
  State<Auth01OtpScreen> createState() => _Auth01OtpScreenState();
}

class _Auth01OtpScreenState extends State<Auth01OtpScreen> {
  bool _done = false;
  bool _busy = false;

  Future<void> _completed(String code) async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onVerify?.call(code);
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _done = true;
        });
      }
    }
    widget.onVerified?.call();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: 'Check your inbox',
      subtitle: 'Enter the 6-digit code we sent you.',
      children: <Widget>[
        InputOtp(
          key: const ValueKey<String>('auth01.otp.code'),
          length: 6,
          onCompleted: _completed,
        ),
        Gap(appTheme.spacing.md),
        if (_done)
          Text(
            'Code verified. You are signed in.',
            style: appTheme.typography.textSmall.copyWith(
              color: appTheme.colors.primary,
            ),
          ),
        if (_done) Gap(appTheme.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                "Didn't get a code?",
                style: appTheme.typography.textSmall.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ),
            Gap(appTheme.spacing.xs),
            Button(
              variant: ButtonVariant.link,
              size: ButtonSize.sm,
              onPressed: () {},
              child: Text(_busy ? 'Sending…' : 'Resend'),
            ),
          ],
        ),
        Gap(appTheme.spacing.sm),
        Button(
          variant: ButtonVariant.ghost,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
        ),
      ],
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccpppkkkkkppppppppppppppppppkkkkkppppppkkkkpppppppppppkkkkppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppkkkkkppppppppppppkkkkppppppppppppppppppppppppppkkkkkpppppppkkpppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppkkkkkkkpppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppssssssssssssssssssppppppppppppppppppssssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppsssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssspppssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppkkkkkppppppsssssspppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/screens/scaffold.dart',
      code:
          r'''// Shared chrome of the `auth-01` flow screens: centred 400px card column.

import 'package:flutter/widgets.dart';

import '../../../components/card/card.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Centred card column used by every auth screen.
class Auth01Scaffold extends StatelessWidget {
  /// Creates the shared auth chrome.
  const Auth01Scaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  /// Headline of the screen.
  final String title;

  /// Supporting text of the screen.
  final String subtitle;

  /// Form rows and actions of the screen.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Card(
                padding: EdgeInsets.all(appTheme.spacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(title, style: appTheme.typography.h3),
                    Gap(appTheme.spacing.xs),
                    Text(
                      subtitle,
                      style: appTheme.typography.textMuted.copyWith(
                        color: appTheme.colors.mutedForeground,
                      ),
                    ),
                    Gap(appTheme.spacing.xl),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkkkkkpkkkkppppppppppppppppppppcccccccccccccccccccccccccccpppkkkkkppppppppppppppppppccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/screens/sign_in_screen.dart',
      code:
          r'''// Sign-in screen of the `auth-01` flow: validated email/password, social
// buttons, and links to sign up and forgot password.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';
import 'social_buttons.dart';

/// Sign-in form; a valid submit calls [onSignIn] then shows `/otp`.
class Auth01SignInScreen extends StatefulWidget {
  /// Creates the sign-in screen.
  const Auth01SignInScreen({super.key, this.onSignIn, this.onSocialSignIn});

  /// Called with the validated credentials.
  final Future<void> Function(String email, String password)? onSignIn;

  /// Called with the provider id of a social button.
  final Future<void> Function(String provider)? onSocialSignIn;

  @override
  State<Auth01SignInScreen> createState() => _Auth01SignInScreenState();
}

class _Auth01SignInScreenState extends State<Auth01SignInScreen> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final SubmissionResult result = await _controller.submit(context);
    if (!result.isValid || !mounted) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onSignIn?.call(
        result.values.getValue(_emailKey) ?? '',
        result.values.getValue(_passwordKey) ?? '',
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
    if (mounted) {
      Navigator.of(context).pushNamed('/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: 'Sign in',
      subtitle: 'Enter your credentials to continue.',
      children: <Widget>[
        FormScope(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormItem<String>(
                key: _emailKey,
                label: const Text('Email'),
                validator: const NotEmptyValidator() & const EmailValidator(),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signin.email'),
                  hintText: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Gap(appTheme.spacing.md),
              FormItem<String>(
                key: _passwordKey,
                label: const Text('Password'),
                validator:
                    const NotEmptyValidator() & const LengthValidator(min: 8),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signin.password'),
                  hintText: '••••••••',
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        Gap(appTheme.spacing.md),
        Align(
          alignment: Alignment.centerRight,
          child: Button(
            variant: ButtonVariant.link,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pushNamed('/forgot'),
            child: const Text('Forgot password?'),
          ),
        ),
        Gap(appTheme.spacing.sm),
        Button(
          onPressed: _busy ? null : _submit,
          child: Text(_busy ? 'Signing in…' : 'Sign in'),
        ),
        Gap(appTheme.spacing.lg),
        Auth01SocialButtons(onSocialSignIn: widget.onSocialSignIn),
        Gap(appTheme.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                'No account yet?',
                style: appTheme.typography.textSmall.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ),
            Gap(appTheme.spacing.xs),
            Button(
              variant: ButtonVariant.link,
              size: ButtonSize.sm,
              onPressed: () => Navigator.of(context).pushNamed('/signup'),
              child: const Text('Create one'),
            ),
          ],
        ),
      ],
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssssppkkkkkkpssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppkkkkkppppppkkkkpppppppppppkkkkppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppkkkkkpppppppppppppppppssssssspppppkkkkkppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppssssssssssppppppppppppppppppkkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkppppppppppppkkkkkpppppppkkkkkpppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssppppppppppppppppppppppppppppppppppppppppppppppppppsspppppppppppppppppkkkkkkkpppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppkkpppppppppppppppppppppppppppppkkppppppppppppppppppppsssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppsssssssssppppppppppppppppppsssssssssssssssssssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssspppppppppppppppppppppppppppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssssspppppppppppppppppppppppppppppppsssssssssspppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppsssssssssppppppppppppppppppppppkkkkkppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppssssssssssssspppssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppsssssssssppppppppppppppppppppppppkkkkkppppppsssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/screens/sign_up_screen.dart',
      code:
          r'''// Sign-up screen of the `auth-01` flow: name, email and password with the
// same validators as sign in, then `/otp`.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';
import 'social_buttons.dart';

/// Sign-up form; a valid submit calls [onSignUp] then shows `/otp`.
class Auth01SignUpScreen extends StatefulWidget {
  /// Creates the sign-up screen.
  const Auth01SignUpScreen({super.key, this.onSignUp, this.onSocialSignIn});

  /// Called with the validated values.
  final Future<void> Function(String name, String email, String password)?
  onSignUp;

  /// Called with the provider id of a social button.
  final Future<void> Function(String provider)? onSocialSignIn;

  @override
  State<Auth01SignUpScreen> createState() => _Auth01SignUpScreenState();
}

class _Auth01SignUpScreenState extends State<Auth01SignUpScreen> {
  final FormController _controller = FormController();
  final FormKey<String> _nameKey = const FormKey<String>('name');
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final SubmissionResult result = await _controller.submit(context);
    if (!result.isValid || !mounted) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onSignUp?.call(
        result.values.getValue(_nameKey) ?? '',
        result.values.getValue(_emailKey) ?? '',
        result.values.getValue(_passwordKey) ?? '',
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
    if (mounted) {
      Navigator.of(context).pushNamed('/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: 'Create an account',
      subtitle: 'One account for everything.',
      children: <Widget>[
        FormScope(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormItem<String>(
                key: _nameKey,
                label: const Text('Name'),
                validator: const NotEmptyValidator(),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signup.name'),
                  hintText: 'Ada Lovelace',
                ),
              ),
              Gap(appTheme.spacing.md),
              FormItem<String>(
                key: _emailKey,
                label: const Text('Email'),
                validator: const NotEmptyValidator() & const EmailValidator(),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signup.email'),
                  hintText: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Gap(appTheme.spacing.md),
              FormItem<String>(
                key: _passwordKey,
                label: const Text('Password'),
                hint: const Text('At least 8 characters.'),
                validator:
                    const NotEmptyValidator() & const LengthValidator(min: 8),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signup.password'),
                  hintText: '••••••••',
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        Gap(appTheme.spacing.lg),
        Button(
          onPressed: _busy ? null : _submit,
          child: Text(_busy ? 'Creating…' : 'Create account'),
        ),
        Gap(appTheme.spacing.lg),
        Auth01SocialButtons(onSocialSignIn: widget.onSocialSignIn),
        Gap(appTheme.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                'Have an account?',
                style: appTheme.typography.textSmall.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ),
            Gap(appTheme.spacing.xs),
            Button(
              variant: ButtonVariant.link,
              size: ButtonSize.sm,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sign in'),
            ),
          ],
        ),
      ],
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssssppkkkkkkpssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppkkkkkppppppkkkkpppppppppppkkkkppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssspppppkkkkkpppppppppppppppppppppppppppppkkkkkpppppppppppppppppssssssspppppkkkkkppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppssssssssssppppppppppppppppppkkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkppppppppppppkkkkkpppppppkkkkkpppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsspppppppppppppppppppppppppppppppppppppppppppppppssppppppppppppppppppppppppppppppppppppppppppppppppppsspppppppppppppppppkkkkkkkpppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppkkpppppppppppppppppppppppppppppkkppppppppppppppppppppsssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppsssssssssssssssssssppppppppppppppppppssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssspppppppppppppppppppppppppppppppsssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssspppppppppppppppppppppppppppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssssspppppppppppppppppppppppppkkkkkppppppssssssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssssspppppppppppppppppppppppppppppppsssssssssspppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppssssssssssspppsssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/auth-01/screens/social_buttons.dart',
      code:
          r'''// Social buttons shared by the sign-in and sign-up screens of `auth-01`.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Google / Apple buttons reporting the provider id.
class Auth01SocialButtons extends StatelessWidget {
  /// Creates the social buttons.
  const Auth01SocialButtons({super.key, this.onSocialSignIn});

  /// Called with `google` or `apple`.
  final Future<void> Function(String provider)? onSocialSignIn;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Button(
          variant: ButtonVariant.outline,
          onPressed: () => onSocialSignIn?.call('google'),
          child: const Text('Continue with Google'),
        ),
        Gap(appTheme.spacing.sm),
        Button(
          variant: ButtonVariant.outline,
          onPressed: () => onSocialSignIn?.call('apple'),
          child: const Text('Continue with Apple'),
        ),
      ],
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppcccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppkkkkkppppppkkkkppppppppppppppppppppppccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssppppppppppppppppppppkkkkkppppppssssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssppppppppppppppppppppkkkkkppppppssssssssssssssssssssspppppppppppppppppppppppppppppppppppp',
    ),
  ],
  'chat-01': <DocsFlowFile>[
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/chat-01/flow.dart',
      code:
          r'''// The `chat-01` flow: thread list with swipe actions + pull-to-refresh, a
// conversation with bubbles + composer, and an attachments sheet.
//
// Entry: [Chat01Flow] owns a nested [Navigator] (`/`, `/thread`). Threads
// and messages come in as data; sends, refreshes and attachments leave
// through callbacks. The kit holds no chat backend and no demo threads.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/conversation_screen.dart';
import 'screens/thread_list_screen.dart';

/// One conversation of [Chat01Flow].
class Chat01Thread {
  /// Creates a thread.
  const Chat01Thread({
    required this.id,
    required this.name,
    required this.initials,
    required this.lastMessage,
    this.unread = 0,
  });

  /// Stable id used to look up messages and report actions.
  final String id;

  /// Display name of the thread.
  final String name;

  /// Avatar fallback initials.
  final String initials;

  /// Preview line shown under the name.
  final String lastMessage;

  /// Unread badge count; zero hides the badge.
  final int unread;
}

/// One message of a conversation.
class Chat01Message {
  /// Creates a message.
  const Chat01Message({required this.text, required this.mine});

  /// Message text.
  final String text;

  /// Whether the bubble aligns to the local user.
  final bool mine;
}

/// Thread list → conversation with attachments.
class Chat01Flow extends StatelessWidget {
  /// Creates the flow.
  const Chat01Flow({
    super.key,
    this.threads = const <Chat01Thread>[
      Chat01Thread(
        id: 'studio',
        name: 'Design studio',
        initials: 'DS',
        lastMessage: 'The new mockups are ready.',
        unread: 2,
      ),
      Chat01Thread(
        id: 'ada',
        name: 'Ada Lovelace',
        initials: 'AL',
        lastMessage: 'See you at the demo!',
      ),
    ],
    this.messages = const <String, List<Chat01Message>>{
      'studio': <Chat01Message>[
        Chat01Message(text: 'Morning! Did the review land?', mine: false),
        Chat01Message(text: 'Just sent the new mockups.', mine: true),
        Chat01Message(text: 'The new mockups are ready.', mine: false),
      ],
      'ada': <Chat01Message>[
        Chat01Message(text: 'See you at the demo!', mine: false),
      ],
    },
    this.onRefresh,
    this.onSend,
    this.onAttach,
    this.onThreadMuted,
    this.onThreadDeleted,
    this.initialScreen = '/',
  });

  /// Starting threads; the list screen owns a mutable copy.
  final List<Chat01Thread> threads;

  /// Starting messages per thread id.
  final Map<String, List<Chat01Message>> messages;

  /// Called on pull-to-refresh.
  final Future<void> Function()? onRefresh;

  /// Called with the thread id + composer text on send.
  final Future<void> Function(String threadId, String text)? onSend;

  /// Called with the thread id + attachment kind (`photo`, `file`).
  final Future<void> Function(String threadId, String kind)? onAttach;

  /// Called with the muted thread.
  final ValueChanged<Chat01Thread>? onThreadMuted;

  /// Called with the deleted thread.
  final ValueChanged<Chat01Thread>? onThreadDeleted;

  /// Initial route of the nested navigator (`/`).
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/thread') {
          // A bare `/thread` (e.g. a docs screen-map jump with no thread
          // yet) falls back to the thread list instead of throwing.
          final Object? args = settings.arguments;
          if (args is! Chat01Thread) {
            return AppPageRoute(
              settings: settings,
              builder: (_) => Chat01ThreadListScreen(
                threads: threads,
                onRefresh: onRefresh,
                onThreadMuted: onThreadMuted,
                onThreadDeleted: onThreadDeleted,
              ),
            );
          }
          final Chat01Thread thread = args;
          return AppPageRoute(
            settings: settings,
            builder: (_) => Chat01ConversationScreen(
              thread: thread,
              messages: messages[thread.id] ?? const <Chat01Message>[],
              onSend: onSend,
              onAttach: onAttach,
            ),
          );
        }
        return AppPageRoute(
          settings: settings,
          builder: (_) => Chat01ThreadListScreen(
            threads: threads,
            onRefresh: onRefresh,
            onThreadMuted: onThreadMuted,
            onThreadDeleted: onThreadDeleted,
          ),
        );
      },
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpsssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssspppcccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppcccccccccccccccccccccpppkkkkkppppppppppppppppppppkkkkkkkkpkkkkpppppppppkkkkkkkkpkkkkpppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkkkkkpkkkkppppppppppppppppppkkkkppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppcccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppccccccccccccccccccccccpppkkkkkppppppppppppppppkkkkkkkkpkkkkpppppppkkkkkkkkpkkkkppppppppppppcccccccccccccccccpppkkkkkpppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccpppkkkkkppppppppppppppppppkkkkkppppppppppkkkkpppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppssssssssppppppppppppppppsssssssssssssssppppppppppppppppppppsssspppppppppppppppppppppppssssssssssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssppppppppppppppppssssssssssssssppppppppppppppppppppsssspppppppppppppppppppppppssssssssssssssssssssssppppppppppppppppppppppkkkkppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppsssssssspppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssssssssssssppppppppkkkkkpppppppppppppppppppppppppppppppssssssssssssssssssssssssssssppppppppkkkkpppppppppppppppppppppppppppppppssssssssssssssssssssssssssssppppppppkkkkkppppppppppppppppppssssspppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssppppppppkkkkkpppppppppppppppppppppppkkkkppppppppppppppppkkkkpppppppppppppkkkkpppppppppppppppkkkkppppppppppppppppppppkkkkppppppppppppppppppppppkkkkpppppppppppppppppssspppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppsssssssssppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppkkpppppppkkppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/chat-01/screens/attachments_sheet.dart',
      code:
          r'''// Attachments sheet body of the `chat-01` flow: photo / file pickers shown
// inside the conversation's [PinnedSheet].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Attachment kinds; picking reports [onPick] and closes via [onClose].
class Chat01AttachmentsSheet extends StatelessWidget {
  /// Creates the attachments sheet body.
  const Chat01AttachmentsSheet({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onPick,
  });

  /// Sheet controller for the Close button.
  final SheetController controller;

  /// Hides the sheet.
  final VoidCallback onClose;

  /// Called with `photo` or `file`.
  final Future<void> Function(String kind) onPick;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Attach', style: appTheme.typography.h3),
          Gap(appTheme.spacing.md),
          Button(
            key: const ValueKey<String>('chat01.attach.photo'),
            variant: ButtonVariant.outline,
            onPressed: () => onPick('photo'),
            child: const Text('Photo'),
          ),
          Gap(appTheme.spacing.sm),
          Button(
            key: const ValueKey<String>('chat01.attach.file'),
            variant: ButtonVariant.outline,
            onPressed: () => onPick('file'),
            child: const Text('File'),
          ),
          Gap(appTheme.spacing.sm),
          Button(
            variant: ButtonVariant.ghost,
            onPressed: () {
              controller.close();
              onClose();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkpppppppppppppppppkkkkkkkkpkkkkppppppppppppppkkkkkkkkpkkkkppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssppppppppppppppppppppppkkkkkppppppssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppsssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssppppppppppppppppppppppkkkkkppppppsssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/chat-01/screens/conversation_screen.dart',
      code:
          r'''// Conversation screen of the `chat-01` flow: chat bubbles, a composer and
// an attachments sheet.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/chat/chat.dart';
import '../../../components/drawer_container/drawer_container.dart';
import '../../../components/input/input.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import 'attachments_sheet.dart';

/// Conversation with composer; attach opens the attachments sheet.
class Chat01ConversationScreen extends StatefulWidget {
  /// Creates the conversation screen.
  const Chat01ConversationScreen({
    super.key,
    required this.thread,
    required this.messages,
    this.onSend,
    this.onAttach,
  });

  /// Thread being shown.
  final Chat01Thread thread;

  /// Starting messages.
  final List<Chat01Message> messages;

  /// Called with the thread id + composer text on send.
  final Future<void> Function(String threadId, String text)? onSend;

  /// Called with the thread id + attachment kind.
  final Future<void> Function(String threadId, String kind)? onAttach;

  @override
  State<Chat01ConversationScreen> createState() =>
      _Chat01ConversationScreenState();
}

class _Chat01ConversationScreenState extends State<Chat01ConversationScreen> {
  late List<Chat01Message> _messages = List.of(widget.messages);
  final TextEditingController _composer = TextEditingController();
  final SheetController _sheet = SheetController();
  bool _sheetOpen = false;
  bool _busy = false;

  @override
  void dispose() {
    _composer.dispose();
    _sheet.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final String text = _composer.text.trim();
    if (text.isEmpty || _busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onSend?.call(widget.thread.id, text);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _messages = <Chat01Message>[
        ..._messages,
        Chat01Message(text: text, mine: true),
      ];
    });
    _composer.clear();
  }

  Future<void> _attach(String kind) async {
    await widget.onAttach?.call(widget.thread.id, kind);
    if (!mounted) {
      return;
    }
    setState(() => _sheetOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(appTheme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Button(
                            variant: ButtonVariant.ghost,
                            size: ButtonSize.sm,
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('‹ Back'),
                          ),
                          Expanded(
                            child: Text(
                              widget.thread.name,
                              textAlign: TextAlign.center,
                              style: appTheme.typography.textSmall,
                            ),
                          ),
                          const SizedBox(width: 64),
                        ],
                      ),
                      Gap(appTheme.spacing.md),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _messages.length,
                          separatorBuilder: (_, _) => Gap(appTheme.spacing.sm),
                          itemBuilder: (BuildContext context, int index) {
                            final Chat01Message message = _messages[index];
                            return ChatBubble(
                              alignment: message.mine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(message.text),
                            );
                          },
                        ),
                      ),
                      Gap(appTheme.spacing.sm),
                      Row(
                        children: <Widget>[
                          Button(
                            key: const ValueKey<String>('chat01.attach'),
                            variant: ButtonVariant.outline,
                            size: ButtonSize.icon,
                            onPressed: () => setState(() => _sheetOpen = true),
                            child: const Text('+'),
                          ),
                          Gap(appTheme.spacing.sm),
                          Expanded(
                            child: Input(
                              key: const ValueKey<String>('chat01.composer'),
                              controller: _composer,
                              hintText: 'Write a message…',
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _send(),
                            ),
                          ),
                          Gap(appTheme.spacing.sm),
                          Button(
                            key: const ValueKey<String>('chat01.send'),
                            size: ButtonSize.icon,
                            onPressed: _busy ? null : _send,
                            child: const Text('›'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_sheetOpen)
                  PinnedSheet(
                    controller: _sheet,
                    initialStage: const SheetStage.expanded(),
                    child: DrawerContainer(
                      child: Chat01AttachmentsSheet(
                        controller: _sheet,
                        onClose: () => setState(() => _sheetOpen = false),
                        onPick: _attach,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpssssssssssssssppkkkkkkpsssssssssssssssssssssssspppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkpppppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkpppppppppppppkkkkppppppppppppppppppppcccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppkkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkppppppppppkkkkkpppppppkkkkkppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkkpppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppkkppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppkkkkkpppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppkkkkkppppppssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppsssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/chat-01/screens/thread_list_screen.dart',
      code:
          r'''// Thread list screen of the `chat-01` flow: pull-to-refresh plus swipe
// actions per thread; a tap pushes `/thread` with the thread.

import 'package:flutter/widgets.dart';

import '../../../components/avatar/avatar.dart';
import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/empty_state/empty_state.dart';
import '../../../components/refresh_trigger/refresh_trigger.dart';
import '../../../components/swipe_actions/swipe_actions.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';

/// Thread list with refresh + swipe actions.
class Chat01ThreadListScreen extends StatefulWidget {
  /// Creates the thread list screen.
  const Chat01ThreadListScreen({
    super.key,
    required this.threads,
    this.onRefresh,
    this.onThreadMuted,
    this.onThreadDeleted,
  });

  /// Starting threads; the screen owns a mutable copy.
  final List<Chat01Thread> threads;

  /// Called on pull-to-refresh.
  final Future<void> Function()? onRefresh;

  /// Called with the muted thread.
  final ValueChanged<Chat01Thread>? onThreadMuted;

  /// Called with the deleted thread.
  final ValueChanged<Chat01Thread>? onThreadDeleted;

  @override
  State<Chat01ThreadListScreen> createState() => _Chat01ThreadListScreenState();
}

class _Chat01ThreadListScreenState extends State<Chat01ThreadListScreen> {
  late final List<Chat01Thread> _threads = List.of(widget.threads);
  final Set<String> _muted = <String>{};

  void _delete(Chat01Thread thread) {
    setState(() => _threads.removeWhere((Chat01Thread t) => t.id == thread.id));
    widget.onThreadDeleted?.call(thread);
  }

  void _mute(Chat01Thread thread) {
    setState(() => _muted.add(thread.id));
    widget.onThreadMuted?.call(thread);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Messages', style: appTheme.typography.h3),
                  Gap(appTheme.spacing.md),
                  Expanded(
                    child: RefreshTrigger(
                      onRefresh: widget.onRefresh,
                      child: _threads.isEmpty
                          ? const SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: EmptyState(
                                title: Text('No conversations'),
                                description: Text(
                                  'Pull to refresh or start a new chat.',
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: _threads.length,
                              separatorBuilder: (_, _) =>
                                  Gap(appTheme.spacing.sm),
                              itemBuilder: (BuildContext context, int index) {
                                final Chat01Thread thread = _threads[index];
                                final bool muted = _muted.contains(thread.id);
                                return SwipeActions(
                                  key: ValueKey<String>(
                                    'chat01.thread.${thread.id}',
                                  ),
                                  actions: <SwipeAction>[
                                    SwipeAction(
                                      label: muted ? 'Muted' : 'Mute',
                                      onPressed: () => _mute(thread),
                                    ),
                                    SwipeAction(
                                      label: 'Delete',
                                      destructive: true,
                                      onPressed: () => _delete(thread),
                                    ),
                                  ],
                                  onDismissed: () => _delete(thread),
                                  child: Card(
                                    child: Button(
                                      variant: ButtonVariant.ghost,
                                      onPressed: () => Navigator.of(
                                        context,
                                      ).pushNamed('/thread', arguments: thread),
                                      child: _ThreadRow(
                                        thread: thread,
                                        muted: muted,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One thread row: avatar, name + preview, unread badge.
class _ThreadRow extends StatelessWidget {
  const _ThreadRow({required this.thread, required this.muted});

  final Chat01Thread thread;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Row(
      children: <Widget>[
        Avatar(initials: thread.initials),
        Gap(appTheme.spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                muted ? '${thread.name} (muted)' : thread.name,
                style: appTheme.typography.textSmall,
              ),
              Text(
                thread.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: appTheme.typography.textMuted.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        if (thread.unread > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: appTheme.colors.primary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${thread.unread}',
              style: appTheme.typography.textSmall.copyWith(
                color: appTheme.colors.primaryForeground,
              ),
            ),
          ),
      ],
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssspppcccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppppppppkkkkppppppppppppppppkkkkppppppppppppppppppppkkkkpppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppcccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppppkkkkpkkkkkppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssppppppppppppspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssspppsssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppkkkkkkkpppppppppppppppppppppkkkkkpppppppppppppkkkkkkkkpkkkkpppppppppkkkkkkkkpkkkkpppppppppppppkkkkkppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsppppppppppppppssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsppppppppppppppppspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
  ],
  'checkout-01': <DocsFlowFile>[
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/checkout-01/flow.dart',
      code:
          r'''// The `checkout-01` flow: cart with swipe-to-delete rows, an address bottom
// sheet, payment, and a success screen.
//
// Entry: [Checkout01Flow] owns a nested [Navigator] (`/`, `/payment`,
// `/success`). Items and results travel through data + callbacks; the kit
// holds no cart backend and no demo catalogue.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/success_screen.dart';

/// One row of the [Checkout01Flow] cart.
class Checkout01CartItem {
  /// Creates a cart row.
  const Checkout01CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  /// Display name of the item.
  final String name;

  /// Unit price of the item.
  final double price;

  /// Units in the cart.
  final int quantity;
}

/// Address collected by the cart's bottom sheet.
class Checkout01Address {
  /// Creates an address.
  const Checkout01Address({
    required this.name,
    required this.street,
    required this.city,
  });

  /// Recipient name.
  final String name;

  /// Street line.
  final String street;

  /// City line.
  final String city;
}

/// Address + total carried from the cart to the payment screen.
class Checkout01Order {
  /// Creates the payment arguments.
  const Checkout01Order({required this.address, required this.total});

  /// Address saved from the sheet.
  final Checkout01Address address;

  /// Cart total at checkout time.
  final double total;
}

/// Cart → address sheet → payment → success.
class Checkout01Flow extends StatelessWidget {
  /// Creates the flow.
  const Checkout01Flow({
    super.key,
    this.items = const <Checkout01CartItem>[
      Checkout01CartItem(name: 'Everyday backpack', price: 89),
      Checkout01CartItem(name: 'Insulated bottle', price: 32, quantity: 2),
      Checkout01CartItem(name: 'Desk lamp', price: 54),
    ],
    this.onRemoveItem,
    this.onAddressSaved,
    this.onPlaceOrder,
    this.onDone,
    this.initialScreen = '/',
  });

  /// Starting cart rows; the cart screen owns a mutable copy.
  final List<Checkout01CartItem> items;

  /// Called with the removed row.
  final ValueChanged<Checkout01CartItem>? onRemoveItem;

  /// Called with the validated address from the sheet.
  final Future<void> Function(Checkout01Address address)? onAddressSaved;

  /// Called with the address + total when Pay is tapped.
  final Future<void> Function(Checkout01Address address, double total)?
  onPlaceOrder;

  /// Called from the success screen.
  final VoidCallback? onDone;

  /// Initial route of the nested navigator (`/`, `/payment`, `/success`).
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/payment':
            // A bare `/payment` (e.g. a docs screen-map jump with no order
            // yet) falls back to the cart instead of throwing on the cast.
            final Object? args = settings.arguments;
            if (args is! Checkout01Order) {
              return AppPageRoute(
                settings: settings,
                builder: (_) => Checkout01CartScreen(
                  items: items,
                  onRemoveItem: onRemoveItem,
                  onAddressSaved: onAddressSaved,
                ),
              );
            }
            final Checkout01Order order = args;
            return AppPageRoute(
              settings: settings,
              builder: (_) => Checkout01PaymentScreen(
                order: order,
                onPlaceOrder: onPlaceOrder,
              ),
            );
          case '/success':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Checkout01SuccessScreen(onDone: onDone),
            );
          case '/':
          default:
            return AppPageRoute(
              settings: settings,
              builder: (_) => Checkout01CartScreen(
                items: items,
                onRemoveItem: onRemoveItem,
                onAddressSaved: onAddressSaved,
              ),
            );
        }
      },
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccpccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpsssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssspppcccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppcccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppkkkkkkkkpkkkkpppppppppppkkkkkkkkpkkkkppppppppppppkkkkppppppppppppppppppppppppcccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppcccccccccccccccccccccccccccpppkkkkkppppppppppppppppppccccccccccccccccccccccpppkkkkkppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppppcccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppkkkkkkkkpkkkkpppppppppppkkkkkkkkpkkkkpppppppppppppkkkkkkkkpkkkkppppppppppppppppcccccccccccccccccccpppkkkkkpppppppppppppppppccccccccccccccccpppkkkkkpppppppppppppppppppccccccccccccccpppkkkkkpppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppkkkkkkkkpkkkkppppppppppkkkkkkkkpkkkkpppppppppppppcccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccpppkkkkkppppppppppppppppppppppkkkkkppppppppppkkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssspppppppppppppppppppppppppkkkkpppppppppppppppppppkkkkpppppppppppppppppppppkkkkpppppppppppppppppppkkkkpppppppppppppkkkkpppppppppppppppppssspppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppkkkkpssssssssssppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppkkpppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpssssssssssppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpsssppppppppppppkkkkkkkppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/checkout-01/screens/address_sheet.dart',
      code:
          r'''// Address sheet body of the `checkout-01` flow: validated address form
// shown inside the cart's [PinnedSheet].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';

/// Address form; Save validates, reports [onSaved], and closes via [onClose].
class Checkout01AddressSheet extends StatefulWidget {
  /// Creates the address sheet body.
  const Checkout01AddressSheet({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onSaved,
  });

  /// Sheet controller for the Close button.
  final SheetController controller;

  /// Hides the sheet without saving.
  final VoidCallback onClose;

  /// Called with the validated address.
  final Future<void> Function(Checkout01Address address) onSaved;

  @override
  State<Checkout01AddressSheet> createState() => _Checkout01AddressSheetState();
}

class _Checkout01AddressSheetState extends State<Checkout01AddressSheet> {
  final FormController _form = FormController();
  final FormKey<String> _nameKey = const FormKey<String>('name');
  final FormKey<String> _streetKey = const FormKey<String>('street');
  final FormKey<String> _cityKey = const FormKey<String>('city');
  bool _busy = false;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final SubmissionResult result = await _form.submit(context);
    if (!result.isValid || !mounted) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onSaved(
        Checkout01Address(
          name: result.values.getValue(_nameKey) ?? '',
          street: result.values.getValue(_streetKey) ?? '',
          city: result.values.getValue(_cityKey) ?? '',
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Delivery address', style: appTheme.typography.h3),
          Gap(appTheme.spacing.md),
          FormScope(
            controller: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormItem<String>(
                  key: _nameKey,
                  label: const Text('Name'),
                  validator: const NotEmptyValidator(),
                  // Errors surface on submit only: the mount-time report lands
                  // as `changed`, so including it would flag pristine fields.
                  showErrors: const <FormValidationMode>{
                    FormValidationMode.submitted,
                  },
                  child: const Input(
                    key: ValueKey<String>('checkout01.address.name'),
                    hintText: 'Ada Lovelace',
                  ),
                ),
                Gap(appTheme.spacing.sm),
                FormItem<String>(
                  key: _streetKey,
                  label: const Text('Street'),
                  validator: const NotEmptyValidator(),
                  // Errors surface on submit only: the mount-time report lands
                  // as `changed`, so including it would flag pristine fields.
                  showErrors: const <FormValidationMode>{
                    FormValidationMode.submitted,
                  },
                  child: const Input(
                    key: ValueKey<String>('checkout01.address.street'),
                    hintText: '12 Bernoulli Lane',
                  ),
                ),
                Gap(appTheme.spacing.sm),
                FormItem<String>(
                  key: _cityKey,
                  label: const Text('City'),
                  validator: const NotEmptyValidator(),
                  // Errors surface on submit only: the mount-time report lands
                  // as `changed`, so including it would flag pristine fields.
                  showErrors: const <FormValidationMode>{
                    FormValidationMode.submitted,
                  },
                  child: const Input(
                    key: ValueKey<String>('checkout01.address.city'),
                    hintText: 'Springfield',
                  ),
                ),
              ],
            ),
          ),
          Gap(appTheme.spacing.md),
          Button(
            key: const ValueKey<String>('checkout01.address.save'),
            onPressed: _busy ? null : _save,
            child: Text(_busy ? 'Saving…' : 'Save and continue'),
          ),
          Gap(appTheme.spacing.sm),
          Button(
            variant: ButtonVariant.outline,
            onPressed: () {
              widget.controller.close();
              widget.onClose();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkpppppppppppppppppkkkkkkkkpkkkkppppppppppppppkkkkkkkkpkkkkpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssspppppkkkkkppppppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssssspppppkkkkkppppppppppppppppppppppppppppkkkkkpppppppppppppppppssssssppppppppppppppppppkkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkppppppppppkkkkkpppppppkkkkkpppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssppppppppppppppppppppppppppppppppppppppppppppppppppppppssppppppppppppppppppppppppppppkkkkkkkpppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssssspppppppppppppppppppppppppppppppppssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppsssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssssspppppppppppppppppppppppppppppppppsssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppsssssssssssssssssssssssssppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppssssssssspppssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/checkout-01/screens/cart_screen.dart',
      code:
          r'''// Cart screen of the `checkout-01` flow: swipe-to-delete rows, totals, and
// the address bottom sheet.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/drawer_container/drawer_container.dart';
import '../../../components/empty_state/empty_state.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../components/swipe_actions/swipe_actions.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import 'address_sheet.dart';

/// Cart rows; Checkout opens the address sheet.
class Checkout01CartScreen extends StatefulWidget {
  /// Creates the cart screen.
  const Checkout01CartScreen({
    super.key,
    required this.items,
    this.onRemoveItem,
    this.onAddressSaved,
  });

  /// Starting rows; the screen owns a mutable copy.
  final List<Checkout01CartItem> items;

  /// Called with the removed row.
  final ValueChanged<Checkout01CartItem>? onRemoveItem;

  /// Called with the validated address from the sheet.
  final Future<void> Function(Checkout01Address address)? onAddressSaved;

  @override
  State<Checkout01CartScreen> createState() => _Checkout01CartScreenState();
}

class _Checkout01CartScreenState extends State<Checkout01CartScreen> {
  late final List<Checkout01CartItem> _items = List.of(widget.items);
  final SheetController _sheet = SheetController();
  bool _sheetOpen = false;

  @override
  void dispose() {
    _sheet.dispose();
    super.dispose();
  }

  double get _total {
    var total = 0.0;
    for (final Checkout01CartItem item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void _remove(Checkout01CartItem item) {
    setState(() => _items.remove(item));
    widget.onRemoveItem?.call(item);
  }

  Future<void> _saveAddress(Checkout01Address address) async {
    await widget.onAddressSaved?.call(address);
    if (!mounted) {
      return;
    }
    setState(() => _sheetOpen = false);
    Navigator.of(context).pushNamed(
      '/payment',
      arguments: Checkout01Order(address: address, total: _total),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(appTheme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Your cart', style: appTheme.typography.h3),
                      Gap(appTheme.spacing.xs),
                      Text(
                        '${_items.length} items',
                        style: appTheme.typography.textMuted.copyWith(
                          color: appTheme.colors.mutedForeground,
                        ),
                      ),
                      Gap(appTheme.spacing.lg),
                      if (_items.isEmpty)
                        const EmptyState(
                          title: Text('Cart is empty'),
                          description: Text('Add something you love first.'),
                        )
                      else
                        Expanded(
                          child: ListView.separated(
                            itemCount: _items.length,
                            separatorBuilder: (_, _) =>
                                Gap(appTheme.spacing.sm),
                            itemBuilder: (BuildContext context, int index) {
                              final Checkout01CartItem item = _items[index];
                              return SwipeActions(
                                key: ValueKey<String>(
                                  'checkout01.row.${item.name}',
                                ),
                                actions: <SwipeAction>[
                                  SwipeAction(
                                    label: 'Delete',
                                    destructive: true,
                                    onPressed: () => _remove(item),
                                  ),
                                ],
                                onDismissed: () => _remove(item),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      appTheme.spacing.md,
                                    ),
                                    child: _Row(item: item),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      Gap(appTheme.spacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total', style: appTheme.typography.h3),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: appTheme.typography.h3,
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.md),
                      Button(
                        key: const ValueKey<String>('checkout01.checkout'),
                        onPressed: _items.isEmpty
                            ? null
                            : () => setState(() => _sheetOpen = true),
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
                if (_sheetOpen)
                  PinnedSheet(
                    controller: _sheet,
                    initialStage: const SheetStage.expanded(),
                    child: DrawerContainer(
                      child: Checkout01AddressSheet(
                        controller: _sheet,
                        onClose: () => setState(() => _sheetOpen = false),
                        onSaved: _saveAddress,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One cart row: name, quantity and line price.
class _Row extends StatelessWidget {
  const _Row({required this.item});

  final Checkout01CartItem item;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.name, style: appTheme.typography.textSmall),
              Text(
                'Qty ${item.quantity}',
                style: appTheme.typography.textMuted.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        Text(
          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
          style: appTheme.typography.textSmall,
        ),
      ],
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpssssssssssssssppkkkkkkpsssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppkkkkkkkppppppppppppppppppppccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppppppkkkkpppppppppppppppppppkkkkppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppkkkkpkkkkkppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkppppppppppppppkkkppppppppppppppppppkkkppkkkkkpppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppkkpppppppppppppppppppppppppppssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsppppppppppppppppssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssppppppppppppspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssspppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssppppppppppppppppppppppppppppspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppkkkkkppppppsssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppkkkkkkkpppppppppppppppppppppkkkkkpppppppkkkkkkkkpkkkkppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssppppppppppppppppsppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssppppppppppppppppppppppppppppppppppppppppppppppppppsppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/checkout-01/screens/payment_screen.dart',
      code:
          r'''// Payment screen of the `checkout-01` flow: card fields, then `/success`.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';

/// Card form; Pay calls [onPlaceOrder] then shows `/success`.
class Checkout01PaymentScreen extends StatefulWidget {
  /// Creates the payment screen.
  const Checkout01PaymentScreen({
    super.key,
    required this.order,
    this.onPlaceOrder,
  });

  /// Address + total from the cart.
  final Checkout01Order order;

  /// Called with the address + total when Pay is tapped.
  final Future<void> Function(Checkout01Address address, double total)?
  onPlaceOrder;

  @override
  State<Checkout01PaymentScreen> createState() =>
      _Checkout01PaymentScreenState();
}

class _Checkout01PaymentScreenState extends State<Checkout01PaymentScreen> {
  final FormController _form = FormController();
  final FormKey<String> _numberKey = const FormKey<String>('number');
  final FormKey<String> _expiryKey = const FormKey<String>('expiry');
  final FormKey<String> _cvcKey = const FormKey<String>('cvc');
  bool _busy = false;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    final SubmissionResult result = await _form.submit(context);
    if (!result.isValid || !mounted) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onPlaceOrder?.call(widget.order.address, widget.order.total);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
    if (mounted) {
      Navigator.of(context).pushNamed('/success');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Payment', style: appTheme.typography.h3),
                  Gap(appTheme.spacing.xs),
                  Text(
                    'Deliver to ${widget.order.address.street}, '
                    '${widget.order.address.city}',
                    style: appTheme.typography.textMuted.copyWith(
                      color: appTheme.colors.mutedForeground,
                    ),
                  ),
                  Gap(appTheme.spacing.lg),
                  FormScope(
                    controller: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FormItem<String>(
                          key: _numberKey,
                          label: const Text('Card number'),
                          validator:
                              const NotEmptyValidator() &
                              const LengthValidator(min: 12),
                          // Errors surface on submit only: the mount-time report
                          // lands as `changed`, so including it would flag
                          // pristine fields.
                          showErrors: const <FormValidationMode>{
                            FormValidationMode.submitted,
                          },
                          child: const Input(
                            key: ValueKey<String>('checkout01.pay.number'),
                            hintText: '4242 4242 4242 4242',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(appTheme.spacing.sm),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FormItem<String>(
                                key: _expiryKey,
                                label: const Text('Expiry'),
                                validator: const NotEmptyValidator(),
                                // Errors surface on submit only: the mount-time
                                // report lands as `changed`, so including it
                                // would flag pristine fields.
                                showErrors: const <FormValidationMode>{
                                  FormValidationMode.submitted,
                                },
                                child: const Input(
                                  key: ValueKey<String>(
                                    'checkout01.pay.expiry',
                                  ),
                                  hintText: '12/28',
                                ),
                              ),
                            ),
                            Gap(appTheme.spacing.sm),
                            Expanded(
                              child: FormItem<String>(
                                key: _cvcKey,
                                label: const Text('CVC'),
                                validator:
                                    const NotEmptyValidator() &
                                    const LengthValidator(min: 3),
                                // Errors surface on submit only: the mount-time
                                // report lands as `changed`, so including it
                                // would flag pristine fields.
                                showErrors: const <FormValidationMode>{
                                  FormValidationMode.submitted,
                                },
                                child: const Input(
                                  key: ValueKey<String>('checkout01.pay.cvc'),
                                  hintText: '123',
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(appTheme.spacing.lg),
                  Button(
                    key: const ValueKey<String>('checkout01.pay'),
                    onPressed: _busy ? null : _pay,
                    child: Text(
                      _busy
                          ? 'Paying…'
                          : 'Pay \$${widget.order.total.toStringAsFixed(2)}',
                    ),
                  ),
                  Gap(appTheme.spacing.sm),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to cart'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppppppkkkkppppppppppppppppppppppppccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppkkkkppkkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssssspppppkkkkkppppppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssssspppppkkkkkpppppppppppppppppppppppppppkkkkkpppppppppppppppppsssssppppppppppppppppppkkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkpppppppppkkkkkpppppppkkkkkpppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppkkkkpppppppkkkpppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkkpppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppkkpppppppppppppppppppppppppppppkkppppppppppppppppppppsssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssppppppppppppppppppppppppppppppssspppppppppppppppppppppsppppppppppppppppppppppppppppsppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppcccccccccccccccccccpppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccpppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppssssspppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssssssppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssspppppppppppppppppppppppppppppsssssssppppppppppppppppppppppppppppppppppppppppsppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/checkout-01/screens/success_screen.dart',
      code:
          r'''// Success screen of the `checkout-01` flow: confirmation + done.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../foundation/gap.dart';
import '../../../foundation/icons/radix_icons.dart';
import '../../../theme/theme.dart';

/// Order confirmation; Done calls [onDone].
class Checkout01SuccessScreen extends StatelessWidget {
  /// Creates the success screen.
  const Checkout01SuccessScreen({super.key, this.onDone});

  /// Called when Done is tapped.
  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    RadixIcons.check,
                    size: 44,
                    color: appTheme.colors.primary,
                  ),
                  Gap(appTheme.spacing.lg),
                  Text(
                    'Order placed',
                    style: appTheme.typography.h3,
                    textAlign: TextAlign.center,
                  ),
                  Gap(appTheme.spacing.sm),
                  Text(
                    'Thanks for shopping with us. A confirmation '
                    'is on its way.',
                    textAlign: TextAlign.center,
                    style: appTheme.typography.textMuted.copyWith(
                      color: appTheme.colors.mutedForeground,
                    ),
                  ),
                  Gap(appTheme.spacing.xl),
                  Button(
                    key: const ValueKey<String>('checkout01.done'),
                    onPressed: onDone,
                    child: const Text('Continue shopping'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppkkkkkppppppkkkkppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssssssssssssssssssssssssssspppppppppppppppppppppsssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
  ],
  'onboarding-01': <DocsFlowFile>[
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/onboarding-01/flow.dart',
      code:
          r'''// The `onboarding-01` flow: swipeable intro pages plus a permission ask.
//
// Entry: [Onboarding01Flow] owns a nested [Navigator]; `/` shows the pages,
// `/permission` the permission ask. Data in via [Onboarding01Page], results
// out via callbacks; there is no backend and no demo data in the kit.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import '../../foundation/icons/radix_icons.dart';
import 'screens/pages_screen.dart';
import 'screens/permission_screen.dart';

/// One swipeable intro page of [Onboarding01Flow].
class Onboarding01Page {
  /// Creates an intro page.
  const Onboarding01Page({
    required this.icon,
    required this.title,
    required this.description,
  });

  /// Glyph shown above the title.
  final IconData icon;

  /// Headline of the page.
  final String title;

  /// Supporting text of the page.
  final String description;
}

/// Three-page intro with a permission ask: `<Name>Flow` owns the Navigator.
class Onboarding01Flow extends StatelessWidget {
  /// Creates the flow.
  const Onboarding01Flow({
    super.key,
    this.pages = const <Onboarding01Page>[
      Onboarding01Page(
        icon: RadixIcons.rocket,
        title: 'Welcome aboard',
        description: 'A quick tour before you start using the app.',
      ),
      Onboarding01Page(
        icon: RadixIcons.chatBubble,
        title: 'Stay in the loop',
        description: 'Messages and updates arrive the moment they happen.',
      ),
      Onboarding01Page(
        icon: RadixIcons.bell,
        title: 'Never miss a thing',
        description: 'Allow notifications to get the most out of the app.',
      ),
    ],
    this.onSkip,
    this.onFinished,
    this.onPermissionChanged,
    this.initialScreen = '/',
  });

  /// Intro pages; defaults to a three-page tour.
  final List<Onboarding01Page> pages;

  /// Called when Skip is tapped.
  final VoidCallback? onSkip;

  /// Called when the permission screen resolves, with the choice.
  final ValueChanged<bool>? onPermissionChanged;

  /// Called when the permission screen resolves, after [onPermissionChanged].
  final VoidCallback? onFinished;

  /// Initial route of the nested navigator (`/`, `/permission`).
  final String initialScreen;

  void _resolve(BuildContext context, bool granted) {
    onPermissionChanged?.call(granted);
    onFinished?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/permission') {
          return AppPageRoute(
            settings: settings,
            builder: (_) => Onboarding01PermissionScreen(
              onResolve: (bool granted) => _resolve(context, granted),
            ),
          );
        }
        return AppPageRoute(
          settings: settings,
          builder: (_) => Onboarding01PagesScreen(pages: pages, onSkip: onSkip),
        );
      },
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpsssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssssspppcccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppkkkkkkkkpkkkkpppppppppppkkkkkkkkpkkkkppppppppppppkkkkkkkkpkkkkpppppppppppppppppppppppccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppcccccccccccccccccccccccccpppkkkkkppppppppppppppppppccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccpppkkkkkppppppppppppppppppppppppkkkkkppppppppppkkkkpppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssspppppppppppppppppppppppsssssssssssssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssspppppppppppppppppppppppssssssssssssssssssssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssspppppppppppppppppppppppsssssssssssssssssssssssssssssssssssssssssssssssssssssppppppppppppppppppppppkkkkpppppppppppppkkkkpppppppppppppppppkkkkppppppppppppppppppppppppppkkkkpppppppppppppppppssspppppppppppcccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppsssssssssssssppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/onboarding-01/screens/pages_screen.dart',
      code:
          r'''// Pages screen of the `onboarding-01` flow: swipeable [Carousel] pages with
// a [DotIndicator], Skip, and Next / Get started.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/carousel/carousel.dart';
import '../../../components/dot_indicator/dot_indicator.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';

/// Swipeable intro pages; the last page continues to `/permission`.
class Onboarding01PagesScreen extends StatefulWidget {
  /// Creates the pages screen.
  const Onboarding01PagesScreen({super.key, required this.pages, this.onSkip});

  /// Pages to swipe through.
  final List<Onboarding01Page> pages;

  /// Called when Skip is tapped.
  final VoidCallback? onSkip;

  @override
  State<Onboarding01PagesScreen> createState() =>
      _Onboarding01PagesScreenState();
}

class _Onboarding01PagesScreenState extends State<Onboarding01PagesScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final bool last = _index >= widget.pages.length - 1;
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Button(
                      variant: ButtonVariant.ghost,
                      size: ButtonSize.sm,
                      onPressed: widget.onSkip,
                      child: const Text('Skip'),
                    ),
                  ),
                  Expanded(
                    child: Carousel(
                      itemCount: widget.pages.length,
                      onIndexChanged: (int value) =>
                          setState(() => _index = value),
                      itemBuilder: (BuildContext context, int index) =>
                          _PageCard(page: widget.pages[index]),
                    ),
                  ),
                  Gap(appTheme.spacing.md),
                  DotIndicator(index: _index, length: widget.pages.length),
                  Gap(appTheme.spacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: Button(
                      onPressed: last
                          ? () => Navigator.of(context).pushNamed('/permission')
                          : () => setState(() => _index = _index + 1),
                      child: Text(last ? 'Get started' : 'Next'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One intro page rendered as a centred card.
class _PageCard extends StatelessWidget {
  const _PageCard({required this.page});

  final Onboarding01Page page;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(appTheme.spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(page.icon, size: 44, color: appTheme.colors.primary),
              Gap(appTheme.spacing.lg),
              Text(page.title, style: appTheme.typography.h3),
              Gap(appTheme.spacing.sm),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: appTheme.typography.textMuted.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppkkkkkppppppkkkkkkkkpkkkkppppppppkkkkppppppppppppppcccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppsssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssspppsssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppkkkkkkkpppppppppppppppppppppkkkkkppppppppppppkkkkkkkkpkkkkppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/onboarding-01/screens/permission_screen.dart',
      code:
          r'''// Permission screen of the `onboarding-01` flow: explains the ask, then
// resolves through [Onboarding01PermissionScreen.onResolve].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../foundation/gap.dart';
import '../../../foundation/icons/radix_icons.dart';
import '../../../theme/theme.dart';

/// Permission ask; Allow resolves true, Not now resolves false.
class Onboarding01PermissionScreen extends StatelessWidget {
  /// Creates the permission screen.
  const Onboarding01PermissionScreen({super.key, required this.onResolve});

  /// Called with the user's choice.
  final ValueChanged<bool> onResolve;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        // Scrolls when the card is taller than the screen (short phones,
        // landscape, large text scale, touch-sized buttons).
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: EdgeInsets.all(appTheme.spacing.lg),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(appTheme.spacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          RadixIcons.bell,
                          size: 44,
                          color: appTheme.colors.primary,
                        ),
                        Gap(appTheme.spacing.lg),
                        Text(
                          'Enable notifications?',
                          style: appTheme.typography.h3,
                          textAlign: TextAlign.center,
                        ),
                        Gap(appTheme.spacing.sm),
                        Text(
                          'We only send what matters: replies, reminders '
                          'and security alerts. You can change this later.',
                          textAlign: TextAlign.center,
                          style: appTheme.typography.textMuted.copyWith(
                            color: appTheme.colors.mutedForeground,
                          ),
                        ),
                        Gap(appTheme.spacing.xl),
                        Button(
                          onPressed: () => onResolve(true),
                          child: const Text('Allow notifications'),
                        ),
                        Gap(appTheme.spacing.sm),
                        Button(
                          variant: ButtonVariant.outline,
                          onPressed: () => onResolve(false),
                          child: const Text('Not now'),
                        ),
                        Gap(appTheme.spacing.sm),
                        Button(
                          variant: ButtonVariant.ghost,
                          size: ButtonSize.sm,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Back'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppkkkkkppppppkkkkkkkkpkkkkpppppppppppppppppccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppssssssssssssssssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
  ],
  'settings-01': <DocsFlowFile>[
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/settings-01/flow.dart',
      code:
          r'''// The `settings-01` flow: grouped list, nested pages, toggles, an account
// sheet and a sign-out confirm.
//
// Entry: [Settings01Flow] owns a nested [Navigator] (`/`, `/notifications`,
// `/appearance`). Toggles report through callbacks; the kit stores nothing.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/detail_screens.dart';
import 'screens/home_screen.dart';

/// Grouped settings with nested pages and an account sheet.
class Settings01Flow extends StatelessWidget {
  /// Creates the flow.
  const Settings01Flow({
    super.key,
    this.userName = 'Ada Lovelace',
    this.userEmail = 'ada@example.com',
    this.userInitials = 'AL',
    this.notifications = true,
    this.darkMode = false,
    this.onNotificationsChanged,
    this.onDarkModeChanged,
    this.onSoundsChanged,
    this.onSignOut,
    this.initialScreen = '/',
  });

  /// Display name shown in the profile row and account sheet.
  final String userName;

  /// Email shown in the profile row and account sheet.
  final String userEmail;

  /// Fallback initials of the avatar.
  final String userInitials;

  /// Starting notification toggle.
  final bool notifications;

  /// Starting dark-mode toggle.
  final bool darkMode;

  /// Called when the notification toggle flips.
  final ValueChanged<bool>? onNotificationsChanged;

  /// Called when the dark-mode toggle flips.
  final ValueChanged<bool>? onDarkModeChanged;

  /// Called when the sounds toggle flips.
  final ValueChanged<bool>? onSoundsChanged;

  /// Called once the sign-out confirm accepts.
  final VoidCallback? onSignOut;

  /// Initial route of the nested navigator (`/`, `/notifications`,
  /// `/appearance`).
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/notifications':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Settings01NotificationsScreen(
                notifications: notifications,
                onNotificationsChanged: onNotificationsChanged,
                onSoundsChanged: onSoundsChanged,
              ),
            );
          case '/appearance':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Settings01AppearanceScreen(
                darkMode: darkMode,
                onDarkModeChanged: onDarkModeChanged,
              ),
            );
          case '/':
          default:
            return AppPageRoute(
              settings: settings,
              builder: (_) => Settings01HomeScreen(
                userName: userName,
                userEmail: userEmail,
                userInitials: userInitials,
                notifications: notifications,
                darkMode: darkMode,
                onNotificationsChanged: onNotificationsChanged,
                onDarkModeChanged: onDarkModeChanged,
                onSignOut: onSignOut,
              ),
            );
        }
      },
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccpccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpsssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccpppkkkkkppppppppppppppppppppppkkkkkppppppppppkkkkppppppppppppssssssssssssssppppppkkkkpppppppppppppsssssssssssssssssppppppkkkkppppppppppppppppssssppppppkkkkpppppppppppppppppkkkkppppppkkkkppppppppppppkkkkkppppppkkkkpppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppkkkkppppppppppppppppppppppkkkkppppppppppppppppkkkkpppppppppppppppppssspppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppcccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpppcccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppkkkkpssssssssssssssssppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpsssssssssssssppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpsssppppppppppppkkkkkkkppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/settings-01/screens/account_sheet.dart',
      code:
          r'''// Account sheet body of the `settings-01` flow: profile summary shown
// inside the home screen's [PinnedSheet].

import 'package:flutter/widgets.dart';

import '../../../components/avatar/avatar.dart';
import '../../../components/button/button.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Account summary with a Close button wired to [controller].
class Settings01AccountSheet extends StatelessWidget {
  /// Creates the account sheet body.
  const Settings01AccountSheet({
    super.key,
    required this.controller,
    required this.userName,
    required this.userEmail,
    required this.userInitials,
    required this.onClose,
  });

  /// Sheet controller for the Close button.
  final SheetController controller;

  /// Display name shown under the avatar.
  final String userName;

  /// Email shown under the name.
  final String userEmail;

  /// Avatar fallback initials.
  final String userInitials;

  /// Hides the sheet.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Avatar(initials: userInitials),
              Gap(appTheme.spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(userName, style: appTheme.typography.textSmall),
                    Text(
                      userEmail,
                      style: appTheme.typography.textMuted.copyWith(
                        color: appTheme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(appTheme.spacing.md),
          Button(
            variant: ButtonVariant.outline,
            onPressed: () {
              controller.close();
              onClose();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkpppppppppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkkkkkpkkkkppppppppppppppppkkkkkkkkpkkkkpppppppppppppppppppkkkkkkkkpkkkkpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppcccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/settings-01/screens/detail_screens.dart',
      code:
          r'''// Nested pages of the `settings-01` flow: notifications and appearance
// details with their own toggles.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/switch/switch.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Notifications detail page.
class Settings01NotificationsScreen extends StatefulWidget {
  /// Creates the notifications page.
  const Settings01NotificationsScreen({
    super.key,
    required this.notifications,
    this.onNotificationsChanged,
    this.onSoundsChanged,
  });

  /// Starting notification toggle.
  final bool notifications;

  /// Called when the notification toggle flips.
  final ValueChanged<bool>? onNotificationsChanged;

  /// Called when the sounds toggle flips.
  final ValueChanged<bool>? onSoundsChanged;

  @override
  State<Settings01NotificationsScreen> createState() =>
      _Settings01NotificationsScreenState();
}

class _Settings01NotificationsScreenState
    extends State<Settings01NotificationsScreen> {
  late bool _notifications = widget.notifications;
  bool _sounds = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Notifications', style: appTheme.typography.h3),
                  Gap(appTheme.spacing.lg),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Settings01ToggleRow(
                          label: 'Push notifications',
                          value: _notifications,
                          onChanged: (bool value) {
                            setState(() => _notifications = value);
                            widget.onNotificationsChanged?.call(value);
                          },
                        ),
                        Settings01ToggleRow(
                          label: 'Sounds',
                          value: _sounds,
                          onChanged: (bool value) {
                            setState(() => _sounds = value);
                            widget.onSoundsChanged?.call(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(appTheme.spacing.md),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to settings'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Appearance detail page.
class Settings01AppearanceScreen extends StatefulWidget {
  /// Creates the appearance page.
  const Settings01AppearanceScreen({
    super.key,
    required this.darkMode,
    this.onDarkModeChanged,
  });

  /// Starting dark-mode toggle.
  final bool darkMode;

  /// Called when the dark-mode toggle flips.
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  State<Settings01AppearanceScreen> createState() =>
      _Settings01AppearanceScreenState();
}

class _Settings01AppearanceScreenState
    extends State<Settings01AppearanceScreen> {
  late bool _darkMode = widget.darkMode;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Appearance', style: appTheme.typography.h3),
                  Gap(appTheme.spacing.lg),
                  Card(
                    child: Settings01ToggleRow(
                      label: 'Dark mode',
                      value: _darkMode,
                      onChanged: (bool value) {
                        setState(() => _darkMode = value);
                        widget.onDarkModeChanged?.call(value);
                      },
                    ),
                  ),
                  Gap(appTheme.spacing.md),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to settings'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A label + switch row shared by the nested pages.
class Settings01ToggleRow extends StatelessWidget {
  /// Creates a toggle row.
  const Settings01ToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  /// Row label.
  final String label;

  /// Current toggle value.
  final bool value;

  /// Called with the next value.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appTheme.spacing.lg,
        vertical: appTheme.spacing.sm,
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
''',
      tokenClasses:
          'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssspppccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppcccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppppppppppppppkkkkpppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppppppppkkkkkkkppppppppppppppppppppccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkpppppppppppppppppppppppppppppccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppppppppppppppkkkkkkkpppppppppppppppppppppcccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppppppkkkkkkkkpkkkkppppppppppppkkkkkkkkpkkkkpppppppppppppppppppppccccccccccccccpppkkkkkppppppppppppppppppcccccccccccccccccccccccccpppkkkkkppppppppppppppppcccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp',
    ),
    DocsFlowFile(
      path: 'lib/ui/dashcn/flows/settings-01/screens/home_screen.dart',
      code:
          r'''// Home screen of the `settings-01` flow: profile row, grouped list with
// toggles, nested-page rows, the account sheet and a sign-out confirm.

import 'package:flutter/widgets.dart';

import '../../../components/alert_dialog/alert_dialog.dart';
import '../../../components/avatar/avatar.dart';
import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/drawer_container/drawer_container.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../components/switch/switch.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'account_sheet.dart';

/// Grouped settings list.
class Settings01HomeScreen extends StatefulWidget {
  /// Creates the home screen.
  const Settings01HomeScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userInitials,
    required this.notifications,
    required this.darkMode,
    this.onNotificationsChanged,
    this.onDarkModeChanged,
    this.onSignOut,
  });

  /// Display name of the profile row.
  final String userName;

  /// Email of the profile row.
  final String userEmail;

  /// Avatar fallback initials.
  final String userInitials;

  /// Starting notification toggle.
  final bool notifications;

  /// Starting dark-mode toggle.
  final bool darkMode;

  /// Called when the notification toggle flips.
  final ValueChanged<bool>? onNotificationsChanged;

  /// Called when the dark-mode toggle flips.
  final ValueChanged<bool>? onDarkModeChanged;

  /// Called once the sign-out confirm accepts.
  final VoidCallback? onSignOut;

  @override
  State<Settings01HomeScreen> createState() => _Settings01HomeScreenState();
}

class _Settings01HomeScreenState extends State<Settings01HomeScreen> {
  late bool _notifications = widget.notifications;
  late bool _darkMode = widget.darkMode;
  final SheetController _sheet = SheetController();
  bool _sheetOpen = false;

  @override
  void dispose() {
    _sheet.dispose();
    super.dispose();
  }

  Future<void> _confirmSignOut() async {
    final bool? confirmed = await showAlertDialog<bool>(
      context: context,
      useRootNavigator: false,
      title: const Text('Sign out?'),
      description: const Text('You can always sign back in later.'),
      actionsBuilder: (BuildContext dialogContext) => <Widget>[
        Button(
          variant: ButtonVariant.outline,
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        Button(
          variant: ButtonVariant.destructive,
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Sign out'),
        ),
      ],
    );
    if (confirmed == true) {
      widget.onSignOut?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.all(appTheme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Avatar(initials: widget.userInitials),
                          Gap(appTheme.spacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.userName,
                                  style: appTheme.typography.textSmall,
                                ),
                                Text(
                                  widget.userEmail,
                                  style: appTheme.typography.textMuted.copyWith(
                                    color: appTheme.colors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.lg),
                      _Section(
                        title: 'Preferences',
                        children: <Widget>[
                          _ToggleRow(
                            label: 'Notifications',
                            value: _notifications,
                            onChanged: (bool value) {
                              setState(() => _notifications = value);
                              widget.onNotificationsChanged?.call(value);
                            },
                          ),
                          _ToggleRow(
                            label: 'Dark mode',
                            value: _darkMode,
                            onChanged: (bool value) {
                              setState(() => _darkMode = value);
                              widget.onDarkModeChanged?.call(value);
                            },
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.md),
                      _Section(
                        title: 'General',
                        children: <Widget>[
                          _NavRow(
                            label: 'Notifications',
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed('/notifications'),
                          ),
                          _NavRow(
                            label: 'Appearance',
                            onTap: () =>
                                Navigator.of(context).pushNamed('/appearance'),
                          ),
                          _NavRow(
                            label: 'Account',
                            onTap: () => setState(() => _sheetOpen = true),
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.lg),
                      Button(
                        key: const ValueKey<String>('settings01.signout'),
                        variant: ButtonVariant.outline,
                        onPressed: _confirmSignOut,
                        child: const Text('Sign out'),
                      ),
                    ],
                  ),
                ),
                if (_sheetOpen)
                  PinnedSheet(
                    controller: _sheet,
                    initialStage: const SheetStage.expanded(),
                    child: DrawerContainer(
                      child: Settings01AccountSheet(
                        controller: _sheet,
                        userName: widget.userName,
                        userEmail: widget.userEmail,
                        userInitials: widget.userInitials,
                        onClose: () => setState(() => _sheetOpen = false),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One grouped card with a section title.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: appTheme.typography.textSmall.copyWith(
            color: appTheme.colors.mutedForeground,
          ),
        ),
        Gap(appTheme.spacing.sm),
        Card(child: Column(children: children)),
      ],
    );
  }
}

/// A label + switch row with the same list-row density as [_NavRow].
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appTheme.spacing.lg,
        vertical: appTheme.spacing.sm,
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// A tappable row pushing a nested page.
class _NavRow extends StatelessWidget {
  const _NavRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.ghost,
      onPressed: onTap,
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          const Text('›'),
        ],
      ),
    );
  }
}
''',
      tokenClasses:
          'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccppkkkkkkpsssssssssssssssssssssssssssssspppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssssssssssssppkkkkkkpssssssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssssssssssppkkkkkkpsssssssssssssssssssspppccccccccccccccccccccccccccpkkkkkppppppppppppppppppppppkkkkkkkppppppppppppppppppppccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkkkkkpkkkkppppppppppppppppkkkkkkkkpkkkkpppppppppppppppppppkkkkkkkkpkkkkppppppppppppppppppppkkkkkkkkpkkkkpppppppppppppppkkkkpppppppppppppppppppppppppppppkkkkppppppppppppppppppppppppkkkkpppppppppppppppppppppccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppcccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppcccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppcccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccccccpppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccpppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkkkkkkpppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppkkkkppppppppppppppppppppkkkkkpppppppkkkkkpppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppkkkkkppppppsssssssssssppppppppppppppppppppppkkkkkppppppsssssssssssssssssssssssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppkkkkkppppppssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkppppppppppppppppppppkkkkkppppppssssssssssppppppppppppppppppppppppppppppppppkkpppppppppppppppkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppsssssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkppppppppppppppppppppsssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppssssssssssssssssssssppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppsssssssssspppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppkkkkkkkpppppppppppppppppppppkkkkkpppppppppppkkkkkkkkpkkkkppppppppkkkkkkkkpkkkkppppppppppppppppkkkkkpppppppppppppppppkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccpkkkkkppppppppppppkkkkkkkpppppppppppppppppppppkkkkkppppppppppppppppppkkkkkkkkpkkkkppppppppppppkkkkkkkkpkkkkppppppppppppkkkkkkkkpkkkkpppppppppppppppppppppkkkkkpppppppppppppppppkkkkkpppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppppppppppppppppppppppppkkpppppppppppppppkkkkkkppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppcccccccccccccccccccccccccccccccccccccccccpkkkkkpppppppppkkkkkkkpppppppppppppppppppppkkkkkppppppppppkkkkkkkkpkkkkppppppppkkkkkkkkpkkkkpppppppppppppkkkkkpppppppppppppppppkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkkpppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppkkkkkppppppssspppppppppppppppppppppppppppppppppppp',
    ),
  ],
};
