// Success screen of the `checkout-01` flow: confirmation + done.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../foundation/gap.dart';
import '../../../foundation/icons/radix_icons.dart';
import '../../../theme/theme.dart';
import '../../../primitives/localizations/localizations.dart';
import '../../../foundation/component_preview.dart';

/// Order confirmation; Done calls [onDone].
class Checkout01SuccessScreen extends StatelessWidget {
  /// Creates the success screen.
  const Checkout01SuccessScreen({super.key, this.onDone});

  /// Called when Done is tapped.
  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
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
                    docsSample(context, 'Order placed'),
                    style: appTheme.typography.h3,
                    textAlign: TextAlign.center,
                  ),
                  Gap(appTheme.spacing.sm),
                  Text(
                    strings.blockOrderThanks,
                    textAlign: TextAlign.center,
                    style: appTheme.typography.textMuted.copyWith(
                      color: appTheme.colors.mutedForeground,
                    ),
                  ),
                  Gap(appTheme.spacing.xl),
                  Button(
                    key: const ValueKey<String>('checkout01.done'),
                    onPressed: onDone,
                    child: Text(strings.blockContinueShopping),
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
