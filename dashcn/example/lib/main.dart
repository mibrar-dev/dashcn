import 'package:dashcn/dashcn.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const DashcnExampleApp());
}

/// Minimal consumer of the public `dashcn` barrel.
class DashcnExampleApp extends StatelessWidget {
  const DashcnExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      // <!-- P8-2 --> becomes DashcnApp.
      title: 'dashcn example',
      home: Button(onPressed: () {}, child: const Text('Hello dashcn')),
    );
  }
}
