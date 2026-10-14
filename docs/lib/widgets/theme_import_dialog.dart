// The `Import Web Theme` dialog: paste (or pick) a web theme — CSS,
// a Tailwind v3 config, or a preset JSON — preview it live in both modes
// next to its import report, and apply it as the current theme document.
//
// Parsing never throws into the dialog: CSS-shaped sources degrade into
// report entries, while preset-shaped but invalid documents surface the
// validator's message and leave the live theme untouched until Apply.

import 'package:flutter/widgets.dart';

import '../state/site_theme_model.dart';
import '../theme/theme_document.dart';
import '../theme/theme_interop_bridge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/dialog/dialog.dart';
import '../ui/dashcn/components/text_area/text_area.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/interop/interop.dart';
import '../ui/dashcn/theme/theme.dart';
import '../web_bridge.dart';

/// Shows the import dialog for [model]; resolves true when applied.
Future<bool> showThemeImportDialog(
  BuildContext context,
  SiteThemeModel model,
) async {
  final bool? applied = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => _ThemeImportDialog(model: model),
  );
  return applied ?? false;
}

class _ThemeImportDialog extends StatefulWidget {
  const _ThemeImportDialog({required this.model});

  final SiteThemeModel model;

  @override
  State<_ThemeImportDialog> createState() => _ThemeImportDialogState();
}

class _ThemeImportDialogState extends State<_ThemeImportDialog> {
  late final TextEditingController _controller = TextEditingController();
  String? _fileName;
  String? _error;
  WebImportResult? _result;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_reparse);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_reparse)
      ..dispose();
    super.dispose();
  }

  void _reparse() {
    final String source = _controller.text;
    if (source.trim().isEmpty) {
      setState(() {
        _error = null;
        _result = null;
      });
      return;
    }
    try {
      final WebImportResult result = parseWebThemeSource(source);
      if (mounted) {
        setState(() {
          _error = null;
          _result = result;
        });
      }
    } on FormatException catch (error) {
      if (mounted) {
        setState(() {
          _error = error.message;
          _result = null;
        });
      }
    } on ThemeDocumentException catch (error) {
      if (mounted) {
        setState(() {
          _error = error.message;
          _result = null;
        });
      }
    }
  }

  Future<void> _pickFile() async {
    final String? text = await webPickTextFile(const <String>[
      'css',
      'js',
      'json',
    ]);
    if (text == null || !mounted) {
      return;
    }
    _controller.text = text;
    setState(() => _fileName = 'pasted file');
  }

  void _apply() {
    final WebImportResult? result = _result;
    if (result == null) {
      return;
    }
    widget.model.applyDocument(result.document);
    Navigator.of(context, rootNavigator: true).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final WebImportResult? result = _result;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Import Web Theme', style: theme.typography.h4),
          const Gap(8),
          Text(
            'Paste CSS, a Tailwind v3 config, or a preset JSON — or choose a '
            '.css, .js or .json file. The preview and report update live.',
            style: theme.typography.small.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
          const Gap(12),
          Row(
            children: <Widget>[
              Button(
                key: const ValueKey<String>('theme-import-file'),
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: _pickFile,
                child: const Text('Choose file'),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  _fileName ?? result?.format.label ?? 'No file chosen',
                  style: theme.typography.small.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(8),
          SizedBox(
            width: 640,
            child: TextArea(
              key: const ValueKey<String>('theme-import-input'),
              controller: _controller,
              minLines: 6,
              maxLines: 8,
              hintText: ':root {\n  --background: oklch(1 0 0);\n  …\n}',
            ),
          ),
          const Gap(8),
          if (_error != null)
            Text(
              _error!,
              style: theme.typography.small.copyWith(
                color: theme.colors.destructive,
              ),
            ),
          if (result != null) ...<Widget>[
            _ReportSummary(result: result),
            const Gap(8),
            _ReportDetails(result: result),
            const Gap(8),
            _ImportPreview(
              key: const ValueKey<String>('theme-import-preview'),
              document: result.document,
            ),
          ],
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Button(
                variant: ButtonVariant.ghost,
                size: ButtonSize.sm,
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(false),
                child: const Text('Cancel'),
              ),
              const Gap(8),
              Button(
                key: const ValueKey<String>('theme-import-apply'),
                variant: ButtonVariant.primary,
                size: ButtonSize.sm,
                onPressed: result == null ? null : _apply,
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// One-line report counts plus the detected format.
class _ReportSummary extends StatelessWidget {
  const _ReportSummary({required this.result});

  final WebImportResult result;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ImportReport report = result.report;
    return Text(
      '${result.format.label}: mapped ${report.mapped.length} · '
      'defaulted ${report.defaulted.length} · ignored ${report.ignored.length}',
      style: theme.typography.small.copyWith(
        color: theme.colors.mutedForeground,
      ),
    );
  }
}

/// The defaulted/ignored entries with reasons (the mapped list is 64+ rows,
// so only its count shows above).
class _ReportDetails extends StatelessWidget {
  const _ReportDetails({required this.result});

  final WebImportResult result;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ImportReport report = result.report;
    final List<Widget> rows = <Widget>[
      for (final DefaultedEntry entry in report.defaulted.take(8))
        _ReportRow(text: '${entry.token} — ${entry.reason}', theme: theme),
      for (final IgnoredEntry entry in report.ignored.take(8))
        _ReportRow(text: '${entry.variable} — ${entry.reason}', theme: theme),
    ];
    if (rows.isEmpty) {
      return Text(
        'Every token came from the source; no fallbacks used.',
        style: theme.typography.small.copyWith(
          color: theme.colors.mutedForeground,
        ),
      );
    }
    final int hidden =
        report.defaulted.length + report.ignored.length - rows.length;
    return SizedBox(
      width: 640,
      height: 96,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...rows,
              if (hidden > 0)
                _ReportRow(text: '…and $hidden more', theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.text, required this.theme});

  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: theme.typography.mono.copyWith(
          fontSize: 12,
          color: theme.colors.mutedForeground,
        ),
      ),
    );
  }
}

/// Side-by-side light/dark preview of the parsed document.
class _ImportPreview extends StatelessWidget {
  const _ImportPreview({super.key, required this.document});

  final ThemeDocument document;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _ModePreview(
              document: document,
              brightness: Brightness.light,
            ),
          ),
          const Gap(8),
          Expanded(
            child: _ModePreview(
              document: document,
              brightness: Brightness.dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModePreview extends StatelessWidget {
  const _ModePreview({required this.document, required this.brightness});

  final ThemeDocument document;
  final Brightness brightness;

  static const List<String> _swatches = <String>[
    'background',
    'foreground',
    'primary',
    'secondary',
    'muted',
    'accent',
    'destructive',
    'border',
    'ring',
    'chart1',
    'chart2',
    'chart3',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Map<String, String> map = brightness == Brightness.dark
        ? document.dark
        : document.light;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: docsColorOf(map['background']!),
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              brightness == Brightness.dark ? 'Dark' : 'Light',
              style: theme.typography.small.copyWith(
                color: docsColorOf(map['mutedForeground']!),
              ),
            ),
            const Gap(6),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: <Widget>[
                for (final String token in _swatches)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: docsColorOf(map[token]!),
                      border: Border.all(color: theme.colors.border),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
              ],
            ),
            const Gap(6),
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: docsColorOf(map['primary']!),
                borderRadius: BorderRadius.circular(document.radiusPx),
              ),
              child: Center(
                child: Text(
                  'Aa ${document.fontOf('sans') ?? 'system'}',
                  style: theme.typography.small.copyWith(
                    color: docsColorOf(map['primaryForeground']!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
