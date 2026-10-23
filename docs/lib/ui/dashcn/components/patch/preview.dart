// Widgets-only preview gallery for the `patch` component.
//
// Taps increment a counter; the gap between taps and the distance between them
// both reset it.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'patch.dart';
import '../../foundation/component_preview.dart';

/// Preview entry point used by the docs gallery.
class PatchPreview extends StatefulWidget {
  /// Creates the preview.
  const PatchPreview({super.key});

  @override
  State<PatchPreview> createState() => _PatchPreviewState();
}

class _PatchPreviewState extends State<PatchPreview> {
  int _clicks = 0;
  Offset? _lastPosition;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return ColoredBox(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClickDetector(
              onClick: (ClickDetails details) => setState(() {
                _clicks = details.clickCount;
                _lastPosition = details.localPosition;
              }),
              child: Container(
                width: 220,
                height: 120,
                alignment: Alignment.center,
                color: colors.muted,
                child: Text('clicks: $_clicks'),
              ),
            ),
            SizedBox(height: Theme.of(context).spacing.md),
            Text('last position: ${_lastPosition ?? '-'}'),
            SizedBox(height: Theme.of(context).spacing.md),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Button(
                  variant: ButtonVariant.outline,
                  onPressed: () => setState(() => _clicks = 0),
                  child: const Text('reset'),
                ),
                SizedBox(width: Theme.of(context).spacing.md),
                // Loose fit: the hint takes only the width it needs on wide
                // screens (same single-line visuals as before) and wraps
                // instead of overflowing narrow phones.
                Flexible(
                  child: Text(
                    docsSample(context, 'tap fast and near to count up'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
