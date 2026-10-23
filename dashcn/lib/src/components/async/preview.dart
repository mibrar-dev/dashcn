// Widgets-only preview gallery for the `async` component.
//
// Shows the synchronous path (one `done` snapshot), the pending path and the
// error path, plus a dark-token subtree.

import 'package:flutter/widgets.dart';

import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../spinner/spinner.dart';
import 'async.dart';
import '../../foundation/component_preview.dart';

/// Preview entry point used by the docs gallery.
class AsyncPreview extends StatefulWidget {
  /// Creates the preview.
  const AsyncPreview({super.key});

  @override
  State<AsyncPreview> createState() => _AsyncPreviewState();
}

class _AsyncPreviewState extends State<AsyncPreview> {
  int _generation = 0;
  bool _fails = false;

  // Futures created once per generation in [initState] (and on explicit
  // reload), never per build: `Future.delayed` arms a `Timer`, and a fresh
  // timer on every build leaves a pending timer at test teardown (the
  // binding's `!timersPending` invariant). Reusing the same future across
  // rebuilds lets it settle once and stay settled.
  late Future<String> _pending;
  late Future<String> _erroring;

  @override
  void initState() {
    super.initState();
    _pending = _delayed();
    _erroring = _delayed();
  }

  Future<String> _delayed() {
    final int generation = _generation;
    final bool fails = _fails;
    return Future<String>.delayed(const Duration(milliseconds: 600), () {
      if (fails) {
        throw StateError(docsSample(null, 'load failed'));
      }
      return 'loaded #$generation';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return ColoredBox(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(docsSample(context, 'synchronous value')),
            FutureOrBuilder<String>(
              future: 'ready',
              builder: (context, snapshot) =>
                  Text('${snapshot.connectionState.name} / ${snapshot.data}'),
            ),
            const SizedBox(height: 20),
            Text(docsSample(context, 'pending future')),
            FutureOrBuilder<String>(
              future: _pending,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!);
                }
                return const Spinner(size: 20);
              },
            ),
            const SizedBox(height: 20),
            Text(docsSample(context, 'error future')),
            FutureOrBuilder<String>(
              future: _erroring,
              builder: (context, snapshot) =>
                  Text(snapshot.hasError ? 'error' : 'pending'),
            ),
            const SizedBox(height: 20),
            Clickable(
              onPressed: () => setState(() {
                _generation++;
                _fails = !_fails;
                _pending = _delayed();
                _erroring = _delayed();
              }),
              child: Text(docsSample(context, 'reload futures')),
            ),
            SizedBox(height: Theme.of(context).spacing.xl),
            Builder(
              builder: (context) => ColoredBox(
                color: Theme.of(context).colors.card,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FutureOrBuilder<int>(
                    future: 42,
                    builder: (context, snapshot) =>
                        Text('dark tokens / ${snapshot.data}'),
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
