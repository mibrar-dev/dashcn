// Named examples for the `qr_code` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../input/input.dart';
import 'qr_code.dart';

/// A fixed-size code for a URL.
Widget _default(BuildContext context) {
  return const QrCode(data: 'https://example.com', size: 200);
}

/// A code that re-encodes as the URL field changes.
class _LiveUrl extends StatefulWidget {
  const _LiveUrl();

  @override
  State<_LiveUrl> createState() => _LiveUrlState();
}

class _LiveUrlState extends State<_LiveUrl> {
  final TextEditingController _controller = TextEditingController(
    text: 'https://example.com',
  );
  String _url = 'https://example.com';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Input(
            controller: _controller,
            hintText: 'https://…',
            onChanged: (String value) => setState(() => _url = value),
          ),
          Gap(theme.spacing.md),
          QrCode(
            data: _url,
            size: 200,
            semanticsLabel: 'QR code for the typed URL',
          ),
        ],
      ),
    );
  }
}

Widget _liveUrl(BuildContext context) => const _LiveUrl();

/// The three module shapes, plus a logo cleared into the centre.
class _Shapes extends StatelessWidget {
  const _Shapes();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Widget cell(String label, QrModuleShape shape) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          QrCode(data: 'dashcn', size: 120, moduleShape: shape),
          Gap(theme.spacing.xs),
          Text(label, style: theme.typography.small),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Wrap, not Row: three 120 px codes overflow a phone-width preview.
        Wrap(
          alignment: WrapAlignment.center,
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.md,
          children: <Widget>[
            cell('Square', QrModuleShape.square),
            cell('Rounded', QrModuleShape.rounded),
            cell('Dot', QrModuleShape.dot),
          ],
        ),
        Gap(theme.spacing.md),
        QrCode(
          data: 'https://example.com',
          size: 160,
          errorCorrectLevel: QrErrorCorrectionLevel.high,
          center: ColoredBox(
            color: theme.colors.background,
            child: Center(child: Text('D', style: theme.typography.large)),
          ),
        ),
      ],
    );
  }
}

Widget _shapes(BuildContext context) => const _Shapes();

/// Named docs examples for `qr_code`; the first entry is the default.
const List<ComponentPreview> qrCodePreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Live URL', _liveUrl),
  ComponentPreview('Shapes', _shapes),
];
