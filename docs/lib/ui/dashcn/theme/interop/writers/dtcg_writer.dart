// W3C Design Tokens writer (pure Dart): a [WebTheme] as a `.tokens.json`
// document with one token set per mode (`light`, `dark`).
//
// Why sets and not per-token `$extensions.mode`: the W3C format reserves
// `$extensions` for vendor-namespaced tool data (which importers must
// preserve but may ignore), and neither Tokens Studio nor Figma Variables
// builds modes from it. Both import *token sets* — top-level groups whose
// names become the mode/sets (`light`, `dark`) — so each set below carries
// that mode's full token tree. Every token keeps `$value`/`$type`, so the
// document stays valid W3C DTCG. Mode-independent scalars (fonts) are
// duplicated into both sets, the standard practice for set-based imports.

import 'dart:convert';

import '../internal/color_format.dart';
import '../internal/token_inventory.dart';
import '../theme_model.dart';

/// Writes [theme] as a W3C DTCG `.tokens.json` document: top-level `light`
/// and `dark` token sets, each with `color/*`, `radius`, `font/*`,
/// `spacing`, `tracking/*` and the mode's `shadow/*` atoms.
String writeDtcgTokens(WebTheme theme) {
  final WebTheme complete = theme.completed();

  Map<String, Object?> modeSet(bool isDark) {
    final Map<String, int> colors = isDark ? complete.dark : complete.light;
    final Map<String, Object?> colorTokens = <String, Object?>{};
    for (final String token in kKitColorTokens) {
      colorTokens[token] = <String, Object?>{
        r'$value': webHexOf(colors[token]!),
        r'$type': 'color',
      };
    }
    final Map<String, Object?> fonts = <String, Object?>{};
    for (final MapEntry<String, String> font in complete.fonts.entries) {
      fonts[font.key] = <String, Object?>{
        r'$value': font.value,
        r'$type': 'fontFamily',
      };
    }
    final Map<String, Object?> tracking = <String, Object?>{};
    for (final MapEntry<String, double> step in complete.tracking.entries) {
      tracking[step.key] = <String, Object?>{
        r'$value': '${step.value}em',
        r'$type': 'dimension',
      };
    }
    final WebShadowAtoms atoms = (isDark
        ? complete.darkShadow
        : complete.lightShadow)!;
    return <String, Object?>{
      'color': colorTokens,
      'radius': <String, Object?>{
        r'$value': '${complete.radius! * 16}px',
        r'$type': 'dimension',
      },
      if (fonts.isNotEmpty) 'font': fonts,
      'spacing': <String, Object?>{
        r'$value': '${complete.spacing! * 16}px',
        r'$type': 'dimension',
      },
      'tracking': tracking,
      'shadow': <String, Object?>{
        'color': <String, Object?>{
          r'$value': webHexOf(atoms.color),
          r'$type': 'color',
        },
        'opacity': <String, Object?>{
          r'$value': atoms.opacity,
          r'$type': 'number',
        },
        for (final (String, double) atom in <(String, double)>[
          ('blur', atoms.blur),
          ('spread', atoms.spread),
          ('offsetX', atoms.offsetX),
          ('offsetY', atoms.offsetY),
        ])
          atom.$1: <String, Object?>{
            r'$value': '${atom.$2}px',
            r'$type': 'dimension',
          },
      },
      if (complete.surfaceOpacity != null)
        'surfaceOpacity': <String, Object?>{
          r'$value': complete.surfaceOpacity,
          r'$type': 'number',
        },
      if (complete.surfaceBlur != null)
        'surfaceBlur': <String, Object?>{
          r'$value': '${complete.surfaceBlur}px',
          r'$type': 'dimension',
        },
    };
  }

  final Map<String, Object?> document = <String, Object?>{
    'light': modeSet(false),
    'dark': modeSet(true),
  };
  return const JsonEncoder.withIndent('  ').convert(document);
}
