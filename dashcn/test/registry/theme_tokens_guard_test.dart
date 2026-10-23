// Guard: theme tokens drive every component (theme_tokens_audit).
//
// Scans `lib/src/components`, `lib/src/primitives`, `lib/src/blocks` and
// `lib/src/flows` (excluding docs-sample `preview.dart` files and full-line
// comments) for hard-coded values a theme token should own, and fails on any
// hit that is not covered by [_allowList]. Add a new entry — with a reason —
// instead of weakening the patterns when a legitimate exception appears.
//
// Covered:
//   * literal radii: `BorderRadius.circular(<digit>` / `Radius.circular(<digit>`
//     must derive from the theme radius scale (`theme.borderRadiusXs/Sm/Md/Lg/Xl`
//     or the `radius*` doubles). Pill/circle geometry (`999`, `size / 2`,
//     `h / 2`) and paint-geometry constants are allow-listed per file.
//   * literal colors: `Color(0x...)` other than transparent
//     (`Color(0x00000000)`, which is not a theme color) must come from the
//     color tokens. Media scrims, data-viz canvas colors, color-science
//     constants, shader-mask whites and barrier blacks are allow-listed
//     per file with a reason.
// Token definitions themselves (`lib/src/theme`, `lib/src/foundation`) are
// outside the scan.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A single allowed exception: [pattern] matches the offending line, [reason]
/// justifies why it stays hard-coded.
class _Allowed {
  const _Allowed(this.pattern, this.reason);
  final Pattern pattern;
  final String reason;
}

/// Roots scanned by this guard. Theme/foundation hold the token definitions.
const List<String> _scanRoots = <String>[
  'lib/src/components',
  'lib/src/primitives',
  'lib/src/blocks',
  'lib/src/flows',
];

/// Literal radius followed by a digit: a fixed px value instead of the
/// theme radius scale. Geometric derivations (`size / 2`, `h / 2`,
/// `swatch / 2`, `cell * 0.3`) do not match.
final RegExp _literalRadius = RegExp(r'(BorderRadius|Radius)\.circular\(\s*\d');

/// Literal color other than transparent. Transparent is not a theme color.
final RegExp _literalColor = RegExp(r'Color\(0x(?!00000000)');

/// Explicit per-exception allow-list. Each entry needs a reason.
const Map<String, List<_Allowed>> _allowList = <String, List<_Allowed>>{
  // Pill/circle geometry: round by design, not by scale step.
  'components/chat/chat.dart': <_Allowed>[
    _Allowed('Radius.circular(999)', 'reaction pill: round by design.'),
  ],
  'components/file_diff_viewer/file_diff_viewer.dart': <_Allowed>[
    _Allowed('BorderRadius.circular(999)', 'stat pill: round by design.'),
  ],
  'primitives/gooey/gooey_chip.dart': <_Allowed>[
    _Allowed('BorderRadius.circular(999)', 'gooey pill chip: round by design.'),
  ],
  'flows/chat-01/screens/thread_list_screen.dart': <_Allowed>[
    _Allowed(
      'BorderRadius.circular(999)',
      'unread-count pill: round by design.',
    ),
  ],
  // Drag-handle pill: radius is half the 4px handle height (geometry).
  'primitives/popover_overlay_state.dart': <_Allowed>[
    _Allowed(
      'BorderRadius.circular(2)',
      'bottom-sheet drag handle: h/2 pill geometry.',
    ),
  ],
  // Paint-geometry constants in CustomPainters (no BuildContext, sub-pixel).
  'primitives/slider/slider_painter.dart': <_Allowed>[
    _Allowed('Radius.circular(1)', '1px slider tick paint geometry.'),
  ],
  'components/audio_player/audio_player_compact_parts.dart': <_Allowed>[
    _Allowed('Radius.circular(4)', 'waveform ring paint geometry.'),
  ],
  // Deliberately fixed: a key hint reads as a key only at a fixed rounding.
  'components/keyboard_shortcut/keyboard_shortcut_style.dart': <_Allowed>[
    _Allowed(
      'Radius.circular(4)',
      'intentional per code doc (P7-WC2); override via keyBorderRadius.',
    ),
  ],
  // Context-free painter fallback: callers pass the theme-derived color.
  'primitives/text/list.dart': <_Allowed>[
    _Allowed('0xFF000000', 'bullet painter fallback without a BuildContext.'),
  ],
  // Bespoke resting shadow: ShadowScale steps do not reproduce its geometry.
  'components/audio_player/audio_player.dart': <_Allowed>[
    _Allowed(
      '0x14000000',
      'compact resting shadow geometry; tint stays opaque black.',
    ),
  ],
  // White modulate base for an opacity colorFilter, not a surface color.
  'components/border_loading/border_loading.dart': <_Allowed>[
    _Allowed(
      '0xFFFFFFFF',
      'color-science modulate base for the opacity filter.',
    ),
  ],
  // Barrier scrims: conventional translucent black, no barrier token exists.
  'components/dialog/dialog.dart': <_Allowed>[
    _Allowed(
      '0x80000000',
      'modal barrier black (kDialogFallbackBarrierColor).',
    ),
  ],
  'components/dialog/dialog_style.dart': <_Allowed>[
    _Allowed('0x80000000', 'modal barrier black.'),
  ],
  'components/drawer/drawer_style.dart': <_Allowed>[
    _Allowed('0x80000000', 'drawer barrier black.'),
  ],
  'components/drawer/drawer_background_scale.dart': <_Allowed>[
    _Allowed('0xFF000000', 'animated dim scrim over scaled content.'),
  ],
  'components/swiper/swiper.dart': <_Allowed>[
    _Allowed('0x80000000', 'fullscreen barrier black.'),
  ],
  'components/overlay_configuration/overlay_configuration.dart': <_Allowed>[
    _Allowed('0x80000000', 'overlay barrier black.'),
  ],
  'components/color_input/color_input.dart': <_Allowed>[
    _Allowed('0x80000000', 'picker dialog barrier black.'),
  ],
  'primitives/drawer_route/drawer_panel.dart': <_Allowed>[
    _Allowed('0x80000000', 'drawer barrier black.'),
  ],
  'primitives/form_core/object_form_field.dart': <_Allowed>[
    _Allowed('0x80000000', 'form dialog barrier black.'),
  ],
  'primitives/markdown_parser/media.dart': <_Allowed>[
    _Allowed('0x80000000', 'image-preview barrier black.'),
  ],
  'components/image_lightbox/image_lightbox_style.dart': <_Allowed>[
    _Allowed('0x99000000', 'lightbox barrier over image content.'),
  ],
  'components/image_lightbox/image_lightbox.dart': <_Allowed>[
    _Allowed('0x99000000', 'lightbox barrier fallback over image content.'),
  ],
  // Media chrome over video/audio content (not theme surfaces).
  'components/video_player/video_player.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'overlay foreground over video content.'),
    _Allowed('0xFF27272A', 'video frame hairline.'),
    _Allowed('0x99000000', 'video scrim over content.'),
  ],
  'components/video_player/video_player_controls.dart': <_Allowed>[
    _Allowed('0x99000000', 'controls scrim over video content.'),
  ],
  'components/video_player/video_player_stage.dart': <_Allowed>[
    _Allowed('0x33FFFFFF', 'buffering veil over video content.'),
    _Allowed('0xFF000000', 'video stage base over content.'),
    _Allowed('0xCC000000', 'error veil over video content.'),
  ],
  'components/video_player/video_player_menu.dart': <_Allowed>[
    _Allowed('0x33FFFFFF', 'speed-menu fill over video content.'),
  ],
  'components/video_player/video_player_header.dart': <_Allowed>[
    _Allowed('0xFFDC2626', 'LIVE broadcast badge.'),
    _Allowed('0xFFFFFFFF', 'badge label over the red badge.'),
  ],
  'components/video_player/video_player_style.dart': <_Allowed>[
    _Allowed('0xFF000000', 'media-stage default over video content.'),
    _Allowed('0x99000000', 'media scrim default.'),
    _Allowed('0xFFFFFFFF', 'media overlay-tone defaults.'),
  ],
  'components/video_player/video_player_scrub.dart': <_Allowed>[
    _Allowed('0x59FFFFFF', 'media scrub chrome over video.'),
    _Allowed('0x99FFFFFF', 'media scrub chrome over video.'),
    _Allowed('0xFFFFFFFF', 'media scrub chrome over video.'),
  ],
  'components/video_player/video_player_buttons.dart': <_Allowed>[
    _Allowed('0x66FFFFFF', 'media button chrome over video.'),
    _Allowed('0x33FFFFFF', 'media button chrome over video.'),
    _Allowed('0x80FFFFFF', 'media button chrome over video.'),
    _Allowed('0xFF18181B', 'media disc base (inverted on dark).'),
  ],
  'components/audio_player/audio_player_transport.dart': <_Allowed>[
    _Allowed('0xEE18181B', 'speed-popup media chrome.'),
    _Allowed('0x33FFFFFF', 'speed-popup border over chrome.'),
  ],
  'components/audio_player/audio_player_expanded_transport.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'expanded disc artwork (inverted on dark).'),
    _Allowed('0xFF18181B', 'expanded disc artwork base.'),
  ],
  'components/audio_player/audio_player_expanded.dart': <_Allowed>[
    _Allowed('0xFF7C3AED', 'placeholder cover-art gradient.'),
    _Allowed('0xEC4899', 'placeholder cover-art gradient.'),
    _Allowed('0xFFFFFFFF', 'artwork veil white.'),
  ],
  // Widget API defaults mirroring theme tokens; every internal call site
  // already passes theme-resolved colors through the style legs.
  'components/audio_player/audio_player_progress.dart': <_Allowed>[
    _Allowed('0xFFE5E5E5', 'default track mirrors colors.border.'),
    _Allowed('0xFFD4D4D4', 'default buffered mid-tone has no token.'),
    _Allowed('0xFF18181B', 'default fill/thumb mirror colors.primary.'),
  ],
  // Status tones stay fixed across presets/modes by design (see code doc).
  'components/gooey_toast/gooey_toast_style.dart': <_Allowed>[
    _Allowed('0xFF16A34A', 'fixed success tone (preset-independent).'),
    _Allowed('0xFFB45309', 'fixed warning tone (preset-independent).'),
    _Allowed('0xFF3B82F6', 'fixed info tone (preset-independent).'),
    _Allowed('0xFF6366F1', 'fixed action tone (preset-independent).'),
    _Allowed('0xFF6B7280', 'fixed loading tone (preset-independent).'),
    _Allowed('0xFFDC2626', 'fixed error tone (preset-independent).'),
    _Allowed('0xFFF7F8FA', 'fixed light toast surface fill.'),
  ],
  // Data-viz canvas/contrast colors, not theme surfaces.
  'components/chart/chart_cartesian_painter.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'data-viz canvas/contrast color.'),
    _Allowed('0xFF000000', 'data-viz canvas/contrast color.'),
  ],
  'components/chart/chart_pie_painter.dart': <_Allowed>[
    _Allowed('0xFF000000', 'data-viz contrast color.'),
    _Allowed('0xFFFFFFFF', 'data-viz contrast color.'),
  ],
  'components/chart/chart_radar_painter.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'data-viz canvas color.'),
  ],
  'components/chart/chart_radial_painter.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'data-viz canvas color.'),
  ],
  // Color-science constants (pickers, gradients, math), not theme colors.
  'components/alpha/alpha.dart': <_Allowed>[
    _Allowed('0xFFE0E0E0', 'transparency checkerboard pair.'),
    _Allowed('0xFFB0B0B0', 'transparency checkerboard pair.'),
  ],
  'components/hsv/hsv.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'picker cursor ring over saturated gradient.'),
  ],
  'components/hsv/hsv_style.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'picker cursor ring default.'),
  ],
  'components/hsl/hsl.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'picker cursor ring over saturated gradient.'),
  ],
  'components/hsl/hsl_style.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'picker cursor ring default.'),
  ],
  'primitives/color_field_paint.dart': <_Allowed>[
    _Allowed('0xFFFF0000', 'hue-gradient color-science stop.'),
    _Allowed('0xFFFFFF00', 'hue-gradient color-science stop.'),
    _Allowed('0xFF00FF00', 'hue-gradient color-science stop.'),
    _Allowed('0xFF00FFFF', 'hue-gradient color-science stop.'),
    _Allowed('0xFF0000FF', 'hue-gradient color-science stop.'),
    _Allowed('0xFFFF00FF', 'hue-gradient color-science stop.'),
    _Allowed('0x00FFFFFF', 'alpha-gradient endpoint.'),
    _Allowed('0xFFFFFFFF', 'alpha-gradient endpoint (opaque white).'),
    _Allowed('0xFF000000', 'alpha-gradient endpoint.'),
  ],
  'primitives/color_math.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'color-math light endpoint.'),
    _Allowed('0xFF000000', 'color-math dark endpoint.'),
  ],
  // Alpha-only shader-mask whites, not surface paint.
  'primitives/fade_scroll.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'fade shader-mask white (alpha-only use).'),
    _Allowed('0x00FFFFFF', 'fade shader-mask white (alpha-only use).'),
  ],
  'components/overflow_marquee/overflow_marquee.dart': <_Allowed>[
    _Allowed('0x00FFFFFF', 'dstIn fade-mask white (alpha-only use).'),
    _Allowed('0xFFFFFFFF', 'dstIn fade-mask white (alpha-only use).'),
  ],
  'components/star_rating/star_rating.dart': <_Allowed>[
    _Allowed('0xFFFFFFFF', 'ShaderMask coverage base, recolored by mask.'),
  ],
};

/// True when [line] is covered by an allow-list entry for [relativePath].
bool _allowed(String relativePath, String line) {
  final List<_Allowed>? entries = _allowList[relativePath];
  if (entries == null) return false;
  return entries.any((e) => e.pattern.allMatches(line).isNotEmpty);
}

void main() {
  test('theme tokens drive every component (no literal radius/color)', () {
    final List<String> violations = <String>[];
    for (final String root in _scanRoots) {
      final Directory dir = Directory(root);
      if (!dir.existsSync()) continue;
      final List<File> files =
          dir
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.dart'))
              .where(
                (f) =>
                    !f.path.endsWith('preview.dart') &&
                    !f.path.contains('preview_'),
              )
              .toList()
            ..sort((a, b) => a.path.compareTo(b.path));
      for (final File file in files) {
        final String relativePath = file.path.startsWith('lib/src/')
            ? file.path.substring('lib/src/'.length)
            : file.path;
        final List<String> lines = file.readAsLinesSync();
        for (int i = 0; i < lines.length; i++) {
          final String line = lines[i];
          final String stripped = line.trimLeft();
          if (stripped.startsWith('//')) continue;
          final bool hasRadius = _literalRadius.hasMatch(line);
          final bool hasColor = _literalColor.hasMatch(line);
          if (!hasRadius && !hasColor) continue;
          if (_allowed(relativePath, line)) continue;
          final String kind = <String>[
            if (hasRadius) 'literal radius',
            if (hasColor) 'literal color',
          ].join(' + ');
          violations.add('${file.path}:${i + 1}: $kind: ${line.trim()}');
        }
      }
    }
    expect(
      violations,
      isEmpty,
      reason:
          'Hard-coded theme values found '
          '(see rearch/reports/theme_tokens_audit.md). Either derive them '
          'from the theme tokens or add a documented entry to _allowList:\n'
          '${violations.join('\n')}',
    );
  });
}
