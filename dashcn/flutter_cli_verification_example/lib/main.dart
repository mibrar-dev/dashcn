import 'package:flutter/material.dart' as material;

import 'ui/dashcn/components/control/button/button.dart';
import 'ui/dashcn/components/form/text_field/text_field.dart';
import 'ui/dashcn/components/layout/card/card.dart';
import 'ui/dashcn/components/overlay/dialog/dialog.dart' as dashcn_dialog;
import 'ui/dashcn/shared/primitives/overlay.dart';
import 'ui/dashcn/shared/theme/theme.dart' as dashcn;

void main() {
  material.runApp(const VerificationHarnessApp());
}

class VerificationHarnessApp extends material.StatelessWidget {
  const VerificationHarnessApp({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return material.MaterialApp(
      debugShowCheckedModeBanner: false,
      home: dashcn.Theme(
        data: const dashcn.ThemeData(),
        child: const AppLayer(
          child: material.Material(
            type: material.MaterialType.transparency,
            child: VerificationHarnessScreen(),
          ),
        ),
      ),
    );
  }
}

class MyApp extends VerificationHarnessApp {
  const MyApp({super.key});
}

class VerificationHarnessScreen extends material.StatelessWidget {
  const VerificationHarnessScreen({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      body: material.SafeArea(
        child: material.Center(
          child: material.SingleChildScrollView(
            padding: const material.EdgeInsets.all(24),
            child: material.ConstrainedBox(
              constraints: const material.BoxConstraints(maxWidth: 420),
              child: Card(
                padding: const material.EdgeInsets.all(24),
                child: material.Column(
                  mainAxisSize: material.MainAxisSize.min,
                  crossAxisAlignment: material.CrossAxisAlignment.start,
                  children: [
                    const material.Text('Registry Verification Harness'),
                    const material.SizedBox(height: 8),
                    const material.Text(
                      'Exercises the locally installed button, text field, and dialog components.',
                    ),
                    const material.SizedBox(height: 20),
                    const TextField(
                      placeholder: material.Text('Email address'),
                    ),
                    const material.SizedBox(height: 16),
                    const TextField(
                      placeholder: material.Text('Password'),
                      obscureText: true,
                    ),
                    const material.SizedBox(height: 20),
                    PrimaryButton(
                      onPressed: () => _openDialog(context),
                      child: const material.Text('Open Dialog'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openDialog(material.BuildContext context) {
    dashcn_dialog.showDialog<void>(
      context: context,
      builder: (context) {
        return Card(
          padding: const material.EdgeInsets.all(24),
          child: material.Column(
            mainAxisSize: material.MainAxisSize.min,
            crossAxisAlignment: material.CrossAxisAlignment.start,
            children: [
              const material.Text('Harness dialog'),
              const material.SizedBox(height: 12),
              const material.Text(
                'This confirms the installed dialog route and card surface render correctly.',
              ),
              const material.SizedBox(height: 20),
              material.Row(
                children: [
                  const material.Spacer(),
                  PrimaryButton(
                    onPressed: () => material.Navigator.of(context).pop(),
                    child: const material.Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
