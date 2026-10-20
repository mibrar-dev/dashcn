// Widget and unit tests for the `audio_player` component.
//
// Covers: rendering, compact/full layouts, controlled/uncontrolled,
// callbacks, keyboard, RTL, reduced motion, theme + style overrides, custom
// builders (cover, waveform) and a 375px phone-width overflow guard.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/audio_player/audio_player.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  bool reducedMotion = false,
  required Widget child,
}) {
  Widget body = Directionality(
    textDirection: direction,
    child: Center(child: SizedBox(width: 360, child: child)),
  );
  if (reducedMotion) {
    body = MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: body,
    );
  }
  return Theme(
    data: data,
    child: ComponentThemes(themes: app, child: body),
  );
}

void main() {
  group('formatAudioTime', () {
    test('formats m:ss and h:mm:ss', () {
      expect(formatAudioTime(const Duration(minutes: 1, seconds: 12)), '1:12');
      expect(formatAudioTime(const Duration(minutes: 4, seconds: 5)), '4:05');
      expect(
        formatAudioTime(const Duration(hours: 2, minutes: 3, seconds: 4)),
        '2:03:04',
      );
    });
  });

  group('fake controller', () {
    test('play/pause/seek/volume/mute/speed/loop notify', () async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController();
      var calls = 0;
      c.addListener(() => calls++);
      await c.play();
      expect(c.isPlaying, isTrue);
      await c.pause();
      expect(c.isPlaying, isFalse);
      await c.seekTo(const Duration(seconds: 60));
      expect(c.position, const Duration(seconds: 60));
      await c.seekTo(const Duration(hours: 5));
      expect(c.position, c.duration);
      await c.setVolume(0.2);
      expect(c.volume, 0.2);
      await c.setMuted(true);
      expect(c.isMuted, isTrue);
      await c.setPlaybackSpeed(1.5);
      expect(c.playbackSpeed, 1.5);
      await c.setLooping(true);
      expect(c.isLooping, isTrue);
      expect(calls, greaterThan(0));
      c.dispose();
    });
  });

  testWidgets('full layout renders title, times and transport', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          title: 'Midnight drive',
          subtitle: 'Neon Coastline',
        ),
      ),
    );
    expect(find.text('Midnight drive'), findsOneWidget);
    expect(find.text('Neon Coastline'), findsOneWidget);
    expect(find.text('1:12'), findsOneWidget);
    expect(find.text('4:05'), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsOneWidget);
    expect(find.bySemanticsLabel('Back 10 seconds'), findsOneWidget);
    expect(find.bySemanticsLabel('Forward 10 seconds'), findsOneWidget);
    expect(find.bySemanticsLabel('Enable repeat'), findsOneWidget);
  });

  testWidgets('compact layout renders one row', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          variant: AudioPlayerVariant.compact,
          title: 'Compact episode',
        ),
      ),
    );
    expect(find.text('Compact episode'), findsOneWidget);
    expect(find.text('1:12'), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsOneWidget);
    expect(find.bySemanticsLabel('Back 10 seconds'), findsNothing);
  });

  testWidgets('play, skip, speed, repeat and mute work', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(controller: c, title: 'Skip demo'),
      ),
    );
    await tester.tap(find.bySemanticsLabel('Play'));
    await tester.pump();
    expect(c.isPlaying, isTrue);

    final Duration before = c.position;
    await tester.tap(find.bySemanticsLabel('Forward 10 seconds'));
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 10));
    await tester.tap(find.bySemanticsLabel('Back 10 seconds'));
    await tester.pump();
    expect(c.position, before);

    await tester.tap(find.bySemanticsLabel('Playback speed 1.0x'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Speed 2.0x').first);
    await tester.pump();
    expect(c.playbackSpeed, 2.0);

    await tester.tap(find.bySemanticsLabel('Enable repeat'));
    await tester.pump();
    expect(c.isLooping, isTrue);

    await tester.tap(find.bySemanticsLabel('Mute'));
    await tester.pump();
    expect(c.isMuted, isTrue);
  });

  testWidgets('uncontrolled mode owns a fake controller', (tester) async {
    await tester.pumpWidget(_frame(child: const AudioPlayer(title: 'Owned')));
    expect(find.text('Owned'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Play'));
    await tester.pump();
    expect(find.bySemanticsLabel('Pause'), findsOneWidget);
  });

  testWidgets('keyboard: space/arrows/j/l/m', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(child: AudioPlayer(controller: c, autofocus: true)),
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump();
    expect(c.isPlaying, isTrue);
    final Duration before = c.position;
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 5));
    await tester.sendKeyEvent(LogicalKeyboardKey.keyL);
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 15));
    await tester.sendKeyEvent(LogicalKeyboardKey.keyJ);
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 5));
    await tester.sendKeyEvent(LogicalKeyboardKey.keyM);
    await tester.pump();
    expect(c.isMuted, isTrue);
  });

  testWidgets('renders in RTL without overflow', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        direction: TextDirection.rtl,
        child: AudioPlayer(controller: c, title: 'RTL'),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('RTL'), findsOneWidget);
  });

  testWidgets('renders under reduced motion', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(reducedMotion: true, child: AudioPlayer(controller: c)),
    );
    expect(tester.takeException(), isNull);
    expect(find.byType(AudioPlayer), findsOneWidget);
  });

  testWidgets('widget theme leg overrides title style', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    const Color custom = Color(0xFFE11D48);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          title: 'Themed',
          theme: const AudioPlayerTheme(
            titleTextStyle: TextStyle(color: custom),
          ),
        ),
      ),
    );
    final Text label = tester.widget<Text>(find.text('Themed'));
    expect(label.style?.color, custom);
  });

  testWidgets('custom builders replace parts', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          title: 'Hidden title',
          titleBuilder: (context, controller) => const Text('custom title'),
          waveformBuilder: (context, controller, defaults) =>
              const Text('custom waveform'),
          coverBuilder: (context, controller) => const Text('custom cover'),
        ),
      ),
    );
    expect(find.text('custom title'), findsOneWidget);
    expect(find.text('custom waveform'), findsOneWidget);
    expect(find.text('custom cover'), findsOneWidget);
    expect(find.text('Hidden title'), findsNothing);
  });

  testWidgets('cover slot renders artwork', (tester) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          title: 'Artwork',
          cover: const Text('artwork pixels'),
        ),
      ),
    );
    expect(find.text('artwork pixels'), findsOneWidget);
  });

  testWidgets('375px phone width has no overflow', (tester) async {
    tester.view.physicalSize = const Size(375, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final FakeAudioPlaybackController full = FakeAudioPlaybackController();
    addTearDown(full.dispose);
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 375,
              child: AudioPlayer(
                controller: full,
                title: 'A long track title that must ellipsize',
                subtitle: 'A long subtitle that must ellipsize too',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    final FakeAudioPlaybackController compact = FakeAudioPlaybackController();
    addTearDown(compact.dispose);
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 375,
              child: AudioPlayer(
                controller: compact,
                variant: AudioPlayerVariant.compact,
                title: 'A long compact title that must ellipsize',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byIcon(LucideIcons.play), findsOneWidget);
  });
}
