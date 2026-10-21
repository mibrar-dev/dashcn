// Address sheet body of the `checkout-01` flow: validated address form
// shown inside the cart's [PinnedSheet].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import '../../../primitives/localizations/localizations.dart';

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
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(strings.blockDeliveryAddress, style: appTheme.typography.h3),
          Gap(appTheme.spacing.md),
          FormScope(
            controller: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormItem<String>(
                  key: _nameKey,
                  label: Text(strings.authName),
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
                  label: Text(strings.blockStreet),
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
                  label: Text(strings.blockCity),
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
            child: Text(strings.actionClose),
          ),
        ],
      ),
    );
  }
}
