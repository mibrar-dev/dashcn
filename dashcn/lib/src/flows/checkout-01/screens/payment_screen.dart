// Payment screen of the `checkout-01` flow: card fields, then `/success`.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import '../../../primitives/localizations/localizations.dart';

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
    final strings = ComponentLocalizations.of(context);
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
                  Text(strings.blockPayment, style: appTheme.typography.h3),
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
                          label: Text(strings.blockCardNumber),
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
                                label: Text(strings.blockExpiry),
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
                                label: Text(strings.blockCvc),
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
                          ? strings.blockPaying
                          : strings.blockPayTotal(
                              '\$${widget.order.total.toStringAsFixed(2)}',
                            ),
                    ),
                  ),
                  Gap(appTheme.spacing.sm),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(strings.blockBackToCart),
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
