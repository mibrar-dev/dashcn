// Home showcase: overlay cards, part 1 — dialog, alert, drawer (P6-H1).
//
// Every card opens its real registry overlay (`showDialog`,
// `showAlertDialog`, `openDrawer` / `openSheet`), the way the reference
// home's `Alert Dialog` trigger does: the collage shows the composed scene,
// the overlay opens on demand.

import 'package:flutter/widgets.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';

import '../ui/dashcn/components/alert_dialog/alert_dialog.dart';
import '../ui/dashcn/components/avatar/avatar.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/dialog/dialog.dart';
import '../ui/dashcn/components/drawer/drawer.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Share document`: an avatar row whose action opens a real dialog.
class HomeDialogCard extends StatelessWidget {
  /// Creates the card.
  const HomeDialogCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsHome(locale, 'homeShareDocTitle'),
      subtitle: docsHome(locale, 'homeShareDocSub'),
      children: <Widget>[
        Row(
          children: <Widget>[
            const Avatar(initials: 'MO', size: 34),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Q2 royalty report.pdf',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.small.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    docsSample(context, 'Only you have access'),
                    style: theme.typography.small.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(12),
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          leading: const Icon(LucideIcons.share2, size: 14),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) => AlertDialog(
              title: Text(docsSample(context, 'Share this document')),
              description: const Text(
                'Anyone with the link can view the Q2 royalty report. '
                'Access expires in 7 days.',
              ),
              actions: <Widget>[
                Button(
                  variant: ButtonVariant.outline,
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(docsSample(context, 'Cancel')),
                ),
                Button(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(docsSample(context, 'Copy link')),
                ),
              ],
            ),
          ),
          child: Text(docsSample(context, 'Open dialog')),
        ),
      ],
    );
  }
}

/// `Danger zone`: a destructive action confirmed through a real alert.
class HomeAlertConfirmCard extends StatelessWidget {
  /// Creates the card.
  const HomeAlertConfirmCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsHome(locale, 'homeDangerTitle'),
      subtitle: docsHome(locale, 'homeDangerSub'),
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              LucideIcons.shieldAlert,
              size: 16,
              color: theme.colors.destructive,
            ),
            const Gap(12),
            Expanded(
              child: StudioHelper(docsSample(context, 'Midnight Drive — 2026')),
            ),
          ],
        ),
        const Gap(12),
        Button(
          variant: ButtonVariant.destructive,
          size: ButtonSize.sm,
          leading: const Icon(LucideIcons.trash2, size: 14),
          onPressed: () => showAlertDialog<bool>(
            context: context,
            icon: const Icon(LucideIcons.trash2, size: 20),
            title: Text(docsSample(context, 'Delete this project?')),
            description: const Text(
              'The release, its royalties and every report will be removed '
              'permanently.',
            ),
            actionsBuilder: (BuildContext dialogContext) => <Widget>[
              Button(
                variant: ButtonVariant.outline,
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(docsSample(context, 'Cancel')),
              ),
              Button(
                variant: ButtonVariant.destructive,
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(docsSample(context, 'Delete')),
              ),
            ],
          ),
          child: Text(docsSample(context, 'Delete project')),
        ),
      ],
    );
  }
}

/// `Account panel`: buttons opening the registry drawer and sheet.
class HomeDrawerCard extends StatelessWidget {
  /// Creates the card.
  const HomeDrawerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeAccountPanel'),
      subtitle: docsSample(context, 'The same content as a drawer or a sheet.'),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: () => openDrawer<void>(
                  context: context,
                  builder: (BuildContext drawerContext) => _HomePanelSheet(
                    onClose: () => Navigator.pop(drawerContext),
                  ),
                ),
                child: Text(docsSample(context, 'Open drawer')),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: () => openSheet<void>(
                  context: context,
                  builder: (BuildContext sheetContext) => _HomePanelSheet(
                    onClose: () => Navigator.pop(sheetContext),
                  ),
                ),
                child: Text(docsSample(context, 'Open sheet')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The panel body shared by the drawer and the sheet demos.
class _HomePanelSheet extends StatelessWidget {
  /// Creates the panel.
  const _HomePanelSheet({required this.onClose});

  /// Closes the overlay.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            docsSample(context, 'Account'),
            style: theme.typography.h4.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap(4),
          StudioHelper(
            docsSample(context, 'Profile, billing and notifications.'),
          ),
          const Gap(16),
          StudioRow(label: docsSample(context, 'Plan'), value: r'Pro · $29/mo'),
          StudioRow(
            label: docsSample(context, 'Renewal'),
            value: docsSample(context, '1 Jun 2026'),
          ),
          const Gap(16),
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: onClose,
            child: Text(docsSample(context, 'Close panel')),
          ),
        ],
      ),
    );
  }
}
