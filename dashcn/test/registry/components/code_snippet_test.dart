// Widget tests for the `code_snippet` component.
//
// Covers rendering, copy button, controlled/uncontrolled state, callbacks,
// keyboard navigation, RTL mirroring, reduced motion, theme/style overrides,
// custom builder slots, language syntax colouring, and a 375px phone-width test.

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dashcn/src/components/code_snippet/code_snippet.dart';
import 'package:dashcn/src/foundation/gap.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  CodeSnippetTheme? scoped,
  TextDirection direction = TextDirection.ltr,
  bool disableAnimations = false,
  double? width,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<CodeSnippetTheme>(data: scoped, child: body);
  }
  return MediaQuery(
    data: MediaQueryData(disableAnimations: disableAnimations),
    child: Theme(
      data: data,
      child: ComponentThemes(
        themes: app,
        child: Directionality(
          textDirection: direction,
          child: _OverlayHost(
            builder: (_) => Center(
              child: width != null ? SizedBox(width: width, child: body) : body,
            ),
          ),
        ),
      ),
    ),
  );
}

class _OverlayHost extends StatefulWidget {
  const _OverlayHost({required this.builder});

  final WidgetBuilder builder;

  @override
  State<_OverlayHost> createState() => _OverlayHostState();
}

class _OverlayHostState extends State<_OverlayHost> {
  late final OverlayEntry _entry = OverlayEntry(
    builder: (BuildContext context) => Builder(builder: widget.builder),
  );

  @override
  Widget build(BuildContext context) =>
      Overlay(initialEntries: <OverlayEntry>[_entry]);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String? clipboardPayload;

  setUp(() {
    clipboardPayload = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (
          MethodCall methodCall,
        ) async {
          if (methodCall.method == 'Clipboard.setData') {
            final Map<dynamic, dynamic>? args =
                methodCall.arguments as Map<dynamic, dynamic>?;
            clipboardPayload = args?['text'] as String?;
            return null;
          }
          if (methodCall.method == 'Clipboard.getData') {
            return <String, dynamic>{'text': clipboardPayload};
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  group('rendering', () {
    testWidgets('shows the code content', (tester) async {
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('hello()'))),
      );
      expect(find.text('hello()'), findsOneWidget);
    });

    testWidgets('copy button renders by default in corner row', (tester) async {
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('cmd'))),
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is Positioned && w.top != null && w.bottom == null,
        ),
        findsOneWidget,
      );
      expect(find.byType(Clickable), findsOneWidget);
      expect(find.byIcon(LucideIcons.copy), findsOneWidget);
    });

    testWidgets('no actions row when showCopyButton is false and no actions', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(code: Text('cmd'), showCopyButton: false),
        ),
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is Positioned && w.top != null && w.bottom == null,
        ),
        findsNothing,
      );
      expect(find.byType(Clickable), findsNothing);
    });

    testWidgets('custom actions render alongside copy button', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            actions: <Widget>[Text('Run')],
            code: Text('cmd'),
          ),
        ),
      );
      expect(find.text('Run'), findsOneWidget);
      expect(find.byIcon(LucideIcons.copy), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is Positioned && w.top != null && w.bottom == null,
        ),
        findsOneWidget,
      );
    });

    testWidgets('card surface uses the card token', (tester) async {
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('cmd'))),
      );
      final Container box = tester.widget<Container>(
        find.byType(Container).first,
      );
      final BoxDecoration decoration = box.decoration! as BoxDecoration;
      expect(decoration.color, ThemeColors.lightFallback.card);
      expect(decoration.border!.top.color, ThemeColors.lightFallback.border);
    });

    testWidgets('default padding leaves room on the right in LTR', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('cmd'))),
      );
      final Iterable<SingleChildScrollView> scrollers = tester
          .widgetList<SingleChildScrollView>(
            find.byType(SingleChildScrollView),
          );
      final EdgeInsets padding = (scrollers.last.padding! as EdgeInsets)
          .resolve(TextDirection.ltr);
      expect(padding.left, 16);
      expect(padding.right, 56);
    });
  });

  group('copy and clipboard', () {
    testWidgets('tapping copy button copies text and shows feedback', (
      tester,
    ) async {
      bool onCopyCalled = false;
      await tester.pumpWidget(
        _frame(
          child: CodeSnippet(
            code: const Text('flutter run'),
            onCopy: () => onCopyCalled = true,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.copy), findsOneWidget);
      expect(find.byIcon(LucideIcons.check), findsNothing);

      await tester.tap(find.byType(Clickable));
      await tester.pump();

      expect(clipboardPayload, 'flutter run');
      expect(onCopyCalled, isTrue);
      expect(find.byIcon(LucideIcons.check), findsOneWidget);

      // After feedback timer (2000 ms), reverts to copy icon.
      await tester.pump(const Duration(milliseconds: 2100));
      await tester.pumpAndSettle();
      expect(find.byIcon(LucideIcons.copy), findsOneWidget);
      expect(find.byIcon(LucideIcons.check), findsNothing);
    });

    testWidgets('uses rawCode when provided', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            rawCode: 'git status --porcelain',
            code: Text('git status'),
          ),
        ),
      );

      await tester.tap(find.byType(Clickable));
      await tester.pump();
      expect(clipboardPayload, 'git status --porcelain');
    });

    testWidgets('controlled mode respects copied prop and onCopiedChange', (
      tester,
    ) async {
      bool? notified;
      await tester.pumpWidget(
        _frame(
          child: CodeSnippet(
            copied: true,
            code: const Text('code'),
            onCopiedChange: (v) => notified = v,
          ),
        ),
      );

      expect(find.byIcon(LucideIcons.check), findsOneWidget);
      await tester.tap(find.byType(Clickable));
      await tester.pump();
      expect(notified, isTrue);
    });
  });

  group('custom builders', () {
    testWidgets('copyButtonBuilder replaces copy button', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: CodeSnippet(
            code: const Text('hello'),
            copyButtonBuilder: (context, onCopy, copied) {
              return GestureDetector(
                onTap: onCopy,
                child: Text(copied ? 'DONE' : 'CLICK_COPY'),
              );
            },
          ),
        ),
      );

      expect(find.text('CLICK_COPY'), findsOneWidget);
      await tester.tap(find.text('CLICK_COPY'));
      await tester.pump();
      expect(find.text('DONE'), findsOneWidget);
      expect(clipboardPayload, 'hello');
    });

    testWidgets('actionsBuilder replaces entire actions row', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: CodeSnippet(
            code: const Text('hello'),
            actionsBuilder: (context, actions) {
              return Container(
                key: const ValueKey('custom_actions'),
                child: const Text('CUSTOM_ACTIONS'),
              );
            },
          ),
        ),
      );

      expect(find.byKey(const ValueKey('custom_actions')), findsOneWidget);
      expect(find.text('CUSTOM_ACTIONS'), findsOneWidget);
    });

    testWidgets('codeBuilder wraps or customizes code widget', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: CodeSnippet(
            code: const Text('hello'),
            codeBuilder: (context, code) {
              return Container(
                key: const ValueKey('wrapped_code'),
                child: code,
              );
            },
          ),
        ),
      );

      expect(find.byKey(const ValueKey('wrapped_code')), findsOneWidget);
    });
  });

  group('keyboard and accessibility', () {
    testWidgets('copy button has semantics and is keyboard accessible', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('cmd'))),
      );

      final Semantics semantics = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.byType(Clickable),
              matching: find.byType(Semantics),
            )
            .first,
      );
      final SemanticsProperties properties = semantics.properties;
      expect(properties.button, isTrue);
      expect(properties.label, 'Copy code');
    });
  });

  group('RTL support', () {
    testWidgets('RTL mirrors padding and positions actions correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          direction: TextDirection.rtl,
          child: const CodeSnippet(code: Text('cmd')),
        ),
      );

      final Iterable<SingleChildScrollView> scrollers = tester
          .widgetList<SingleChildScrollView>(
            find.byType(SingleChildScrollView),
          );
      final EdgeInsets padding = (scrollers.last.padding! as EdgeInsets)
          .resolve(TextDirection.rtl);
      // In RTL, the end is left, so left has the 56px room.
      expect(padding.left, 56);
      expect(padding.right, 16);
    });
  });

  group('reduced motion', () {
    testWidgets('honours disableAnimations', (tester) async {
      await tester.pumpWidget(
        _frame(
          disableAnimations: true,
          child: const CodeSnippet(code: Text('cmd')),
        ),
      );

      final AnimatedSwitcher switcher = tester.widget<AnimatedSwitcher>(
        find.byType(AnimatedSwitcher),
      );
      expect(switcher.duration, Duration.zero);
    });
  });

  group('syntax colouring', () {
    testWidgets('highlights Dart code', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            language: 'dart',
            code: Text('void main() { const x = "hi"; }'),
          ),
        ),
      );
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('highlights JSON code', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            language: 'json',
            code: Text('{"name": "dashcn", "count": 42}'),
          ),
        ),
      );
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('highlights YAML code', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            language: 'yaml',
            code: Text('name: dashcn\nversion: 1.0.0'),
          ),
        ),
      );
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('highlights Shell code', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            language: 'bash',
            code: Text('flutter pub add dashcn'),
          ),
        ),
      );
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('highlights TypeScript code', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            language: 'ts',
            code: Text('const user: string = "alex";'),
          ),
        ),
      );
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('highlights HTML code', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            language: 'html',
            code: Text('<div class="box">hello</div>'),
          ),
        ),
      );
      expect(find.byType(RichText), findsWidgets);
    });
  });

  group('375px phone-width constraint test', () {
    testWidgets('long line inside 375px phone screen never overflows', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          width: 375,
          child: const CodeSnippet(
            code: Text(
              'void main() { runApp(const MyApp(home: Center(child: Text("very long line that must scroll horizontally and never overflow the 375px phone viewport")))); }',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      final SingleChildScrollView horizontalScroller = tester
          .widgetList<SingleChildScrollView>(find.byType(SingleChildScrollView))
          .firstWhere((s) => s.scrollDirection == Axis.horizontal);
      expect(horizontalScroller, isNotNull);
    });
  });

  group('theme precedence', () {
    testWidgets('widget > scoped > app > defaults', (tester) async {
      CodeSnippetTheme resolve(BuildContext context, CodeSnippetTheme? widget) {
        return resolveComponentStyle<CodeSnippetTheme, CodeSnippetTheme>(
          context,
          widget: widget,
          select: (t) => t,
          defaults: codeSnippetDefaults,
        );
      }

      CodeSnippetTheme? seen;
      Future<void> pump({
        CodeSnippetTheme? widget,
        CodeSnippetTheme? scoped,
        List<ComponentThemeData> app = const <ComponentThemeData>[],
      }) async {
        await tester.pumpWidget(
          _frame(
            app: app,
            scoped: scoped,
            child: Builder(
              builder: (context) {
                seen = resolve(context, widget);
                return const SizedBox();
              },
            ),
          ),
        );
      }

      await pump();
      expect(seen!.borderWidth, 1);
      await pump(
        app: const <ComponentThemeData>[CodeSnippetTheme(borderWidth: 2)],
      );
      expect(seen!.borderWidth, 2);
      await pump(
        scoped: const CodeSnippetTheme(borderWidth: 3),
        app: const <ComponentThemeData>[CodeSnippetTheme(borderWidth: 2)],
      );
      expect(seen!.borderWidth, 3);
      await pump(
        widget: const CodeSnippetTheme(borderWidth: 4),
        scoped: const CodeSnippetTheme(borderWidth: 3),
        app: const <ComponentThemeData>[CodeSnippetTheme(borderWidth: 2)],
      );
      expect(seen!.borderWidth, 4);
    });

    testWidgets('dark tokens restyle the surface', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(colors: ThemeColors.darkFallback),
          child: const CodeSnippet(code: Text('cmd')),
        ),
      );
      final Container box = tester.widget<Container>(
        find.byType(Container).first,
      );
      final BoxDecoration decoration = box.decoration! as BoxDecoration;
      expect(decoration.color, ThemeColors.darkFallback.card);
    });
  });

  group('regressions', () {
    testWidgets('rebuilds do not keep stale state', (tester) async {
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('one'))),
      );
      expect(find.text('one'), findsOneWidget);
      await tester.pumpWidget(
        _frame(child: const CodeSnippet(code: Text('two'))),
      );
      expect(find.text('two'), findsOneWidget);
      expect(find.text('one'), findsNothing);
    });

    testWidgets('actions are spaced with the foundation gap', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const CodeSnippet(
            actions: <Widget>[Text('A'), Text('B')],
            code: Text('cmd'),
          ),
        ),
      );
      expect(find.byType(Gap), findsWidgets);
    });
  });
}
