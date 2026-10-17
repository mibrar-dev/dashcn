// The scale pickers of the Theme Studio rail: fonts, radius and
// spacing/density, plus the read-only syntax palette preview (spec §2.7
// requirement 5). The shadow picker lives in `rail_picker_shadow.dart`.
//
// Split out of `rail_pickers.dart` for the ~400-line rule; the popup chrome
// (`showPicker`), the rows (`RailPickerPanel`, `RailPickerRow`) and the
// scroll reveal (`revealSelectedOnMount`) are shared from their own files.

import 'package:flutter/widgets.dart';

import '../../theme/docs_fonts.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/tooltip/tooltip.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/syntax_colors.dart';
import '../../ui/dashcn/primitives/overlay.dart';
import '../../ui/dashcn/theme/theme.dart';
import 'docs_tokens.dart';
import 'rail_picker_rows.dart';
import 'rail_picker_scroll.dart';
import 'rail_picker_slider.dart';
import 'rail_pickers.dart';

/// The catalogue a [slot] offers, so each font row shows the families that
/// actually fit its role (headings get the display faces, the body gets the
/// text faces, mono gets the code faces).
List<DocsFontFamily> docsFontCatalogueFor(String slot) => switch (slot) {
  'heading' => kDocsHeadingFonts,
  'body' => kDocsBodyFonts,
  'mono' => kDocsMonoFonts,
  _ => kDocsBodyFonts,
};

/// Shows the family list popup for [slot]; only a pick commits.
///
/// [current] is read on every rebuild (not captured at open), so the
/// highlight follows the live document while the popup is open;
/// [listenable] (the theme model) rebuilds the rows when the document
/// changes. [onChanged] runs exactly once per committed pick ('' clears the
/// slot) and the popup closes; hovering, scrolling and arrow-key focus
/// movement stay local. Closing without picking keeps the current value.
/// A pick loads the family through [FontLoader] first (lazy — the catalogue
/// is not downloaded at startup), so the committed value always renders in
/// the family the user chose.
Future<void> showFontPicker(
  BuildContext context,
  String slot,
  ValueGetter<String?> current, {
  required ValueChanged<String> onChanged,
  Listenable? listenable,
}) {
  final List<DocsFontFamily> catalogue = docsFontCatalogueFor(slot);
  Widget row(BuildContext context, DocsFontFamily option) {
    final bool selected = (current() ?? '') == option.family;
    final Widget line = RailPickerRow(
      label: option.label,
      detail: option.family.isEmpty ? 'bundled default' : option.family,
      selected: selected,
      onPick: () async {
        // Load before the model commits, so the first frame after the commit
        // already paints the picked family (no fallback flash).
        await loadDocsFonts(option.family);
        if (context.mounted) {
          onChanged(option.family);
          closeOverlay(context);
        }
      },
      trailing: Text(
        'Aa',
        style: docsText(
          context,
          size: 16,
          color: Theme.of(context).colors.mutedForeground,
        ).copyWith(fontFamily: option.family.isEmpty ? null : option.family),
      ),
    );
    return revealSelectedOnMount(selected: selected, child: line);
  }

  Widget buildPanel(BuildContext context) => RailPickerPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final DocsFontFamily option in catalogue) row(context, option),
      ],
    ),
  );
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) {
      if (listenable == null) {
        return buildPanel(context);
      }
      return ListenableBuilder(
        listenable: listenable,
        builder: (BuildContext context, Widget? _) => buildPanel(context),
      );
    },
    title: _fontPickerTitle(slot),
  );
}

/// The popup title for [slot], matching the rail row's label.
String _fontPickerTitle(String slot) => switch (slot) {
  'heading' => 'Heading font',
  'body' => 'Body font',
  'mono' => 'Mono font',
  _ => '$slot family',
};

/// Radius presets (px), after the upstream scale: 0, 0.25, 0.5, the 0.625 rem
/// neutral default, 0.75 and a full 1 rem.
const List<(String, double)> kRadiusPresets = <(String, double)>[
  ('None', 0),
  ('Small', 4),
  ('Default', 8),
  ('Medium', 10),
  ('Large', 12),
  ('Full', 16),
];

/// Spacing presets (rem): the 0.25 rem default with a step either side.
const List<(String, double)> kSpacingPresets = <(String, double)>[
  ('Compact', 0.2),
  ('Default', 0.25),
  ('Comfortable', 0.3),
];

/// Shows the radius popup: presets plus the fine slider (0–16 px).
///
/// A deliberate multi-step editor: preset taps commit immediately but the
/// popup stays open for fine-tuning. [current] is read on every rebuild
/// (not captured at open) and [listenable] (the theme model) rebuilds the
/// rows when the document changes, so the highlight and the slider follow
/// the live value while open. Slider drags show locally in the popup and
/// commit once on release ([DraftSlider]); `Done` flushes a keyboard-edited
/// draft, then closes. Escape closes without committing.
Future<void> showRadiusPicker(
  BuildContext context,
  ValueGetter<double> current, {
  required ValueChanged<double> onChanged,
  Listenable? listenable,
}) {
  final GlobalKey<DraftSliderState> sliderKey = GlobalKey<DraftSliderState>();
  double live() => current().clamp(0, 16);
  bool near(double preset) => (live() - preset).abs() < 0.25;
  void commit(double next) {
    if (next == live()) {
      return;
    }
    onChanged(next);
  }

  Widget buildPanel(BuildContext context) => RailPickerPanel(
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        // The slider owns the drag draft; the label reads it back so an
        // external change (which re-seeds the slider) never shows stale.
        final double shown = sliderKey.currentState?.draft ?? live();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final (String label, double px) in kRadiusPresets)
              RailPickerRow(
                label: label,
                detail: '${px.round()} px',
                selected: near(px),
                onPick: () => commit(px),
              ),
            const Gap(8),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    '${shown.round()} px',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: docsText(context, size: 14, weight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Text(
                    'radius ${(shown / 16).toStringAsFixed(3)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: docsText(
                      context,
                      size: 12,
                      color: Theme.of(context).colors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            SizedBox(
              width: kDocsPickerWidth - 24,
              child: DraftSlider(
                key: sliderKey,
                value: live(),
                min: 0,
                max: 16,
                onCommit: commit,
                onDraft: (double _) => setState(() {}),
              ),
            ),
            const Gap(4),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () {
                sliderKey.currentState?.flush();
                closeOverlay(context);
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    ),
  );
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) {
      if (listenable == null) {
        return buildPanel(context);
      }
      return ListenableBuilder(
        listenable: listenable,
        builder: (BuildContext context, Widget? _) => buildPanel(context),
      );
    },
  );
}

/// Shows the spacing popup: presets plus the fine slider.
///
/// Same commit contract as the radius popup: a deliberate multi-step
/// editor — preset taps commit but the popup stays open for fine-tuning,
/// with the highlight and slider following the live value ([current]
/// re-read on every rebuild, [listenable] rebuilding on document change).
/// Slider drags stay local until release, `Done` flushes then closes,
/// Escape closes without committing.
Future<void> showSpacingPicker(
  BuildContext context,
  ValueGetter<double> current, {
  required ValueChanged<double> onChanged,
  Listenable? listenable,
}) {
  final GlobalKey<DraftSliderState> sliderKey = GlobalKey<DraftSliderState>();
  double live() => current().clamp(0.15, 0.35);
  bool near(double preset) => (live() - preset).abs() < 0.005;
  void commit(double next) {
    if (next == live()) {
      return;
    }
    onChanged(next);
  }

  Widget buildPanel(BuildContext context) => RailPickerPanel(
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        final double shown = sliderKey.currentState?.draft ?? live();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final (String label, double preset) in kSpacingPresets)
              RailPickerRow(
                label: label,
                detail: '${(preset * 16).toStringAsFixed(1)} px base',
                selected: near(preset),
                onPick: () => commit(preset),
              ),
            const Gap(8),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    '${(shown * 16).toStringAsFixed(1)} px base',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: docsText(context, size: 14, weight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Text(
                    'spacing ${shown.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: docsText(
                      context,
                      size: 12,
                      color: Theme.of(context).colors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            SizedBox(
              width: kDocsPickerWidth - 24,
              child: DraftSlider(
                value: live(),
                key: sliderKey,
                min: 0.15,
                max: 0.35,
                onCommit: commit,
                onDraft: (double _) => setState(() {}),
              ),
            ),
            const Gap(4),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () {
                sliderKey.currentState?.flush();
                closeOverlay(context);
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    ),
  );
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) {
      if (listenable == null) {
        return buildPanel(context);
      }
      return ListenableBuilder(
        listenable: listenable,
        builder: (BuildContext context, Widget? _) => buildPanel(context),
      );
    },
  );
}

/// The read-only syntax palette preview (requirement 5).
///
/// `syntaxColors` is a docs-app override, not a preset token group, so the row
/// previews the palette the code blocks actually use instead of editing a
/// value the exported `app_theme.dart` could not carry.
class SyntaxPalettePreview extends StatelessWidget {
  /// Creates the preview.
  const SyntaxPalettePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SyntaxColors syntax = theme.syntaxColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'read-only · ${theme.brightness == Brightness.dark ? 'dark' : 'light'}'
          ' shiki palette',
          style: docsText(
            context,
            size: 11,
            color: theme.colors.mutedForeground,
          ),
        ),
        const Gap(8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: <Widget>[
            for (final SyntaxTokenKind kind in SyntaxTokenKind.values)
              Tooltip(
                tooltip: (BuildContext context) => Text(kind.name),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: syntax.colorFor(kind),
                    // P7-TH1: syntax swatches use the small radius token
                    // (colours stay the fixed syntax palette by exception).
                    borderRadius: theme.borderRadiusSm,
                    border: Border.all(color: theme.colors.border),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// The first family of a CSS family list (`"Lora", Georgia, serif`); this is
/// also the short label the font picker shows.
String railFirstFamily(String spec) => spec
    .split(',')
    .map((String part) => part.trim().replaceAll('"', ''))
    .firstWhere((String part) => part.isNotEmpty, orElse: () => spec);
