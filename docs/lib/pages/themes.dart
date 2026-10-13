// `/themes` — the Theme Studio (spec §2.7).
//
// Two panes like the reference's `/create`: a 192 px rail on the left (24 px
// from the edge) and a large rounded block canvas on the right. Below `sm` the
// rail cannot fit next to the cards, so it collapses into an anchored sheet
// opened from a `Customize` chip, and the canvas takes the full width.

import 'package:flutter/widgets.dart';

import '../routing/docs_router.dart';
import '../state/docs_state.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/popup/popup.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/overlay.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/get_code_dialog.dart';
import '../widgets/studio_canvas.dart';
import '../widgets/theme_import_dialog.dart';
import '../widgets/theme_rail.dart';

/// `/themes` — the customizer.
class ThemesPage extends StatefulWidget {
  /// Creates the themes page.
  const ThemesPage({super.key, this.openPanel});

  /// Opens a studio panel on entry (`import`/`export`, P9-Z nav links).
  ///
  /// `/themes?panel=import` (the sidebar's "Import a web theme" item) opens
  /// the import dialog; `export` opens Get Code. Null opens nothing.
  final String? openPanel;

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  bool _opened = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeOpen());
  }

  void _maybeOpen() {
    if (_opened || !mounted) {
      return;
    }
    final String? panel = widget.openPanel;
    if (panel != 'import' && panel != 'export') {
      return;
    }
    _opened = true;
    final DocsState state = DocsRouterScope.of(context).state;
    if (panel == 'import') {
      showThemeImportDialog(context, state.themeModel);
    } else {
      showGetCodeDialog(context, state.themeModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DocsState state = DocsRouterScope.of(context).state;
    if (MediaQuery.sizeOf(context).width < 640) {
      return ColoredBox(
        color: theme.colors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Button(
                key: const ValueKey<String>('themes-open-rail'),
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                leading: const Icon(LucideIcons.slidersHorizontal, size: 14),
                onPressed: () => _openRail(context, state),
                child: const Text('Customize'),
              ),
            ),
            const Gap(12),
            Expanded(child: ThemeCanvas(state: state)),
          ],
        ),
      );
    }
    return ColoredBox(
      color: theme.colors.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Spec §2.7: the rail is a floating 192 px card, 24 px from the left
          // edge, 12 px below the header, 24 px above the bottom.
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 12, bottom: 24),
            child: ThemeRail(state: state),
          ),
          Expanded(child: ThemeCanvas(state: state)),
        ],
      ),
    );
  }

  /// Opens the rail in an anchored sheet (`<640`).
  Future<void> _openRail(BuildContext context, DocsState state) {
    return showPopup<void>(
      context: context,
      alignment: Alignment.topRight,
      anchorAlignment: Alignment.bottomRight,
      widthConstraint: PopoverConstraint.intrinsic,
      heightConstraint: PopoverConstraint.intrinsic,
      builder: (BuildContext context) => SizedBox(
        width: kThemeRailWidth,
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: ThemeRail(state: state),
      ),
    );
  }
}
