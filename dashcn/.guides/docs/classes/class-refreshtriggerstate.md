---
title: "Class: RefreshTriggerState"
description: "Reference for RefreshTriggerState"
---

```dart
class RefreshTriggerState extends State<RefreshTrigger> {
  TriggerStage get stage;
  void didChangeDependencies();
  void didUpdateWidget(covariant RefreshTrigger oldWidget);
  Future<void> refresh([Future<void> Function()? callback]);
  Widget build(BuildContext context);
}
```
