// P7-BF1: form validation appears only when the user has edited a field or
// submitted the form — never on first render.
//
// The regression this guards against: a value supplier reports its starting
// value to the form while it mounts, and that report used to be counted as a
// `changed` validation, so every untouched field opened with its error
// already on screen (login-01 showed "This field cannot be empty." under both
// Email and Password).

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/form/form.dart';
import 'package:flutter_shadcn_kit/registry/components/input/input.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const FormKey<String> _emailKey = FormKey<String>('email');
const FormKey<String> _passwordKey = FormKey<String>('password');

/// The messages the field validators in this file can produce.
const String _empty = 'This field cannot be empty.';
const String _badEmail = 'Invalid email address.';

/// Keeps a single `OverlayEntry` so repumping the frame updates its child.
/// `EditableText` needs an `Overlay` ancestor (text selection surface).
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

Widget _frame(Widget child) => ShadcnTheme(
  data: const ShadcnThemeData(),
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: _OverlayHost(child: child),
  ),
);

ShadcnForm _form(FormController controller, List<Widget> fields) => ShadcnForm(
  controller: controller,
  child: Column(children: fields),
);

void main() {
  testWidgets('a fresh form shows no validation message', (tester) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            child: const Input(),
          ),
          ShadcnFormField<String>(
            key: _passwordKey,
            label: const Text('Password'),
            validator:
                const NotEmptyValidator() & const LengthValidator(min: 8),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.text(_empty), findsNothing);
    expect(find.text(_badEmail), findsNothing);
  });

  testWidgets('a field seeded with an invalid value stays silent', (
    tester,
  ) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            // A pre-filled, invalid value is still not an edit.
            child: const Input(initialValue: 'not-an-email'),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsNothing);
    expect(controller.getDisplayError(_emailKey), isNull);
    // The value is stored, so a submit still validates it.
    expect(controller.getValue(_emailKey), 'not-an-email');
  });

  testWidgets('typing invalid text shows only that field', (tester) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            child: const Input(),
          ),
          ShadcnFormField<String>(
            key: _passwordKey,
            label: const Text('Password'),
            validator:
                const NotEmptyValidator() & const LengthValidator(min: 8),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(EditableText).first, 'not-an-email');
    await tester.pump();
    await tester.pump();

    expect(find.text(_badEmail), findsOneWidget);
    expect(find.text(_empty), findsNothing, reason: 'password is untouched');
  });

  testWidgets('submit shows every invalid field', (tester) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            child: const Input(),
          ),
          ShadcnFormField<String>(
            key: _passwordKey,
            label: const Text('Password'),
            validator:
                const NotEmptyValidator() & const LengthValidator(min: 8),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    expect(find.text(_empty), findsNothing);

    final BuildContext context = tester.element(find.byType(ShadcnForm));
    await controller.submit(context);
    await tester.pump();
    await tester.pump();
    expect(find.text(_empty), findsNWidgets(2));
    expect(controller.isSubmitted, isTrue);
  });

  testWidgets('fixing a field clears its message and keeps it live', (
    tester,
  ) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(EditableText), 'not-an-email');
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'ada@example.com');
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsNothing);

    // Still live after the fix: breaking it again reports at once.
    await tester.enterText(find.byType(EditableText), 'broken');
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);
  });

  testWidgets('reset clears the dirty and submitted state', (tester) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(EditableText), 'broken');
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);

    final BuildContext context = tester.element(find.byType(ShadcnForm));
    await controller.submit(context);
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);

    controller.reset();
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsNothing);
    expect(controller.isSubmitted, isFalse);
    // Values survive a validation reset.
    expect(controller.getValue(_emailKey), 'broken');

    // The field is quiet again until it is edited or submitted.
    expect(controller.getDisplayError(_emailKey), isNull);

    // A submit re-arms every invalid field...
    await controller.submit(context);
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);

    // ...and so does a fresh edit.
    controller.reset();
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsNothing);
    await tester.enterText(find.byType(EditableText), 'still-broken');
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);
  });

  testWidgets('an untouched field stays silent while another is edited', (
    tester,
  ) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator() & const EmailValidator(),
            child: const Input(),
          ),
          ShadcnFormField<String>(
            key: _passwordKey,
            label: const Text('Password'),
            validator:
                const NotEmptyValidator() & const LengthValidator(min: 8),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(EditableText).first, 'nope');
    await tester.pump();
    await tester.pump();
    expect(find.text(_badEmail), findsOneWidget);
    expect(find.text(_empty), findsNothing);
  });

  testWidgets('the default showErrors set defers to a submit', (tester) async {
    final FormController controller = FormController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _frame(
        _form(controller, <Widget>[
          ShadcnFormField<String>(
            key: _emailKey,
            label: const Text('Email'),
            validator: const NotEmptyValidator(),
            child: const Input(),
          ),
        ]),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(EditableText), 'x');
    await tester.pump();
    await tester.pump();
    expect(controller.getDisplayError(_emailKey), isNull);

    // An explicit narrower set keeps the live message too: empty is invalid
    // either way, so clear the text and let the `changed` mode report it.
    await tester.enterText(find.byType(EditableText), '');
    await tester.pump();
    await tester.pump();
    expect(controller.getDisplayError(_emailKey), isA<InvalidResult>());
  });
}
