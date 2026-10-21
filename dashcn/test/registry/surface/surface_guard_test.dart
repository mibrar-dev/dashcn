// Analysis guard: no new direct solid surface paint in `lib/src/components`.
//
// Fails when a component file paints `colors.background` / `colors.card` /
// `colors.popover` (the surface tokens) without routing through the shared
// `primitives/surface.dart` primitive (`surfaceColor`, `GlassSurface`,
// `resolveSurfaceOpacity`/`resolveSurfaceBlur`) or a surface already covered
// by it (`MenuPopupSurface`, `GooeySurface`). Add a new entry — with a reason
// — to [_allowList] instead of weakening the patterns when a legitimate
// non-surface exception appears. Blocks/flows page backgrounds stay opaque by
// design (see AUDIT.md) and are out of scope for this components-only guard.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A direct surface-token paint without the primitive.
class _Violation {
  const _Violation(this.file, this.line);
  final String file;
  final int line;
}

/// Relative paths (under `lib/src/components/`) whose surface-token hit is a
/// reviewed non-violation, with the reason it stays direct.
const Map<String, String> _allowList = <String, String>{
  'components/autocomplete/autocomplete.dart':
      'delegates: colors.popover is the fill passed to MenuPopupSurface, which frosts internally.',
  'components/avatar/avatar.dart':
      'separator ring behind stacked avatars, not a floating/raised surface; no blur layer by design.',
  'components/chart/chart.dart':
      'canvas paints (backgroundColor, strokeColor), not a box surface.',
  'components/chart/chart_style.dart':
      'tooltipFill data; the box paint lives in chart_tooltip.dart (frosted).',
  'components/eye_dropper/eye_dropper.dart':
      'PixelGridPainter canvas background; stays opaque so sampled colours stay accurate.',
  'components/file_diff_viewer/file_diff_viewer.dart':
      'contrast fallback for marker ink, not a fill paint.',
  'components/file_diff_viewer/file_diff_viewer_style.dart':
      'FileDiffSurface data; the container is an inline diff-text layout, not a floating surface.',
  'components/gooey_toast/gooey_toast_options.dart':
      'contrast reference for ensureToneContrast, not a paint; the toast paints via GooeySurface.',
  'components/markdown/markdown_style.dart':
      'renderer data (surface/onSurface), not a box paint here.',
  'components/number_ticker/number_ticker.dart':
      'ShaderMask edge-fade shader colours, not a box fill.',
  'components/overflow_marquee/overflow_marquee_style.dart':
      'edge-fade fadeColor shader, not a box surface.',
  'components/scrollable/scrollable.dart':
      'fade-mask helper (resolveFadeSurface), not a box surface.',
  'components/slider/slider.dart':
      'slider thumb control fill, not a surface; controls stay opaque.',
};

/// Surface-token use that is NOT a foreground/border/shader reference.
final RegExp _surfaceToken = RegExp(
  r'colors\.(background|card|popover)\b(?!Foreground)',
);

/// Paint widgets that count as a solid surface fill.
final RegExp _paintSite = RegExp(
  r'ColoredBox|BoxDecoration|DecoratedBox|Container\s*\(|PhysicalModel|backgroundColor\s*:',
);

/// Routing through the shared surface primitive (directly or via a surface
/// that already owns it).
final RegExp _throughPrimitive = RegExp(
  r'surfaceColor|GlassSurface|SurfaceBlur|resolveSurfaceOpacity|resolveSurfaceBlur|MenuPopupSurface|GooeySurface',
);

List<_Violation> _scan(Directory components) {
  final List<_Violation> out = <_Violation>[];
  for (final FileSystemEntity entity in components.listSync(
    recursive: true,
    followLinks: false,
  )) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    if (entity.path.contains('preview.dart')) continue;
    final String text = entity.readAsStringSync();
    if (!_surfaceToken.hasMatch(text)) continue;
    if (_throughPrimitive.hasMatch(text)) continue;
    final String rel = entity.path.split('lib/src/').last;
    if (_allowList.containsKey(rel)) continue;
    // Only flag files that actually paint (not pure token-ref data files).
    // Data-only hits (e.g. a `?? colors.card` default with no paint widget)
    // are still listed here to force an explicit allow-list entry.
    if (!_paintSite.hasMatch(text)) continue;
    final List<String> lines = text.split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (_surfaceToken.hasMatch(lines[i])) {
        out.add(_Violation('$rel:${i + 1}', i + 1));
        break;
      }
    }
  }
  return out;
}

void main() {
  test('no direct solid surface paint without the surface primitive', () {
    final Directory here = Directory.current;
    final Directory components = Directory('${here.path}/lib/src/components');
    expect(
      components.existsSync(),
      isTrue,
      reason: 'run from dashcn/ (found ${here.path})',
    );
    final List<_Violation> violations = _scan(components);
    expect(
      violations,
      isEmpty,
      reason:
          'direct colors.background/card/popover paint without surfaceColor/GlassSurface: '
          '${violations.map((v) => v.file).join(', ')}. '
          'Route through the primitive or add an allow-list entry with a reason.',
    );
  });

  test('allow-list entries still match a surface-token hit', () {
    final Directory components = Directory(
      '${Directory.current.path}/lib/src/components',
    );
    for (final MapEntry<String, String> entry in _allowList.entries) {
      expect(entry.value.trim(), isNotEmpty, reason: '${entry.key}: reason');
      // Entries are `components/...`, relative to `lib/src/`.
      final File resolved = File(
        '${components.path}/${entry.key.replaceFirst('components/', '')}',
      );
      expect(
        resolved.existsSync(),
        isTrue,
        reason: '${entry.key} no longer exists; drop it from the allow-list',
      );
      expect(
        _surfaceToken.hasMatch(resolved.readAsStringSync()),
        isTrue,
        reason: '${entry.key} no longer hits the token; drop it',
      );
    }
  });
}
