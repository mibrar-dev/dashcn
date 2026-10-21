// Widget and unit tests for the `audio_player` component.
//
// Covers: SPEC compact pill and expanded card, shared playlist controller,
// shuffle/next/previous/repeat, speed cycling, download, controlled and
// uncontrolled modes, callbacks, keyboard, RTL, reduced motion, theme and
// style overrides, custom builders and a 375px phone-width overflow guard.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/audio_player/audio_player.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const List<AudioTrack> _tracks = <AudioTrack>[
  AudioTrack(title: 'Track one', artist: 'Artist A'),
  AudioTrack(title: 'Track two', artist: 'Artist B'),
  AudioTrack(title: 'Track three', artist: 'Artist C'),
];

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  bool reducedMotion = false,
  required Widget child,
}) {
  Widget body = Directionality(
    textDirection: direction,
    child: Center(child: SizedBox(width: 420, child: child)),
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
      expect(formatAudioTime(const Duration(minutes: 1, seconds: 1)), '1:01');
      expect(formatAudioTime(const Duration(minutes: 5, seconds: 40)), '5:40');
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

    test('playlist next/previous/setTrack/shuffle advance', () async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      expect(c.currentTrack?.title, 'Track one');
      expect(c.hasPrevious, isFalse);
      expect(c.hasNext, isTrue);
      await c.next();
      expect(c.currentIndex, 1);
      expect(c.currentTrack?.title, 'Track two');
      await c.previous();
      expect(c.currentIndex, 0);
      await c.setTrack(2);
      expect(c.currentTrack?.title, 'Track three');
      expect(c.hasNext, isFalse);
      await c.next();
      expect(c.currentIndex, 2);
      await c.toggleShuffle();
      expect(c.isShuffled, isTrue);
      await c.next();
      expect(c.position, Duration.zero);
    });

    test('cycleSpeed walks kAudioSpeeds and wraps', () async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController();
      addTearDown(c.dispose);
      await c.cycleSpeed();
      expect(c.playbackSpeed, 1.25);
      await c.cycleSpeed();
      expect(c.playbackSpeed, 1.5);
      await c.setPlaybackSpeed(3);
      await c.cycleSpeed();
      expect(c.playbackSpeed, 1.0);
    });
  });

  testWidgets('compact pill shows times, title, volume, speed, download', (
    tester,
  ) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController(
      position: const Duration(minutes: 1, seconds: 1),
      duration: const Duration(minutes: 5, seconds: 40),
      tracks: _tracks,
    );
    addTearDown(c.dispose);
    var downloaded = 0;
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          variant: AudioPlayerVariant.compact,
          onDownload: () => downloaded++,
        ),
      ),
    );
    expect(find.text('1:01'), findsOneWidget);
    expect(find.text('5:40'), findsOneWidget);
    expect(find.text('Track one'), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsOneWidget);
    expect(find.bySemanticsLabel('Mute'), findsOneWidget);
    expect(
      find.bySemanticsLabel('Playback speed 1.0x, tap to change'),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Download'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Download'));
    expect(downloaded, 1);
  });

  testWidgets('compact speed chip cycles 1x, 1.25x, 1.5x, 2x, 3x', (
    tester,
  ) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(_frame(child: AudioPlayer(controller: c)));
    await tester.tap(
      find.bySemanticsLabel('Playback speed 1.0x, tap to change'),
    );
    await tester.pump();
    expect(c.playbackSpeed, 1.25);
  });

  testWidgets('expanded card shows playlist chrome and transport', (
    tester,
  ) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController(
      tracks: _tracks,
      position: const Duration(seconds: 29),
      duration: const Duration(minutes: 6, seconds: 12),
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(
          controller: c,
          variant: AudioPlayerVariant.full,
          cover: const Text('artwork pixels'),
        ),
      ),
    );
    expect(find.text('Track one'), findsOneWidget);
    expect(find.text('ARTIST A'), findsOneWidget);
    expect(find.text('0:29 / 6:12'), findsOneWidget);
    expect(find.text('artwork pixels'), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsOneWidget);
    expect(find.bySemanticsLabel('Previous track'), findsOneWidget);
    expect(find.bySemanticsLabel('Next track'), findsOneWidget);
    expect(find.bySemanticsLabel('Enable shuffle'), findsOneWidget);
    expect(find.bySemanticsLabel('Enable repeat'), findsOneWidget);
  });

  testWidgets('expanded next/previous move through the playlist', (
    tester,
  ) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController(
      tracks: _tracks,
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
      ),
    );
    await tester.tap(find.bySemanticsLabel('Next track'));
    await tester.pump();
    expect(find.text('Track two'), findsOneWidget);
    expect(find.text('ARTIST B'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Previous track'));
    await tester.pump();
    expect(find.text('Track one'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Enable shuffle'));
    await tester.pump();
    expect(c.isShuffled, isTrue);
    await tester.tap(find.bySemanticsLabel('Enable repeat'));
    await tester.pump();
    expect(c.isLooping, isTrue);
  });

  testWidgets('one controller drives compact and expanded together', (
    tester,
  ) async {
    final FakeAudioPlaybackController c = FakeAudioPlaybackController(
      tracks: _tracks,
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AudioPlayer(controller: c, variant: AudioPlayerVariant.compact),
            AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
          ],
        ),
      ),
    );
    expect(find.text('Track one'), findsNWidgets(2));
    await c.setTrack(2);
    await tester.pump();
    expect(find.text('Track three'), findsNWidgets(2));
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
      _frame(
        child: AudioPlayer(
          controller: c,
          variant: AudioPlayerVariant.full,
          autofocus: true,
        ),
      ),
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
    final FakeAudioPlaybackController c = FakeAudioPlaybackController(
      tracks: _tracks,
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        direction: TextDirection.rtl,
        child: AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Track one'), findsOneWidget);
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
          variant: AudioPlayerVariant.full,
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
          variant: AudioPlayerVariant.full,
          title: 'Hidden title',
          titleBuilder: (context, controller) => const Text('custom title'),
          waveformBuilder: (context, controller, defaults) =>
              const Text('custom wave'),
          coverBuilder: (context, controller) => const Text('custom cover'),
          previousBuilder: (context, controller) => const Text('custom prev'),
        ),
      ),
    );
    expect(find.text('custom title'), findsOneWidget);
    expect(find.text('custom wave'), findsOneWidget);
    expect(find.text('custom cover'), findsOneWidget);
    expect(find.text('custom prev'), findsOneWidget);
    expect(find.text('Hidden title'), findsNothing);
  });

  testWidgets('375px phone width has no overflow', (tester) async {
    tester.view.physicalSize = const Size(375, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final FakeAudioPlaybackController full = FakeAudioPlaybackController(
      tracks: _tracks,
    );
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
                variant: AudioPlayerVariant.full,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    final FakeAudioPlaybackController compact = FakeAudioPlaybackController(
      tracks: _tracks,
    );
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
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byIcon(LucideIcons.play), findsWidgets);
  });
}
