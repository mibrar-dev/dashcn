// W3C Design Tokens writer (pure Dart): a [WebTheme] as a `.tokens.json`
// document. Colours carry both modes in `$extensions.mode` (`$value` is the
// light value), so Figma Variables / Tokens Studio can split them into mode
// sets; scalars use `dimension`/`fontFamily`/`number` types.

import 'dart:convert';

import '../color_space.dart';
import '../theme_model.dart';

/// Writes [theme] as a W3C DTCG `.tokens.json` document.
String writeDtcgTokens(WebTheme theme, {String id = 'theme'}) {
  final WebTheme complete = theme.completed();
  final Map<String, Object?> colors = <String, Object?>{};
  for (final String token in kKitColorTokens) {
    final int light = complete.light[token]!;
    final int dark = complete.dark[token]!;
    colors[token] = <String, Object?>{
      r'$value': webHexOf(light),
      r'$type': 'color',
      r'$extensions': <String, Object?>{
        'mode': <String, Object?>{
          'light': webHexOf(light),
          'dark': webHexOf(dark),
        },
      },
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
  Map<String, Object?> shadowAtoms(WebShadowAtoms atoms) => <String, Object?>{
    'color': <String, Object?>{
      r'$value': webHexOf(atoms.color),
      r'$type': 'color',
    },
    'opacity': <String, Object?>{r'$value': atoms.opacity, r'$type': 'number'},
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
  };
  final Map<String, Object?> document = <String, Object?>{
    id: <String, Object?>{
      'color': colors,
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
        'light': shadowAtoms(complete.lightShadow!),
        'dark': shadowAtoms(complete.darkShadow!),
      },
    },
  };
  return const JsonEncoder.withIndent('  ').convert(document);
}
