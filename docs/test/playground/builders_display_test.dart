// Playground widget tests: display components.

import 'package:docs/ui/dashcn/components/alert/alert.dart';
import 'package:docs/ui/dashcn/components/avatar/avatar.dart';
import 'package:docs/ui/dashcn/components/breadcrumb/breadcrumb.dart';
import 'package:docs/ui/dashcn/components/card/card.dart';
import 'package:docs/ui/dashcn/components/divider/divider.dart';
import 'package:docs/ui/dashcn/components/progress/progress.dart';
import 'package:docs/ui/dashcn/components/skeleton/skeleton.dart';
import 'package:docs/ui/dashcn/components/spinner/spinner.dart';
import 'package:docs/ui/dashcn/components/tooltip/tooltip.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'playground_harness.dart';

void main() {
  testWidgets('avatar controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'avatar', <String, Object?>{
      'initials': 'IB',
      'size': 56.0,
      'backgroundColor': 'primary',
      'foregroundColor': 'primaryForeground',
      'badgeGap': 4.0,
    });
    final Avatar avatar = tester.widget<Avatar>(find.byType(Avatar));
    expect(avatar.initials, 'IB');
    expect(avatar.size, 56.0);
    expect(avatar.backgroundColor, isNotNull);
    expect(avatar.foregroundColor, isNotNull);
    expect(avatar.badgeGap, 4.0);
    expect(avatar.badge, isNotNull);
  });

  testWidgets('card controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'card', <String, Object?>{
      'child': 'Hello',
      'borderWidth': 2.0,
    });
    final Card card = tester.widget<Card>(find.byType(Card));
    expect(card.borderWidth, 2.0);
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('alert controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'alert', <String, Object?>{
      'title': 'Heads up',
      'content': 'Read this.',
      'variant': 'destructive',
    });
    expect(
      tester.widget<Alert>(find.byType(Alert)).variant,
      AlertVariant.destructive,
    );
    expect(find.text('Heads up'), findsOneWidget);
    expect(find.text('Read this.'), findsOneWidget);
  });

  testWidgets('progress controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'progress', <String, Object?>{
      'value': 0.5,
      'height': 12.0,
      'color': 'chart1',
      'backgroundColor': 'muted',
      'showSparks': true,
      'disableAnimation': true,
      'semanticsLabel': 'Loading',
      'semanticsValue': 'Half',
    });
    final Progress progress = tester.widget<Progress>(find.byType(Progress));
    expect(progress.value, 0.5);
    expect(progress.height, 12.0);
    expect(progress.color, isNotNull);
    expect(progress.backgroundColor, isNotNull);
    expect(progress.showSparks, isTrue);
    expect(progress.disableAnimation, isTrue);
    expect(progress.semanticsLabel, 'Loading');
    expect(progress.semanticsValue, 'Half');
  });

  testWidgets('skeleton controls reach the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'skeleton', <String, Object?>{
      'child': 'Body',
      'enabled': false,
    });
    final Skeleton skeleton = tester.widget<Skeleton>(find.byType(Skeleton));
    expect(skeleton.enabled, isFalse);
    expect(find.text('Body'), findsOneWidget);
  });

  testWidgets('spinner controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'spinner', <String, Object?>{
      'size': 32.0,
      'strokeWidth': 4.0,
      'color': 'destructive',
      'semanticsLabel': 'Busy',
    });
    final Spinner spinner = tester.widget<Spinner>(find.byType(Spinner));
    expect(spinner.size, 32.0);
    expect(spinner.strokeWidth, 4.0);
    expect(spinner.color, isNotNull);
    expect(spinner.semanticsLabel, 'Busy');
  });

  testWidgets('tooltip controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'tooltip', <String, Object?>{
      'child': 'Info',
      'tooltip': 'More info',
    });
    expect(find.text('Info'), findsOneWidget);
    final Tooltip tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
    final Widget built = tooltip.tooltip(tester.element(find.byType(Tooltip)));
    expect((built as Text).data, 'More info');
  });

  testWidgets('divider controls reach the widget', (WidgetTester tester) async {
    await pumpPlayground(tester, 'divider', <String, Object?>{
      'thickness': 2.0,
      'extent': 120.0,
      'indent': 8.0,
      'endIndent': 8.0,
      'label': 'or',
      'labelAlignment': 'start',
    });
    final Divider divider = tester.widget<Divider>(find.byType(Divider));
    expect(divider.thickness, 2.0);
    expect(divider.extent, 120.0);
    expect(divider.indent, 8.0);
    expect(divider.endIndent, 8.0);
    expect(divider.labelAlignment, DividerLabelAlignment.start);
    expect(find.text('or'), findsOneWidget);
  });

  testWidgets('breadcrumb separator reaches the widget', (
    WidgetTester tester,
  ) async {
    await pumpPlayground(tester, 'breadcrumb', <String, Object?>{
      'separator': '>',
    });
    final Breadcrumb crumbs = tester.widget<Breadcrumb>(
      find.byType(Breadcrumb),
    );
    final Widget? separator = crumbs.separator;
    expect(separator, isA<Text>());
    expect((separator as Text).data, '>');
  });
}
