---
title: "Class: Dropzone"
description: "A dashed-look upload surface."
---

```dart
/// A dashed-look upload surface.
///
/// ```dart
/// Dropzone(
///   state: DropzoneState.uploading,
///   onBrowse: _pickFiles,
/// )
/// ```
class Dropzone extends StatelessWidget {
  /// Creates a dropzone.
  const Dropzone({super.key, this.state = DropzoneState.idle, this.isDragOver = false, this.enabled = true, this.focused = false, this.icon, this.hint, this.content, this.actionLabel, this.onBrowse, this.actionVariant = ButtonVariant.outline, this.showAction = true, this.theme, this.focusNode, this.autofocus = false});
  /// Current upload state.
  final DropzoneState state;
  /// Whether a drag is hovering over the surface right now. Takes precedence
  /// over [state] for the border and the icon scale, because it is the live
  /// signal while [state] is the last committed outcome.
  final bool isDragOver;
  /// Whether the surface accepts input.
  final bool enabled;
  /// Whether the surface is focused for keyboard interaction.
  final bool focused;
  /// Icon above the status line; null uses the upload glyph.
  final Widget? icon;
  /// Optional helper line under the status line.
  final Widget? hint;
  /// Extra content below the action, or below the status line when
  /// [showAction] is false.
  final Widget? content;
  /// Browse button label; null resolves the localized default.
  final String? actionLabel;
  /// Called when the browse button is pressed.
  final VoidCallback? onBrowse;
  /// Browse button variant.
  final ButtonVariant actionVariant;
  /// Whether to render the browse button at all.
  final bool showAction;
  /// Widget-leg style override.
  final DropzoneTheme? theme;
  /// Focus node for keyboard activation; null creates one internally.
  final FocusNode? focusNode;
  /// Whether the surface requests focus when first built.
  final bool autofocus;
  Widget build(BuildContext context);
}
```
