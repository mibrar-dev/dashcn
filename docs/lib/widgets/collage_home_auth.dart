// Home showcase: auth cards (P6-H1).
//
// `Create Account` and `Verify your phone` extend the Theme Studio blocks
// (`studio_blocks/studio_forms.dart`, `studio_blocks/studio_media.dart`);
// `Welcome back` is the reference home's `Account Access` card, composed
// from the same `Input` / `Button` / `Divider` components.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/divider/divider.dart';
import '../ui/dashcn/components/input/input.dart';
import '../ui/dashcn/components/input_otp/input_otp.dart';
import '../ui/dashcn/components/select/select.dart';
import '../ui/dashcn/components/switch/switch.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Create Account`: the upstream email/password signup card.
class HomeCreateAccountCard extends StatefulWidget {
  /// Creates the card.
  const HomeCreateAccountCard({super.key});

  @override
  State<HomeCreateAccountCard> createState() => _HomeCreateAccountCardState();
}

class _HomeCreateAccountCardState extends State<HomeCreateAccountCard> {
  bool _sameAddress = true;
  String _payout = docsSample(null, 'Bank Transfer');

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeCreateTitle'),
      subtitle: docsHome(locale, 'homeCreateSub'),
      children: <Widget>[
        StudioFieldLabel(docsHome(locale, 'homeEmail')),
        const Gap(6),
        const Input(
          initialValue: '',
          hintText: 'm@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const Gap(16),
        StudioFieldLabel(docsHome(locale, 'homePassword')),
        const Gap(6),
        Input(
          initialValue: '',
          obscureText: true,
          hintText: docsSample(context, 'At least 8 characters'),
        ),
        const Gap(16),
        StudioFieldLabel(docsHome(locale, 'homePayout')),
        const Gap(6),
        Select<String>(
          value: _payout,
          onChanged: (String? next) =>
              setState(() => _payout = next ?? _payout),
          items: <Widget>[
            SelectItem<String>(
              value: docsSample(context, 'Bank Transfer'),
              child: Text(docsSample(context, 'Bank Transfer')),
            ),
            SelectItem<String>(value: 'PayPal', child: Text('PayPal')),
          ],
          itemBuilder: (BuildContext context, String value) => Text(value),
        ),
        const Gap(16),
        Row(
          children: <Widget>[
            Expanded(child: Text(docsHome(locale, 'homeBillingSame'))),
            Switch(
              value: _sameAddress,
              onChanged: (bool value) => setState(() => _sameAddress = value),
            ),
          ],
        ),
        const Gap(16),
        Button(
          variant: ButtonVariant.primary,
          onPressed: () {},
          child: SizedBox(
            width: double.infinity,
            child: Text(
              docsHome(locale, 'homeCreateBtn'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

/// `Welcome back`: the reference home's account-access card.
class HomeLoginCard extends StatelessWidget {
  /// Creates the card.
  const HomeLoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeWelcomeTitle'),
      subtitle: docsHome(locale, 'homeWelcomeSub'),
      children: <Widget>[
        StudioFieldLabel(docsHome(locale, 'homeEmailAddr')),
        Gap(6),
        Input(
          initialValue: '',
          hintText: 'm@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        Gap(16),
        StudioFieldLabel(docsSample(context, 'Password')),
        Gap(6),
        Input(initialValue: '', obscureText: true, hintText: '••••••••'),
        Gap(16),
        Button(
          variant: ButtonVariant.primary,
          onPressed: collageNoop,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              docsHome(locale, 'homeSignIn'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Gap(12),
        Divider(label: Text('or')),
        Gap(12),
        Button(
          variant: ButtonVariant.outline,
          onPressed: collageNoop,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              docsHome(locale, 'homeSso'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Gap(8),
        StudioHelper(docsHome(locale, 'homeForgot')),
      ],
    );
  }
}

/// `Verify your phone`: an OTP field with its action row.
class HomeOtpCard extends StatelessWidget {
  /// Creates the card.
  const HomeOtpCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeOtpTitle'),
      subtitle: docsHome(locale, 'homeOtpSub'),
      children: <Widget>[
        InputOtp(length: 6),
        Gap(16),
        Row(
          children: <Widget>[
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                onPressed: collageNoop,
                child: Text(docsHome(locale, 'homeResend')),
              ),
            ),
            Gap(12),
            Expanded(
              child: Button(
                variant: ButtonVariant.primary,
                onPressed: collageNoop,
                child: Text(docsHome(locale, 'homeVerify')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
