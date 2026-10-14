// The `Get Code` dialog (spec §2.7 requirement 3).
//
// Six tabs over the live document: `Dart` (the exact `app_theme.dart`
// `dashcn theme apply` writes), `JSON` (the canonical schema-v2 preset
// document), `CLI` (how to apply it), plus the three web exports — `Web CSS
// (v4)`, `Tailwind v4` and `Tokens (DTCG)` — rendered by the kit's interop
// writers from the same document. Each tab copies its own payload with
// the site's 2 s copied state (file tabs also download it), and the whole
// pane is syntax-highlighted from the language of the active tab (registry
// `syntax_highlight`).

import 'package:flutter/widgets.dart';

import '../state/site_theme_model.dart';
import '../theme/theme_export.dart';
import '../theme/theme_interop_bridge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/dialog/dialog.dart';
import '../ui/dashcn/components/tabs/tabs.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/primitives/fade_scroll.dart';
import '../ui/dashcn/primitives/syntax_highlight/syntax_highlight.dart';
import '../ui/dashcn/theme/theme.dart';
import '../web_bridge.dart';
import 'copy_button.dart';
import 'docs_tokens.dart';
import 'selectable_code.dart';

/// The payloads of the dialog.
enum GetCodeTab {
  /// The generated `app_theme.dart`.
  dart('Dart', 'dart'),

  /// The canonical preset document.
  json('JSON', 'json'),

  /// How to apply it in a project.
  cli('CLI', 'bash'),

  /// `:root` + `.dark` CSS.
  webCss('Web CSS (v4)', 'css', WebExportFormat.webCss),

  /// Tailwind v4 CSS with an `@theme inline` alias block.
  tailwind('Tailwind v4', 'css', WebExportFormat.tailwind),

  /// W3C DTCG tokens (one set per mode).
  dtcg('Tokens (DTCG)', 'json', WebExportFormat.dtcg);

  const GetCodeTab(this.label, this.language, [this.format]);

  /// The tab label.
  final String label;

  /// The `SyntaxLanguage` id of the payload.
  final String language;

  /// The web export format, or null for the document tabs.
  final WebExportFormat? format;

  /// Whether the payload downloads as a file (the CLI tab is a guide).
  bool get hasFile => this != cli;

  /// The download file name for [documentId].
  String filename(String documentId) => switch (this) {
    GetCodeTab.dart => 'app_theme.dart',
    GetCodeTab.json => '$documentId.json',
    GetCodeTab.cli => 'theme-apply.txt',
    GetCodeTab.webCss => WebExportFormat.webCss.filename,
    GetCodeTab.tailwind => WebExportFormat.tailwind.filename,
    GetCodeTab.dtcg => WebExportFormat.dtcg.filename,
  };
}

/// Shows the `Get Code` dialog for [model] and returns when it closes.
Future<void> showGetCodeDialog(BuildContext context, SiteThemeModel model) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => _GetCodeDialog(model: model),
  );
}

class _GetCodeDialog extends StatefulWidget {
  const _GetCodeDialog({required this.model});

  final SiteThemeModel model;

  @override
  State<_GetCodeDialog> createState() => _GetCodeDialogState();
}

class _GetCodeDialogState extends State<_GetCodeDialog> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SiteThemeModel model = widget.model;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: DocsMetrics.paletteWidth + 160,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('Get Code', style: theme.typography.h4)),
                if (GetCodeTab.values[_index].hasFile)
                  Button(
                    key: const ValueKey<String>('get-code-download'),
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => webDownloadText(
                      GetCodeTab.values[_index].filename(model.document.id),
                      getCodePayload(model, GetCodeTab.values[_index]),
                    ),
                    child: const Text('Download'),
                  ),
                CopyButton(
                  text: getCodePayload(model, GetCodeTab.values[_index]),
                  variant: ButtonVariant.outline,
                  size: ButtonSize.sm,
                  showLabel: true,
                  label: 'Copy',
                ),
              ],
            ),
            const Gap(12),
            SizedBox(
              width: 640,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Tabs(
                  index: _index,
                  onChanged: (int index) => setState(() => _index = index),
                  children: <TabItem>[
                    for (final GetCodeTab tab in GetCodeTab.values)
                      TabItem(child: Text(tab.label)),
                  ],
                ),
              ),
            ),
            const Gap(12),
            SizedBox(
              width: 640,
              height: 288,
              child: _CodePane(
                code: getCodePayload(model, GetCodeTab.values[_index]),
                language: GetCodeTab.values[_index].language,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The code pane of the dialog: highlighted, horizontally scrollable, with a
/// registry `FadeScroll` fade on both edges (spec scroll-fade).
class _CodePane extends StatefulWidget {
  const _CodePane({required this.code, required this.language});

  final String code;
  final String language;

  @override
  State<_CodePane> createState() => _CodePaneState();
}

class _CodePaneState extends State<_CodePane> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DocsSiteColors site = DocsSiteColors.of(context);
    final SyntaxLanguage? language = syntaxLanguageFromId(widget.language);
    final TextStyle base = theme.typography.mono.copyWith(
      fontSize: 13,
      height: 20 / 13,
      color: site.codeSurface == const Color(0xFF161616)
          ? const Color(0xFFE5E5E5)
          : const Color(0xFF262626),
    );
    return ClipRRect(
      // P7-TH1: dialog content follows the card radius token.
      borderRadius: theme.borderRadiusLg,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: site.codeSurface,
          border: Border.all(color: theme.colors.border.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FadeScroll(
            controller: _scroll,
            endOffset: 8,
            startOffset: 8,
            child: SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SelectableCode(
                  child: language == null
                      ? Text(widget.code, style: base)
                      : Text.rich(
                          syntaxTextSpan(
                            code: widget.code,
                            language: language,
                            base: base,
                            colors: theme.syntaxColors,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The text [tab] shows for the document [model] currently holds.
///
/// The document is the single source: the Dart tab is rendered from the same
/// values the site renders, the JSON tab is what `Open Preset` accepts
/// back (so a copy/paste round-trip is lossless), and the three web tabs are
/// the kit interop writers' output for that document.
String getCodePayload(SiteThemeModel model, GetCodeTab tab) {
  final WebExportFormat? format = tab.format;
  if (format != null) {
    return exportWebTheme(model.document, format);
  }
  return switch (tab) {
    GetCodeTab.dart => model.dartSource,
    GetCodeTab.json => model.json,
    GetCodeTab.cli => themeCliGuide(model.document),
    GetCodeTab.webCss ||
    GetCodeTab.tailwind ||
    GetCodeTab.dtcg => throw StateError('unreachable'),
  };
}
