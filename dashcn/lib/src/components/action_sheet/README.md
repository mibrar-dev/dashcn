# ActionSheet

A bottom sheet of actions with title and message, destructive and cancel actions.

## Usage

```dart
showActionSheet<void>(
  context: context,
  title: 'Actions',
  actions: [
    ActionSheetAction(label: 'Edit', onPressed: () {}),
  ],
  cancelAction: ActionSheetAction(label: 'Cancel'),
);
```
