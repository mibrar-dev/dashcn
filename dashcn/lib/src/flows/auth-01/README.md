# Auth 01 (`auth-01`)

Sign in, sign up, OTP verify and forgot password with social buttons; every
form validates through `form`. Mobile-first; centres at desktop widths.

## Files

- `flow.dart` — `Auth01Flow` (owns the nested `Navigator`).
- `screens/scaffold.dart` — shared centred-card chrome.
- `screens/sign_in_screen.dart`, `screens/sign_up_screen.dart`,
  `screens/otp_screen.dart`, `screens/forgot_password_screen.dart`,
  `screens/social_buttons.dart`

## Install

```sh
dashcn add flow:auth-01
```

```dart
import 'package:<your_app>/ui/dashcn/flows/auth-01/flow.dart';

Auth01Flow(
  onSignIn: (email, password) => signIn(email, password),
  onSignUp: (name, email, password) => signUp(name, email, password),
  onVerifyOtp: (code) => verifyOtp(code),
  onResetPassword: (email) => resetPassword(email),
  onSocialSignIn: (provider) => socialSignIn(provider),
)
```

## Declared dependencies

| Layer | Units |
|---|---|
| `foundation` | `gap` |
| `theme` | `theme` |
| `components` | `button`, `card`, `form`, `input`, `input_otp`, `page_route` |

## Notes

The flow takes callbacks in and navigates between its own screens; there is
no backend and no demo data in the kit. `/` sign in, `/signup`, `/otp`,
`/forgot`.
