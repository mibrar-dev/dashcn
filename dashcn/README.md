# dashcn

A widgets-only Flutter design system: themed components, blocks, and presets,
without Material or Cupertino.

## Install

```sh
flutter pub add dashcn
```

## Use

```dart
import 'package:dashcn/dashcn.dart'; // <!-- P8-2 --> barrel name is final; symbol names land in P8-2.

void main() {
  runApp(const DashcnApp( // <!-- P8-2 --> becomes DashcnApp.
    home: SizedBox.shrink(),
  ));
}
```

Per-layer and per-component imports keep builds lean:

```dart
import 'package:dashcn/theme.dart';
import 'package:dashcn/components/button.dart';
```

## Own the code

Prefer vendored sources over the package dependency? The `dashcn` CLI copies
component sources into your app (`dashcn add button`). See the docs site.
