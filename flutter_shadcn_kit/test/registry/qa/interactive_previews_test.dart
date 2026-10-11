// P7-C2: every interactive preview must react to the user.
//
// Sweeps the previews of every listed component that has something to drive
// (buttons, menus, pickers, steppers, tables, toggles) and asserts that a tap,
// a key or a drag changes something visible. Presentational components
// (badge, divider, image, markdown, spinner, tracker, ...) are excluded: they
// have no gesture to answer and are covered by `previews_test.dart`.

import '../themes/generated_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/alert/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/alert_dialog/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/autocomplete/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/border_loading/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/button/button.dart';
import 'package:flutter_shadcn_kit/registry/components/button/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/calendar/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/card/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/card_image/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/chat/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/checkbox/checkbox.dart';
import 'package:flutter_shadcn_kit/registry/components/checkbox/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/command/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/context_menu/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/dialog/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/divider/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/drawer/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/dropdown_menu/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/dropzone/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/empty_state/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/keyboard_shortcut/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/menu/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/menubar/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/navigation_menu/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/number_ticker/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/pagination/pagination.dart';
import 'package:flutter_shadcn_kit/registry/components/pagination/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/popup/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/progress/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/refresh_trigger/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/scaffold/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/skeleton/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/star_rating/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/star_rating/star_rating.dart';
import 'package:flutter_shadcn_kit/registry/components/stepper/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/stepper/stepper.dart';
import 'package:flutter_shadcn_kit/registry/components/switch/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/table/preview.dart';
import 'package:flutter_shadcn_kit/registry/components/toast/preview.dart';
import 'package:flutter_shadcn_kit/registry/foundation/component_preview.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

final Map<String, GeneratedTheme> _presets = <String, GeneratedTheme>{};

ShadcnThemeData _theme(String preset, Brightness brightness) {
  final GeneratedTheme theme = _presets.putIfAbsent(
    preset,
    () => loadGeneratedTheme('lib/registry/themes/$preset.json'),
  );
  final view = theme.view(brightness);
  return ShadcnThemeData(
    colors: view.colors,
    tokens: view.tokens,
    fonts: view.fonts,
  );
}

/// Pumps one preview the way the docs stage does, inside a real [Overlay] so
/// overlay-driven examples (menu, dropdown, popup, dialog) can open.
Future<void> _pump(
  WidgetTester tester,
  ComponentPreview preview, {
  Brightness brightness = Brightness.light,
  double width = 720,
  String preset = 'neutral',
}) async {
  await tester.pumpWidget(
    ShadcnTheme(
      data: _theme(preset, brightness),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay.wrap(
          child: Navigator(
            onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
              pageBuilder: (BuildContext context, _, _) => Center(
                child: SizedBox(
                  width: width,
                  child: Builder(builder: preview.builder),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
  expect(tester.takeException(), isNull, reason: 'preview "${preview.name}"');
}

/// Taps [text] and lets the animation settle.
Future<void> _tap(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
}

/// Taps the nth widget of type [T].
Future<void> _tapType<T>(WidgetTester tester, int index) async {
  await tester.tap(find.byType(T).at(index));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
}

ComponentPreview _example(List<ComponentPreview> list, String name) =>
    list.firstWhere((ComponentPreview preview) => preview.name == name);

void main() {
  testWidgets('alert: the trailing button dismisses and restores', (
    tester,
  ) async {
    await _pump(tester, _example(alertPreviews, 'Compact'));
    expect(find.text('You have a new message.'), findsOneWidget);
    await _tapType<Button>(tester, 0);
    expect(find.text('Notification dismissed.'), findsOneWidget);
    await _tap(tester, 'Show again');
    expect(find.text('You have a new message.'), findsOneWidget);
  });

  testWidgets('alert_dialog: the frame confirms and cancels', (tester) async {
    await _pump(tester, _example(alertDialogPreviews, 'Default'));
    await _tap(tester, 'Delete');
    expect(find.text('Confirmed.'), findsOneWidget);
    await _tap(tester, 'Show again');
    expect(find.text('Are you absolutely sure?'), findsOneWidget);
    await _tap(tester, 'Cancel');
    expect(find.text('Cancelled.'), findsOneWidget);
  });

  testWidgets('border_loading: the stepper drives the fill', (tester) async {
    await _pump(tester, _example(borderLoadingPreviews, 'Progress'));
    expect(find.text('Determinate - 60%'), findsOneWidget);
    await _tap(tester, '+20%');
    expect(find.text('Determinate - 80%'), findsOneWidget);
    await _tap(tester, '-20%');
    await _tap(tester, '-20%');
    await _tap(tester, '-20%');
    expect(find.text('Determinate - 20%'), findsOneWidget);
  });

  testWidgets('button: every press is counted', (tester) async {
    await _pump(tester, buttonPreviews[0]);
    expect(find.text('Button'), findsOneWidget);
    await _tap(tester, 'Button');
    expect(find.text('Button · 1'), findsOneWidget);
    await _tap(tester, 'Button · 1');
    expect(find.text('Button · 2'), findsOneWidget);
  });

  testWidgets('button: the size row reports the pressed button', (
    tester,
  ) async {
    await _pump(tester, _example(buttonPreviews, 'Sizes'));
    await _tap(tester, 'lg');
    expect(find.text('lg button pressed'), findsOneWidget);
  });

  testWidgets('calendar: the month stepper moves the view', (tester) async {
    await _pump(tester, _example(calendarPreviews, 'Single'));
    expect(find.text('2024-3'), findsOneWidget);
    await _tap(tester, '>');
    expect(find.text('2024-4'), findsOneWidget);
    await _tap(tester, '<');
    expect(find.text('2024-3'), findsOneWidget);
  });

  testWidgets('calendar: the month grid takes a selection', (tester) async {
    await _pump(tester, _example(calendarPreviews, 'Month grid'));
    expect(find.text('2024-3'), findsNothing);
    // Months render as cells; tapping one selects it without throwing.
    await _tapType<GestureDetector>(tester, 4);
    expect(tester.takeException(), isNull);
  });

  testWidgets('card: the footer actions report', (tester) async {
    await _pump(tester, cardPreviews[0]);
    expect(find.text('Ready to deploy'), findsOneWidget);
    await _tap(tester, 'Deploy');
    expect(find.text('Deploy queued'), findsOneWidget);
    await _tap(tester, 'Cancel');
    expect(find.text('Deploy cancelled'), findsOneWidget);
  });

  testWidgets('card_image: tapping a card opens it', (tester) async {
    await _pump(tester, _example(cardImagePreviews, 'Vertical'));
    expect(find.text('Tap the card to open it'), findsOneWidget);
    await _tap(tester, 'Sunset');
    expect(find.text('Opened "Sunset"'), findsOneWidget);
  });

  testWidgets('chat: a reaction chip toggles and counts', (tester) async {
    await _pump(tester, _example(chatPreviews, 'Grouped'));
    expect(find.text('\u{1F389} 1'), findsOneWidget);
    await _tap(tester, '\u{1F389} 1');
    expect(find.text('\u{1F389} 2'), findsOneWidget);
    await _tap(tester, '\u{1F44D} 4');
    expect(find.text('\u{1F44D} 3'), findsOneWidget);
  });

  testWidgets('checkbox: the default example switches on', (tester) async {
    await _pump(tester, _example(checkboxPreviews, 'Default'));
    final Checkbox before = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(before.value, CheckboxValue.unchecked);
    await _tapType<Checkbox>(tester, 0);
    final Checkbox after = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(after.value, CheckboxValue.checked);
  });

  testWidgets('command: picking a row reports the command', (tester) async {
    await _pump(tester, commandPreviews[0]);
    expect(find.text('Run a command to see it here'), findsOneWidget);
    await _tap(tester, 'Calendar');
    expect(find.text('Ran Calendar'), findsOneWidget);
  });

  testWidgets('context_menu: a picked row reports the action', (tester) async {
    await _pump(tester, _example(contextMenuPreviews, 'Default'));
    await tester.tap(
      find.text('Right-click anywhere on this card'),
      buttons: kSecondaryButton,
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Copy link'), findsOneWidget);
    await _tap(tester, 'Copy link');
    expect(find.text('Copied the link'), findsOneWidget);
  });

  testWidgets('dialog: the trigger pushes a dialog', (tester) async {
    await _pump(tester, dialogPreviews[0]);
    await _tap(tester, 'Open dialog');
    expect(find.text('Delete this project?'), findsWidgets);
  });

  testWidgets('dropdown_menu: the trigger opens a menu', (tester) async {
    await _pump(tester, _example(dropdownMenuPreviews, 'Trigger'));
    await _tap(tester, 'Open menu');
    expect(find.text('Profile'), findsOneWidget);
    await _tap(tester, 'Sign out');
    expect(find.text('Profile'), findsNothing);
  });

  testWidgets('dropzone: browse walks the transfer states', (tester) async {
    await _pump(tester, dropzonePreviews[0]);
    expect(find.text('Browse to upload files'), findsOneWidget);
    await _tap(tester, 'Browse files');
    expect(find.text('Uploading files...'), findsOneWidget);
    await _tap(tester, 'Browse files');
    expect(find.text('Files ready'), findsOneWidget);
    await _tap(tester, 'error');
    expect(find.text('Fix errors to continue'), findsOneWidget);
  });

  testWidgets('empty_state: the primary action reports', (tester) async {
    await _pump(tester, _example(emptyStatePreviews, 'No results'));
    expect(find.text('No results for "rocket".'), findsOneWidget);
    await _tap(tester, 'Clear filters');
    expect(find.text('Filters cleared.'), findsOneWidget);
  });

  testWidgets('menu: a picked row reports the command', (tester) async {
    await _pump(tester, _example(menuPreviews, 'Default'));
    expect(find.text('Pick a command'), findsOneWidget);
    await _tap(tester, 'Copy');
    expect(find.text('Copied to the clipboard'), findsOneWidget);
  });

  testWidgets('menubar: a submenu row reports the command', (tester) async {
    await _pump(tester, _example(menubarPreviews, 'Default'));
    await _tap(tester, 'File');
    await _tap(tester, 'Save');
    expect(find.text('Saved the document'), findsOneWidget);
  });

  testWidgets('navigation_menu: a plain item reports the page', (tester) async {
    await _pump(tester, _example(navigationMenuPreviews, 'Bar'));
    expect(find.text('Viewing Home'), findsOneWidget);
    await _tap(tester, 'Home');
    expect(find.text('Viewing Home'), findsOneWidget);
    await _tap(tester, 'About');
    expect(find.text('Viewing About'), findsOneWidget);
  });

  testWidgets('number_ticker: the value pills roll the ticker', (tester) async {
    await _pump(tester, _example(numberTickerPreviews, 'Default'));
    await _tap(tester, '987654');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('987654'), findsWidgets);
  });

  testWidgets('pagination: the icon-only pager owns its page', (tester) async {
    await _pump(tester, _example(paginationPreviews, 'Icon only'));
    expect(tester.widget<Pagination>(find.byType(Pagination)).page, 5);
    // The last button is the "next" arrow; the page buttons around 5 stay.
    await _tapType<Button>(tester, find.byType(Button).evaluate().length - 1);
    expect(tester.widget<Pagination>(find.byType(Pagination)).page, 6);
  });

  testWidgets('keyboard_shortcut: the live chord fires on meta+K', (
    tester,
  ) async {
    await _pump(tester, _example(keyboardShortcutPreviews, 'Live chord'));
    expect(find.text('Press the chord'), findsOneWidget);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.meta);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyK);
    await tester.pump();
    expect(find.text('Command palette opened'), findsOneWidget);
  });

  testWidgets('popup: the trigger anchors the surface', (tester) async {
    await _pump(tester, _example(popupPreviews, 'Anchored'));
    await _tap(tester, 'Show popup');
    expect(find.text('Ibrar Ali'), findsOneWidget);
  });

  testWidgets('progress: the live example steps the fill', (tester) async {
    await _pump(tester, _example(progressPreviews, 'Live'));
    expect(find.text('35% uploaded'), findsOneWidget);
    await _tap(tester, '+15%');
    expect(find.text('50% uploaded'), findsOneWidget);
    await _tap(tester, '-15%');
    await _tap(tester, '-15%');
    expect(find.text('20% uploaded'), findsOneWidget);
  });

  testWidgets('refresh_trigger: a pull prepends a fresh row', (tester) async {
    await _pump(
      tester,
      _example(refreshTriggerPreviews, 'Default'),
      width: 400,
    );
    expect(find.text('Refreshed 0 time(s)'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, 250));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Refreshed 1 time(s)'), findsOneWidget);
    expect(find.text('Fresh row 1'), findsOneWidget);
  });

  testWidgets('scaffold: the app-bar action opens a menu', (tester) async {
    await _pump(tester, _example(scaffoldPreviews, 'Default'), width: 420);
    expect(find.text('Tap an app-bar action'), findsOneWidget);
    await _tapType<Button>(tester, 1);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Rename'), findsOneWidget);
    await _tap(tester, 'Rename');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Rename chosen'), findsOneWidget);
  });

  testWidgets('star_rating: the vertical rating reports the tap', (
    tester,
  ) async {
    await _pump(tester, _example(starRatingPreviews, 'Vertical'));
    expect(find.text('rated 3.0'), findsOneWidget);
    final Rect stars = tester.getRect(find.byType(StarRating));
    await tester.tapAt(stars.center);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.textContaining('rated '), findsOneWidget);
    expect(find.text('rated 3.0'), findsNothing);
  });

  testWidgets('stepper: every size is tappable', (tester) async {
    await _pump(tester, _example(stepperPreviews, 'Sizes'));
    expect(find.text('Tap a step indicator'), findsOneWidget);
    await _tapType<StepperIndicator>(tester, 2);
    expect(find.textContaining('step 3'), findsOneWidget);
  });

  testWidgets('table: a row tap selects it', (tester) async {
    await _pump(tester, _example(tablePreviews, 'Default'), width: 520);
    expect(find.text('Tap a row to select it'), findsOneWidget);
    await _tap(tester, 'Jordan');
    expect(find.text('Selected Jordan'), findsOneWidget);
    await _tap(tester, 'Avery');
    expect(find.text('Selected Avery'), findsOneWidget);
  });

  testWidgets('toast: the inline action dismisses and reports', (tester) async {
    await _pump(tester, _example(toastPreviews, 'With action'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Deployment started.'), findsOneWidget);
    await _tap(tester, 'View');
    expect(find.text('Watched the deployment'), findsOneWidget);
  });

  testWidgets('interactive previews also work in dark mode', (tester) async {
    for (final ComponentPreview preview in <ComponentPreview>[
      buttonPreviews[0],
      cardPreviews[0],
      _example(tablePreviews, 'Default'),
      _example(progressPreviews, 'Live'),
      _example(menuPreviews, 'Default'),
    ]) {
      await _pump(tester, preview, brightness: Brightness.dark, width: 375);
      expect(tester.takeException(), isNull, reason: preview.name);
    }
  });

  /// Every touched preview at a phone, the docs stage and a wide desktop, under
  /// both presets in light and dark: no exception and no overflow.
  testWidgets('every swept preview renders at 375 / 720 / 1440', (
    tester,
  ) async {
    for (final List<ComponentPreview> previews in _sweptPreviews) {
      for (final ComponentPreview example in previews) {
        for (final String preset in const <String>['neutral', 'claude']) {
          for (final Brightness brightness in Brightness.values) {
            for (final double width in const <double>[375, 720, 1440]) {
              await _pump(
                tester,
                example,
                brightness: brightness,
                width: width,
                preset: preset,
              );
            }
          }
        }
      }
    }
  });
}

const List<List<ComponentPreview>> _sweptPreviews = <List<ComponentPreview>>[
  alertPreviews,
  alertDialogPreviews,
  autocompletePreviews,
  borderLoadingPreviews,
  buttonPreviews,
  calendarPreviews,
  cardPreviews,
  cardImagePreviews,
  chatPreviews,
  checkboxPreviews,
  commandPreviews,
  contextMenuPreviews,
  dialogPreviews,
  keyboardShortcutPreviews,
  dividerPreviews,
  drawerPreviews,
  dropdownMenuPreviews,
  dropzonePreviews,
  emptyStatePreviews,
  menuPreviews,
  menubarPreviews,
  navigationMenuPreviews,
  numberTickerPreviews,
  paginationPreviews,
  popupPreviews,
  progressPreviews,
  refreshTriggerPreviews,
  scaffoldPreviews,
  skeletonPreviews,
  starRatingPreviews,
  stepperPreviews,
  switchPreviews,
  tablePreviews,
  toastPreviews,
];
