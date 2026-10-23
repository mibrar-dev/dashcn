// The `pricing-01` block, part 2: the validated promo-code form.
//
// Imported by `pricing_01.dart`; a block never imports another block.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../components/alert/alert.dart';
import '../../components/button/button.dart';
import '../../components/form/form.dart';
import '../../components/input_otp/input_otp.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import '../../foundation/component_preview.dart';

/// Values submitted by the [Pricing01PromoForm] promo-code form.
class Pricing01PromoData {
  /// Creates the submitted values.
  const Pricing01PromoData({required this.code});

  /// The validated 6-character promo code.
  final String code;
}

/// The promo-code form: a validated 6-character code with an Apply action.
class Pricing01PromoForm extends StatefulWidget {
  /// Creates the promo-code form.
  const Pricing01PromoForm({super.key, required this.onApplyPromo});

  /// Called once with the typed values after a valid submit.
  final FutureOr<void> Function(Pricing01PromoData data)? onApplyPromo;

  @override
  State<Pricing01PromoForm> createState() => _Pricing01PromoFormState();
}

class _Pricing01PromoFormState extends State<Pricing01PromoForm> {
  static final Validator<String> _codeValidator =
      const NotEmptyValidator() &
      const LengthValidator(min: 6, max: 6) &
      RegexValidator(RegExp(r'^[A-Za-z0-9]{6}$'));

  final FormController _controller = FormController();
  final FormKey<String> _codeKey = const FormKey<String>('promoCode');
  bool _succeeded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Validates and applies; false when invalid. The button maps false to
  /// its failure state; the keyboard path just surfaces field errors.
  Future<bool> _apply() async {
    if (mounted) {
      setState(() => _succeeded = false);
    }
    final SubmissionResult result = await _controller.submit(context);
    if (!mounted) {
      return false;
    }
    return result.isValid;
  }

  Future<void> _handleValidSubmit(FormMapValues values) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final Pricing01PromoData data = Pricing01PromoData(
      code: values.getValue(_codeKey) ?? '',
    );
    await widget.onApplyPromo?.call(data);
    if (!mounted) {
      return;
    }
    setState(() => _succeeded = true);
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 384),
      child: FormScope(
        controller: _controller,
        onSubmit: _handleValidSubmit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              docsSample(context, 'Have a code? Enter it below.'),
              textAlign: TextAlign.center,
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
            Gap(theme.spacing.md),
            FormItem<String>(
              key: _codeKey,
              label: Text(strings.blockPromoCode),
              validator: _codeValidator,
              showErrors: const <FormValidationMode>{
                FormValidationMode.changed,
                FormValidationMode.submitted,
              },
              child: InputOtp(
                length: 6,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _apply(),
              ),
            ),
            Gap(theme.spacing.lg),
            Button(
              variant: ButtonVariant.outline,
              onPressedAsync: () async {
                if (!await _apply()) {
                  throw StateError('Pricing01Promo: validation failed.');
                }
              },
              child: Text(strings.blockApplyCode),
            ),
            if (_succeeded) ...<Widget>[
              Gap(theme.spacing.lg),
              Alert(
                content: Text(
                  docsSample(
                    context,
                    docsSample(
                      context,
                      docsSample(context, 'Code applied — your discount shows at checkout.'),
                    ),
                  ),
                  style: theme.typography.textSmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
