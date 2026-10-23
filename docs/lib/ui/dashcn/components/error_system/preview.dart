// Gallery preview for the `error_system` component: the full-page state, the
// inline row, the app banner and the dark palette. Widgets-only; the docs app
// embeds [ErrorSystemPreview] directly.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'error_system.dart';
import '../../foundation/component_preview.dart';

/// Renders the error system gallery.
class ErrorSystemPreview extends StatefulWidget {
  /// Creates the preview.
  const ErrorSystemPreview({super.key});

  @override
  State<ErrorSystemPreview> createState() => _ErrorSystemPreviewState();
}

class _ErrorSystemPreviewState extends State<ErrorSystemPreview> {
  late final HubAppScope _scope = HubAppScope('preview.banner');
  late final AppError _error = AppError(
    code: AppErrorCode.server,
    title: docsSample(context, 'Server error'),
    message: docsSample(
      context,
      docsSample(
        context,
        docsSample(
          context,
          'The request could not be completed. Please try again.',
        ),
      ),
    ),
    actions: <ErrorAction>[ErrorAction.retry(() {}), ErrorAction.report(() {})],
  );

  @override
  void initState() {
    super.initState();
    _scope.notifier.value = _error;
  }

  @override
  void dispose() {
    _scope.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: DefaultTextStyle(
        style: TextStyle(color: theme.colors.foreground, fontSize: 13),
        child: ColoredBox(
          color: theme.colors.background,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _section(
                  context,
                  docsSample(context, 'Full page'),
                  ErrorState(error: _error),
                ),
                Gap(theme.spacing.xl),
                _section(
                  context,
                  docsSample(context, 'Inline'),
                  InlineError(
                    message: docsSample(context, 'This field is required.'),
                  ),
                ),
                Gap(theme.spacing.xl),
                _section(
                  context,
                  docsSample(context, 'Banner'),
                  AppErrorBanner(scope: _scope),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Gap(Theme.of(context).spacing.sm),
        child,
      ],
    );
  }
}
