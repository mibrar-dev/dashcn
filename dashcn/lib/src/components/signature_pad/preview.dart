// Named examples for the `signature_pad` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'signature_pad.dart';

/// A pad with undo/redo/clear controls and a live stroke count.
class _InteractivePad extends StatefulWidget {
  const _InteractivePad();

  @override
  State<_InteractivePad> createState() => _InteractivePadState();
}

class _InteractivePadState extends State<_InteractivePad> {
  late final SignaturePadController _controller = SignaturePadController();
  int _count = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle label = theme.typography.small.copyWith(
      color: theme.colors.mutedForeground,
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SignaturePad(
            controller: _controller,
            onChanged: (int count) => setState(() => _count = count),
            semanticsLabel: docsSample(context, 'Signature pad demo'),
          ),
          Gap(theme.spacing.sm),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _PadButton(
                label: docsSample(context, 'Undo'),
                onTap: _controller.canUndo
                    ? () => setState(_controller.undo)
                    : null,
              ),
              Gap(theme.spacing.sm),
              _PadButton(
                label: docsSample(context, 'Redo'),
                onTap: _controller.canRedo
                    ? () => setState(_controller.redo)
                    : null,
              ),
              Gap(theme.spacing.sm),
              _PadButton(
                label: docsSample(context, 'Clear'),
                onTap: _controller.isEmpty
                    ? null
                    : () => setState(_controller.clear),
              ),
              const Spacer(),
              Text(
                _count == 1
                    ? docsSample(context, '1 stroke')
                    : '$_count strokes',
                style: label,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small widgets-only text button (keeps the preview free of other
/// components so the scorecard harness renders it standalone).
class _PadButton extends StatelessWidget {
  const _PadButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Disabled uses the muted token rather than Opacity: dimming the text
    // would drop its contrast below the 4.5 minimum.
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: theme.typography.small.copyWith(
          color: onTap == null
              ? theme.colors.mutedForeground
              : theme.colors.primary,
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _InteractivePad();

/// A read-only pad preloaded with a saved stroke, as a restore would show.
class _ReadOnlyPad extends StatefulWidget {
  const _ReadOnlyPad();

  @override
  State<_ReadOnlyPad> createState() => _ReadOnlyPadState();
}

class _ReadOnlyPadState extends State<_ReadOnlyPad> {
  late final SignaturePadController _controller = SignaturePadController()
    ..addStroke(_demoStroke(const Color(0xFF000000)));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: SignaturePad(
        controller: _controller,
        readOnly: true,
        semanticsLabel: docsSample(context, 'Saved signature'),
      ),
    );
  }
}

Widget _readOnly(BuildContext context) => const _ReadOnlyPad();

/// A disabled pad; input is ignored and the surface dims.
Widget _disabled(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 360),
    child: SignaturePad(
      enabled: false,
      semanticsLabel: docsSample(context, 'Signature pad unavailable'),
    ),
  );
}

/// A fixed demo stroke shared by the read-only example and the tests.
SignatureStroke _demoStroke(Color color) {
  final DateTime base = DateTime(2026, 1, 1);
  return SignatureStroke(
    points: <SignaturePoint>[
      for (var i = 0; i < 12; i++)
        SignaturePoint(
          Offset(24 + i * 24, 100 + (i.isEven ? -24 : 24)),
          base.add(Duration(milliseconds: i * 16)),
        ),
    ],
    color: color,
    width: 3,
    minWidth: 1,
  );
}

/// Named docs examples for `signature_pad`; the first entry is the default.
List<ComponentPreview> get signaturePadPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Read-only'), _readOnly),
  ComponentPreview(docsSample(null, 'Disabled'), _disabled),
];
