// Pages screen of the `onboarding-01` flow: swipeable [Carousel] pages with
// a [DotIndicator], Skip, and Next / Get started.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/carousel/carousel.dart';
import '../../../components/dot_indicator/dot_indicator.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';

/// Swipeable intro pages; the last page continues to `/permission`.
class Onboarding01PagesScreen extends StatefulWidget {
  /// Creates the pages screen.
  const Onboarding01PagesScreen({super.key, required this.pages, this.onSkip});

  /// Pages to swipe through.
  final List<Onboarding01Page> pages;

  /// Called when Skip is tapped.
  final VoidCallback? onSkip;

  @override
  State<Onboarding01PagesScreen> createState() =>
      _Onboarding01PagesScreenState();
}

class _Onboarding01PagesScreenState extends State<Onboarding01PagesScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final bool last = _index >= widget.pages.length - 1;
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Button(
                      variant: ButtonVariant.ghost,
                      size: ButtonSize.sm,
                      onPressed: widget.onSkip,
                      child: const Text('Skip'),
                    ),
                  ),
                  Expanded(
                    child: Carousel(
                      itemCount: widget.pages.length,
                      onIndexChanged: (int value) =>
                          setState(() => _index = value),
                      itemBuilder: (BuildContext context, int index) =>
                          _PageCard(page: widget.pages[index]),
                    ),
                  ),
                  Gap(appTheme.spacing.md),
                  DotIndicator(index: _index, length: widget.pages.length),
                  Gap(appTheme.spacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: Button(
                      onPressed: last
                          ? () => Navigator.of(context).pushNamed('/permission')
                          : () => setState(() => _index = _index + 1),
                      child: Text(last ? 'Get started' : 'Next'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One intro page rendered as a centred card.
class _PageCard extends StatelessWidget {
  const _PageCard({required this.page});

  final Onboarding01Page page;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(appTheme.spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(page.icon, size: 44, color: appTheme.colors.primary),
              Gap(appTheme.spacing.lg),
              Text(page.title, style: appTheme.typography.h3),
              Gap(appTheme.spacing.sm),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: appTheme.typography.textMuted.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
