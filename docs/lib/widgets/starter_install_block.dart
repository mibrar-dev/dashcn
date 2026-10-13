// The install block for starter pages (P9-Z2): Package | Own the code tabs
// sharing one command source (`install_commands.dart`), the package vs copy
// theme-file split and the rendered-template file list (targets only — never
// raw `.tmpl` text). Mirrors `FlowInstallBlock`.

import 'package:flutter/widgets.dart';

import '../generated/docs_starters.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/primitives/syntax_highlight/syntax_highlight.dart';
import '../ui/dashcn/theme/theme.dart';
import '../web_bridge.dart';
import 'copy_button.dart';
import 'docs_footer.dart' show kDocsRepoUrl;
import 'docs_tokens.dart';
import 'heading_anchor.dart';
import 'install_commands.dart';
import 'selectable_code.dart';
import 'typeset.dart';

/// The install block: Package | Own the code tabs for one starter.
class StarterInstallBlock extends StatefulWidget {
  /// Creates the install block for [starter].
  const StarterInstallBlock({super.key, required this.starter});

  /// The registry starter.
  final DocsStarter starter;

  @override
  State<StarterInstallBlock> createState() => _StarterInstallBlockState();
}

class _StarterInstallBlockState extends State<StarterInstallBlock> {
  // 0 = Package, 1 = Own the code.
  int _tab = 0;

  String get _command => _tab == 0
      ? starterPackageSnippet(widget.starter.id)
      : starterCopySnippet(widget.starter.id);

  String get _themeFile =>
      _tab == 0 ? kStarterPackageThemeFile : kStarterCopyThemeFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const HeadingAnchor(id: 'installation', title: 'Installation'),
        const Gap(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _LineTab(
                label: 'Package',
                selected: _tab == 0,
                onTap: () => setState(() => _tab = 0),
              ),
              _LineTab(
                label: 'Own the code',
                selected: _tab == 1,
                onTap: () => setState(() => _tab = 1),
              ),
            ],
          ),
        ),
        const Gap(12),
        _InstallFigure(
          command: _command,
          themeFile: _themeFile,
          files: widget.starter.files.map((DocsStarterFile f) => f.target),
        ),
        const Gap(12),
        TypesetParagraph.rich(<InlineSpan>[
          const TextSpan(text: 'Theme lands in '),
          WidgetSpan(child: TypesetInlineCode(_themeFile)),
          TextSpan(
            text: _tab == 0 ? ' (single package import).' : ' (owned sources).',
          ),
        ]),
        const Gap(8),
        const TypesetParagraph(
          'Options: --theme <preset|file.css> picks the theme (a file.css '
          'goes through the web-theme import), --platforms limits the '
          'flutter create platforms, --org sets the org, --dry-run prints '
          'the plan and --force overwrites a non-empty directory.',
        ),
      ],
    );
  }
}

/// The code figure: terminal header + copy, the snippet, the theme file and
/// the rendered-template file list (targets) with a GitHub source link.
class _InstallFigure extends StatelessWidget {
  const _InstallFigure({
    required this.command,
    required this.themeFile,
    required this.files,
  });

  final String command;
  final String themeFile;
  final Iterable<String> files;

  @override
  Widget build(BuildContext context) {
    final DocsSiteColors site = DocsSiteColors.of(context);
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: site.codeSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.border.withValues(alpha: 0.3),
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  LucideIcons.terminal,
                  size: 16,
                  color: theme.colors.foreground.withValues(alpha: 0.7),
                ),
                const Spacer(),
                CopyButton(
                  text: command,
                  variant: ButtonVariant.ghost,
                  size: ButtonSize.sm,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableCode(
                child: Text.rich(
                  syntaxTextSpan(
                    code: command,
                    language: SyntaxLanguage.bash,
                    base: theme.typography.mono.copyWith(
                      fontSize: 14,
                      height: 24.5 / 14,
                    ),
                    colors: theme.syntaxColors,
                  ),
                ),
              ),
            ),
          ),
          _FileList(themeFile: themeFile, files: files),
        ],
      ),
    );
  }
}

/// The theme file plus the rendered-template file list.
class _FileList extends StatelessWidget {
  const _FileList({required this.themeFile, required this.files});

  final String themeFile;
  final Iterable<String> files;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SelectableCode(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                themeFile,
                style: theme.typography.mono.copyWith(fontSize: 13),
              ),
            ),
            for (final String file in files)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  file,
                  style: theme.typography.mono.copyWith(fontSize: 13),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Opens the starter's template directory on GitHub.
void openStarterSource(String starterId) {
  webOpenUrl(
    '$kDocsRepoUrl/blob/main/dashcn/lib/src/starters/$starterId/templates',
  );
}

class _LineTab extends StatelessWidget {
  const _LineTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Clickable(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? theme.colors.primary : const Color(0x00000000),
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: docsText(
            context,
            size: 14,
            weight: FontWeight.w500,
            color: selected
                ? theme.colors.foreground
                : theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
