// Widgets-only preview gallery for the `media_query` component.
//
// The preview drives the width with an explicit `MediaQuery` override, so the
// four theme legs and both viewport directions are visible without a real
// device.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'media_query.dart';
import '../../foundation/component_preview.dart';

/// Preview entry point used by the docs gallery.
class MediaQueryPreview extends StatefulWidget {
  /// Creates the preview.
  const MediaQueryPreview({super.key});

  @override
  State<MediaQueryPreview> createState() => _MediaQueryPreviewState();
}

class _MediaQueryPreviewState extends State<MediaQueryPreview> {
  double _width = 480;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return MediaQuery(
      data: MediaQueryData(size: Size(_width, 640)),
      child: ColoredBox(
        color: colors.background,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('viewport width: ${_width.round()}'),
              SizedBox(height: Theme.of(context).spacing.sm),
              _widthSlider(),
              SizedBox(height: Theme.of(context).spacing.xl),
              _visibility(),
              SizedBox(height: Theme.of(context).spacing.xl),
              _visibility(
                minWidth: 600,
                alternateChild: Text(
                  docsSample(context, 'below the min bound'),
                ),
                child: Text(docsSample(context, 'at or above the min bound')),
              ),
              SizedBox(height: Theme.of(context).spacing.lg),
              _visibility(
                maxWidth: 400,
                alternateChild: Text(
                  docsSample(context, 'above the max bound'),
                ),
                child: Text(docsSample(context, 'at or below the max bound')),
              ),
              SizedBox(height: Theme.of(context).spacing.lg),
              Text(
                docsSample(context, 'scoped theme leg (min 600 / max 1000)'),
              ),
              ComponentTheme<MediaQueryVisibilityTheme>(
                data: const MediaQueryVisibilityTheme(
                  minWidth: 600,
                  maxWidth: 1000,
                ),
                child: MediaQueryVisibility(
                  alternateChild: Text(
                    docsSample(context, 'scoped: outside 600..1000'),
                  ),
                  child: Text(docsSample(context, 'scoped: inside 600..1000')),
                ),
              ),
              SizedBox(height: Theme.of(context).spacing.xl),
              Builder(
                builder: (context) => ColoredBox(
                  color: Theme.of(context).colors.background,
                  child: _visibility(
                    minWidth: 600,
                    alternateChild: Text(docsSample(context, 'dark: mobile')),
                    child: Text(docsSample(context, 'dark: desktop')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widthSlider() => GestureDetector(
    onHorizontalDragUpdate: (details) =>
        setState(() => _width = (_width + details.delta.dx).clamp(240, 1200)),
    child: Container(height: 8, color: ThemeColors.lightFallback.muted),
  );

  Widget _visibility({
    double? minWidth,
    double? maxWidth,
    Widget? alternateChild,
    Widget? child,
  }) {
    return MediaQueryVisibility(
      minWidth: minWidth,
      maxWidth: maxWidth,
      alternateChild:
          alternateChild ??
          Text(docsSample(context, 'collapsed (no alternate)')),
      child: child ?? Text(docsSample(context, 'always shown')),
    );
  }
}
