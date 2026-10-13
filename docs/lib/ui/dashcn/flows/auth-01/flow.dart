// The `auth-01` flow: sign in, sign up, OTP verify and forgot password.
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
