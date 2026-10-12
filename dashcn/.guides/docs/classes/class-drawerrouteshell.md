---
title: "Class: DrawerRouteShell"
description: "The panel shell of a [DrawerRoute]; built by the route's page."
---

```dart
/// The panel shell of a [DrawerRoute]; built by the route's page.
class DrawerRouteShell extends StatefulWidget {
  /// Creates the shell for [route].
  const DrawerRouteShell(this.route, {super.key});
  /// The route whose values drive this shell.
  final DrawerRoute<dynamic> route;
  State<DrawerRouteShell> createState();
}
```
