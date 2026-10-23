// The misc blocks of the Theme Studio canvas: FAQ accordion, pricing, a
// stepper, a breadcrumb + pagination row, a formatting toolbar, a data-table
// excerpt, badge statuses and the `Distribute Track` empty state.
//
// These cover the registry components that would otherwise never appear on
// the canvas (accordion, stepper, pagination, breadcrumb, keyboard shortcuts,
// table, empty state) so the Studio previews every surface a token touches.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/accordion/accordion.dart';
import '../../ui/dashcn/components/badge/badge.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/breadcrumb/breadcrumb.dart';
import '../../ui/dashcn/components/empty_state/empty_state.dart';
import '../../ui/dashcn/components/divider/divider.dart';
import '../../ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';
import '../../ui/dashcn/components/pagination/pagination.dart';
import '../../ui/dashcn/components/stepper/stepper.dart';
import '../../ui/dashcn/components/table/table.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../../ui/dashcn/theme/theme.dart';
import 'studio_card.dart';
import '../../ui/dashcn/foundation/component_preview.dart';

/// `Frequently asked questions`: the registry accordion with three items.
class StudioFaqCard extends StatefulWidget {
  /// Creates the card.
  const StudioFaqCard({super.key});

  @override
  State<StudioFaqCard> createState() => _StudioFaqCardState();
}

class _StudioFaqCardState extends State<StudioFaqCard> {
  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Frequently asked questions'),
      subtitle: docsSample(context, 'General, Billing and Goals'),
      child: Accordion(
        items: <AccordionItem>[
          AccordionItem(
            expanded: true,
            trigger: Text(
              docsSample(context, 'How secure is my financial data?'),
            ),
            content: Text(
              'Bank-level AES-256 encryption, SOC 2 Type II certified '
              'infrastructure, and read-only access tokens.',
            ),
          ),
          AccordionItem(
            trigger: Text(
              docsSample(
                context,
                docsSample(
                  context,
                  'How do I connect my bank or investment accounts?',
                ),
              ),
            ),
            content: Text(
              'Open Preferences, pick a receiving method and follow the '
              'bank-level OAuth flow.',
            ),
          ),
          AccordionItem(
            trigger: Text(
              docsSample(context, 'Can I export my data for tax purposes?'),
            ),
            content: Text(
              docsSample(
                context,
                docsSample(
                  context,
                  'Every report exports as CSV, including the royalty ledger.',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// `Upgrade`: three pricing tiers with one featured.
class StudioPricingCard extends StatelessWidget {
  /// Creates the card.
  const StudioPricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Plans'),
      subtitle: docsSample(context, 'Switch or cancel at any time.'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _StudioPlan(
            name: docsSample(context, 'Starter'),
            price: r'$0',
            note: docsSample(context, '1 release / month'),
            featured: false,
          ),
          Gap(12),
          _StudioPlan(
            name: 'Pro',
            price: r'$29',
            note: docsSample(context, 'Unlimited releases'),
            featured: true,
          ),
          Gap(12),
          _StudioPlan(
            name: docsSample(context, 'Label'),
            price: r'$149',
            note: docsSample(context, 'Unlimited artists'),
            featured: false,
          ),
        ],
      ),
    );
  }
}

class _StudioPlan extends StatelessWidget {
  const _StudioPlan({
    required this.name,
    required this.price,
    required this.note,
    required this.featured,
  });

  final String name;
  final String price;
  final String note;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: featured ? theme.colors.accent : null,
          borderRadius: theme.borderRadiusLg,
          border: Border.all(
            color: featured
                ? theme.colors.accentForeground
                : theme.colors.border,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(name, style: theme.typography.small),
              const Gap(4),
              Text(
                price,
                style: theme.typography.h4.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(2),
              Text(
                note,
                style: theme.typography.xSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `Release checklist`: the registry stepper on its third step.
class StudioStepperCard extends StatefulWidget {
  /// Creates the card.
  const StudioStepperCard({super.key});

  @override
  State<StudioStepperCard> createState() => _StudioStepperCardState();
}

class _StudioStepperCardState extends State<StudioStepperCard> {
  int _step = 2;

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Release checklist'),
      subtitle: 'Step ${_step + 1} of 3',
      child: Stepper(
        currentStep: _step,
        onStepChanged: (int next) => setState(() => _step = next),
        steps: <StepperStep>[
          StepperStep(title: Text(docsSample(context, 'Upload'))),
          StepperStep(title: Text(docsSample(context, 'Metadata'))),
          StepperStep(title: Text(docsSample(context, 'Publish'))),
        ],
      ),
    );
  }
}

/// `Browse`: a breadcrumb over a `pagination` row, both registry components.
class StudioBreadcrumbPagerCard extends StatefulWidget {
  /// Creates the card.
  const StudioBreadcrumbPagerCard({super.key});

  @override
  State<StudioBreadcrumbPagerCard> createState() =>
      _StudioBreadcrumbPagerCardState();
}

class _StudioBreadcrumbPagerCardState extends State<StudioBreadcrumbPagerCard> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Browse'),
      subtitle: docsSample(context, 'Reports and statements'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Breadcrumb(
            children: <Widget>[
              Text(docsSample(context, 'Home')),
              Text(docsSample(context, 'Account options')),
              Text(docsSample(context, 'Reports')),
            ],
          ),
          const Gap(16),
          const Divider(),
          const Gap(12),
          StudioHelper('Page $_page of 8'),
          const Gap(8),
          Pagination(
            page: _page,
            totalPages: 8,
            onPageChanged: (int next) => setState(() => _page = next),
          ),
        ],
      ),
    );
  }
}

/// `Format`: an icon-button toolbar with keyboard-shortcut hints.
class StudioToolbarCard extends StatelessWidget {
  /// Creates the card.
  const StudioToolbarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Format'),
      subtitle: docsSample(
        context,
        docsSample(context, 'Shortcuts are documented on every control.'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: studioNoop,
                child: Text(docsSample(context, 'Normal')),
              ),
              Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: studioNoop,
                child: Text(docsSample(context, 'Heading')),
              ),
              Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: studioNoop,
                child: Text(docsSample(context, 'Quote')),
              ),
            ],
          ),
          const Gap(16),
          KeyboardShortcut.fromActivator(
            activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
          ),
          const Gap(8),
          const KeyboardShortcut.fromActivator(
            activator: SingleActivator(LogicalKeyboardKey.keyK, meta: true),
          ),
        ],
      ),
    );
  }
}

/// `Test…`: a short vertical test suite.
class StudioTableCard extends StatelessWidget {
  /// Creates the card.
  const StudioTableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      padding: const EdgeInsets.all(0),
      title: docsSample(context, 'Team'),
      subtitle: docsSample(context, 'Who can access this workspace.'),
      child: TableView(
        defaultColumnWidth: FlexTableSize(),
        rows: <TableViewRow>[
          TableViewHeader(
            cells: <TableViewCell>[
              TableViewCell(child: Text(docsSample(context, 'Member'))),
              TableViewCell(child: Text(docsSample(context, 'Role'))),
              TableViewCell(child: Text(docsSample(context, 'Status'))),
            ],
          ),
          TableViewRow(
            cells: <TableViewCell>[
              TableViewCell(child: Text(docsSample(context, 'Maya Okafor'))),
              TableViewCell(child: Text(docsSample(context, 'Admin'))),
              TableViewCell(child: Text(docsSample(context, 'Active'))),
            ],
          ),
          TableViewRow(
            cells: <TableViewCell>[
              TableViewCell(child: Text(docsSample(context, 'Leo Marchetti'))),
              TableViewCell(child: Text(docsSample(context, 'Editor'))),
              TableViewCell(child: Text(docsSample(context, 'Invited'))),
            ],
          ),
        ],
      ),
    );
  }
}

/// `Status`: every badge variant, so a preset that changes the secondary /
/// outline / destructive colours shows up.
class StudioStatusCard extends StatelessWidget {
  /// Creates the card.
  const StudioStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: docsSample(context, 'Status'),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          Badge(
            variant: BadgeVariant.primary,
            child: Text(docsSample(context, 'Live')),
          ),
          Badge(
            variant: BadgeVariant.secondary,
            child: Text(docsSample(context, 'Draft')),
          ),
          Badge(
            variant: BadgeVariant.outline,
            child: Text(docsSample(context, 'Review')),
          ),
          Badge(
            variant: BadgeVariant.destructive,
            child: Text(docsSample(context, 'Overdue')),
          ),
        ],
      ),
    );
  }
}

/// `Distribute Track`: the reference's empty state with its CTA.
class StudioEmptyCard extends StatelessWidget {
  /// Creates the card.
  const StudioEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      padding: EdgeInsets.all(0),
      child: EmptyState(
        variant: EmptyStateVariant.empty,
        size: EmptyStateSize.compact,
        icon: Icon(LucideIcons.plus, size: 18),
        title: Text(docsSample(context, 'Distribute Track')),
        description: Text(
          'Upload your first master to start reaching listeners on Spotify, '
          'Apple Music, and more.',
          textAlign: TextAlign.center,
        ),
        primaryAction: EmptyStateAction(
          label: docsSample(context, 'Create Release'),
        ),
      ),
    );
  }
}
