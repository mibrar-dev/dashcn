---
title: "Class: RecentColorsScopeState"
description: "State of [RecentColorsScope], itself the storage implementation."
---

```dart
/// State of [RecentColorsScope], itself the storage implementation.
class RecentColorsScopeState extends State<RecentColorsScope> implements ColorHistoryStorage {
  void initState();
  int get capacity;
  List<Color> get recentColors;
  void addHistory(Color color);
  void clear();
  void setHistory(List<Color> colors);
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
  void dispose();
  Widget build(BuildContext context);
}
```
