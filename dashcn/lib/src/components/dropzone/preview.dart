// Named examples for the `dropzone` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the zone is live — Browse walks the zone through uploading to
// success, hovering paints the drag-over state, and the buttons jump straight
// to a state so every transfer stage is reachable.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'dropzone.dart';

/// The interactive zone: browse, hover and state switching all work.
class _DropzoneDemo extends StatefulWidget {
  const _DropzoneDemo();

  @override
  State<_DropzoneDemo> createState() => _DropzoneDemoState();
}

class _DropzoneDemoState extends State<_DropzoneDemo> {
  DropzoneState _state = DropzoneState.idle;
  bool _dragOver = false;

  void _setState(DropzoneState state) => setState(() => _state = state);

  void _browse() {
    setState(() {
      _dragOver = false;
      _state = _state == DropzoneState.uploading
          ? DropzoneState.success
          : DropzoneState.uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MouseRegion(
          onEnter: (_) => setState(() => _dragOver = true),
          onExit: (_) => setState(() => _dragOver = false),
          child: Dropzone(
            state: _state,
            isDragOver: _dragOver,
            hint: const Text('Up to 10 MB each.'),
            onBrowse: _browse,
          ),
        ),
        Gap(spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: <Widget>[
            for (final DropzoneState state in const <DropzoneState>[
              DropzoneState.idle,
              DropzoneState.uploading,
              DropzoneState.success,
              DropzoneState.error,
            ])
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => _setState(state),
                child: Text(state.name),
              ),
          ],
        ),
      ],
    );
  }
}

/// The zone while a drag hovers over it.
Widget _dropzoneDragOver(BuildContext context) {
  return const Dropzone(
    isDragOver: true,
    hint: Text('Release to upload.'),
    onBrowse: _dropzoneBrowse,
  );
}

void _dropzoneBrowse() {}

/// The uploading state, then a success one.
Widget _dropzoneUploading(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Dropzone(state: DropzoneState.uploading),
      SizedBox(height: 24),
      Dropzone(state: DropzoneState.success),
    ],
  );
}

/// The error state plus the disabled one.
Widget _dropzoneError(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Dropzone(state: DropzoneState.error),
      SizedBox(height: 24),
      Dropzone(enabled: false),
    ],
  );
}

/// The zone with a custom hint instead of the default content.
Widget _dropzoneCustom(BuildContext context) {
  return const Dropzone(
    showAction: false,
    content: Text('Drop a folder here to upload it whole.'),
  );
}

Widget _dropzoneDefault(BuildContext context) => const _DropzoneDemo();

/// Named docs examples for `dropzone`; the first entry is the default.
const List<ComponentPreview> dropzonePreviews = <ComponentPreview>[
  ComponentPreview('Default', _dropzoneDefault),
  ComponentPreview('Drag over', _dropzoneDragOver),
  ComponentPreview('Uploading', _dropzoneUploading),
  ComponentPreview('Error', _dropzoneError),
  ComponentPreview('Custom content', _dropzoneCustom),
];
