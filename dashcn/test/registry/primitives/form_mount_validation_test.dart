// Mount-time validation: `changed` means a value change after mount.
//
// Regression tests for the mount-time error bug: the supplier's initial
// value publication arrived as the controller's second attach, so
// `{changed}` validators ran (and `{changed, submitted}` error builders
// showed errors) before any edit.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/blocks/login-01/login_01.dart';
import 'package:dashcn/src/components/form/form.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/flows/auth-01/flow.dart';
import 'package:dashcn/src/flows/chat-01/flow.dart';
import 'package:dashcn/src/flows/checkout-01/flow.dart';
import 'package:dashcn/src/flows/onboarding-01/flow.dart';
import 'package:dashcn/src/flows/settings-01/flow.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blocks/blocks_support.dart';
import '../flows/flows_support.dart';

const FormKey<String> _emailKey = FormKey<String>('email');

/// Keeps a single `OverlayEntry` so repumping the frame updates its child.
class _OverlayHost extends StatefulWidget {
  const _OverlayHost({required this.child});

  final Widget child;

  @override
  State<_OverlayHost> createState() => _OverlayHostState();
}

class _OverlayHostState extends State<_OverlayHost> {
  late final OverlayEntry _entry = OverlayEntry(
    builder: (_) => Align(alignment: Alignment.topLeft, child: widget.child),
  );

  @override
  void didUpdateWidget(covariant _OverlayHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    _entry.markNeedsBuild();
  }

  @override
  void dispose() {
    _entry
      ..remove()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Overlay(initialEntries: <OverlayEntry>[_entry]);
}

Widget _frame(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: _OverlayHost(child: child),
    ),
  );
}

FormScope _form(
  FormController controller,
  Validator<String> validator, {
  Set<FormValidationMode>? showErrors = const <FormValidationMode>{
    FormValidationMode.changed,
    FormValidationMode.submitted,
  },
}) {
  return FormScope(
    controller: controller,
    child: Column(
      children: <Widget>[
        FormItem<String>(
          key: _emailKey,
          label: const Text('Email'),
          validator: validator,
          showErrors: showErrors,
          child: const Input(),
        ),
      ],
    ),
  );
}

/// Validation messages that must never render before the first edit.
const List<String> _mountErrorTexts = <String>[
  'This field cannot be empty.',
  'Invalid email address.',
  'Invalid value provided.',
];

void _expectNoMountErrors(WidgetTester tester) {
  for (final String message in _mountErrorTexts) {
    expect(find.text(message), findsNothing, reason: 'mount shows $message');
  }
}

void main() {
  group('mount-time validation', () {
    testWidgets('changed validators show nothing on mount', (tester) async {
      final FormController controller = FormController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          _form(
            controller,
            ValidationMode<String>(
              NotEmptyValidator(),
              mode: <FormValidationMode>{FormValidationMode.changed},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      _expectNoMountErrors(tester);
      expect(tester.takeException(), isNull);
    });

    testWidgets('changed validators fire after the first edit', (tester) async {
      final FormController controller = FormController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          _form(
            controller,
            ValidationMode<String>(
              NotEmptyValidator(),
              mode: <FormValidationMode>{FormValidationMode.changed},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      await tester.enterText(find.byType(EditableText), 'x');
      await tester.pump();
      await tester.pump();
      expect(find.text('This field cannot be empty.'), findsNothing);
      await tester.enterText(find.byType(EditableText), '');
      await tester.pump();
      await tester.pump();
      expect(find.text('This field cannot be empty.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('initial validators still run at mount', (tester) async {
      final FormController controller = FormController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          _form(
            controller,
            ValidationMode<String>(
              NotEmptyValidator(),
              mode: <FormValidationMode>{
                FormValidationMode.initial,
                FormValidationMode.changed,
                FormValidationMode.submitted,
              },
            ),
            showErrors: <FormValidationMode>{
              FormValidationMode.initial,
              FormValidationMode.changed,
              FormValidationMode.submitted,
            },
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      // Opted into mount-time errors: the message renders on first frame.
      expect(find.text('This field cannot be empty.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('login-01 renders with no errors on first frame', (
      tester,
    ) async {
      await pumpBlock(
        tester,
        Login01(),
        blockTheme('neutral', Brightness.light),
        768,
      );
      _expectNoMountErrors(tester);
    });

    testWidgets('flows render with no errors on first frame', (tester) async {
      final List<Widget> flows = <Widget>[
        Auth01Flow(),
        Chat01Flow(),
        Checkout01Flow(),
        Onboarding01Flow(),
        Settings01Flow(),
      ];
      for (final Widget flow in flows) {
        await pumpFlow(
          tester,
          flow,
          brightness: Brightness.light,
          direction: TextDirection.ltr,
        );
        _expectNoMountErrors(tester);
      }
    });
  });
}
