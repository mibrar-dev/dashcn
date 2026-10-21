// Widget and unit tests for the `audio_player` component.
//
// Covers: SPEC compact pill and expanded card, shared playlist controller,
// shuffle/next/previous/repeat, speed cycling, download, controlled and
// uncontrolled modes, callbacks, keyboard, RTL, reduced motion, theme and
// style overrides, custom builders and a 375px phone-width overflow guard.

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/audio_player/audio_player.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/focus_tap.dart';
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
      find.bySemanticsLabel('Playback speed 1x, tap to change'),
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
    await tester.tap(find.bySemanticsLabel('Playback speed 1x, tap to change'));
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

  group('players fix', () {
    test('demoAudioTracks match the SPEC URLs verbatim', () {
      expect(demoAudioTracks.length, 3);
      expect(demoAudioTracks[0].title, 'Southern Roots Boogie');
      expect(
        demoAudioTracks[0].src,
        'https://cdn.21st.dev/assets/mirror/ca/cadd2666c5571e12fafdb21697b26aef6f196a5a9c28e708129870167679991d.mp3',
      );
      expect(
        demoAudioTracks[1].src,
        'https://cdn.21st.dev/assets/mirror/ab/ab5cb08483abe63edd2a2ce4d843ad8f3073fcbb4a738a94f6b7529df3e1b437.mp3',
      );
      expect(
        demoAudioTracks[2].src,
        'https://cdn.21st.dev/assets/mirror/79/793e6ffda56e28691998b90a55bdaf0f2bccb8950cd8a7ee9ef7421c4ebbafdb.mp3',
      );
    });

    testWidgets('expanded card offers a speed menu', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(
        _frame(
          child: AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
        ),
      );
      expect(
        find.bySemanticsLabel('Playback speed 1x, tap to change'),
        findsOneWidget,
      );
      await tester.tap(
        find.bySemanticsLabel('Playback speed 1x, tap to change'),
      );
      await tester.pump();
      expect(find.bySemanticsLabel('Speed 1.25x'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Speed 1.25x'));
      await tester.pump();
      expect(c.playbackSpeed, 1.25);
    });

    testWidgets('expanded big play button defaults to 56px', (tester) async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      expect(audioPlayerDefaults.controlSize, isNull);
      await tester.pumpWidget(
        _frame(
          child: AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
        ),
      );
      final Finder big = find.byWidgetPredicate(
        (Widget w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).shape == BoxShape.circle &&
            w.child is Icon,
      );
      expect(big, findsOneWidget);
      expect(tester.getSize(big).width, 56);
    });

    testWidgets('initialSpeedOpen opens the expanded speed menu', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(
        _frame(
          child: AudioPlayer(
            controller: c,
            variant: AudioPlayerVariant.full,
            initialSpeedOpen: true,
          ),
        ),
      );
      expect(find.bySemanticsLabel('Speed 2x'), findsOneWidget);
    });

    testWidgets('compact volume slider maps taps to position', (tester) async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(_frame(child: AudioPlayer(controller: c)));
      final Finder mute = find.bySemanticsLabel('Mute');
      expect(mute, findsOneWidget);
      final TestGesture mouse = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: tester.getCenter(mute));
      await tester.pump();
      await mouse.moveTo(tester.getCenter(mute) + const Offset(2, 0));
      await tester.pump();
      expect(find.bySemanticsLabel('Volume'), findsOneWidget);
      final Rect line = tester.getRect(find.bySemanticsLabel('Volume'));
      await tester.tapAt(Offset(line.left + line.width * 0.25, line.center.dy));
      await tester.pump();
      expect(c.volume, closeTo(0.25, 0.05));
      await tester.tapAt(Offset(line.left + line.width * 0.75, line.center.dy));
      await tester.pump();
      expect(c.volume, closeTo(0.75, 0.05));
    });

    testWidgets('FocusableTap activates on Enter and Space', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _frame(
          child: FocusableTap(
            label: 'Probe',
            autofocus: true,
            onTap: () => taps++,
            child: const SizedBox(width: 32, height: 32),
          ),
        ),
      );
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      expect(taps, 2);
    });
  });
  testWidgets('320px phone width has no overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final FakeAudioPlaybackController c = FakeAudioPlaybackController(
      position: const Duration(seconds: 37),
      duration: const Duration(minutes: 3, seconds: 42),
      tracks: _tracks,
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 320,
              child: AudioPlayer(
                controller: c,
                variant: AudioPlayerVariant.compact,
                onDownload: () {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.bySemanticsLabel('Play'), findsOneWidget);
  });

  group('players polish', () {
    test('demo tracks carry album and track numbers', () {
      expect(demoAudioTracks[0].album, 'Southern Roots');
      expect(demoAudioTracks[0].trackNumber, 1);
      expect(demoAudioTracks[1].trackNumber, 2);
      expect(demoAudioTracks[2].album, isNotNull);
    });

    testWidgets('expanded disc sits fully inside the card', (tester) async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(
        _frame(
          child: SizedBox(
            width: 360,
            child: AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
          ),
        ),
      );
      // Disc is a full 144 px circle (no half-circle crop).
      final Finder discs = find.byWidgetPredicate(
        (Widget w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).shape == BoxShape.circle &&
            w.constraints?.maxWidth == 144,
      );
      expect(discs, findsOneWidget);
      expect(tester.getSize(discs).width, 144);
      expect(tester.getSize(discs).height, 144);
      expect(tester.takeException(), isNull);
    });

    testWidgets('tapping the disc opens the details panel', (tester) async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
        duration: const Duration(minutes: 4, seconds: 5),
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(
        _frame(
          child: SizedBox(
            width: 360,
            child: AudioPlayer(controller: c, variant: AudioPlayerVariant.full),
          ),
        ),
      );
      // Details closed by default (no track position line).
      expect(find.text('1 / 3'), findsNothing);
      await tester.tap(find.bySemanticsLabel('Track one'));
      await tester.pump();
      // Panel shows title, artist, album, duration and track number.
      expect(find.text('Track one'), findsWidgets);
      expect(find.text('Artist A'), findsWidgets);
      expect(find.text('4:05'), findsWidgets);
      expect(find.text('1 / 3'), findsOneWidget);
    });

    testWidgets('compact progress line seeks on drag with time updating', (
      tester,
    ) async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        position: const Duration(seconds: 30),
        duration: const Duration(minutes: 4),
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(_frame(child: AudioPlayer(controller: c)));
      expect(find.text('0:30'), findsOneWidget);
      final Finder seek = find.bySemanticsLabel('Seek');
      expect(seek, findsOneWidget);
      final Offset center = tester.getCenter(seek);
      final double width = tester.getSize(seek).width;
      // Drag to ~75% of the line.
      await tester.dragFrom(
        Offset(center.dx - width * 0.3, center.dy),
        Offset(width * 0.6, 0),
      );
      await tester.pump();
      expect(c.position.inSeconds, greaterThan(100));
      expect(find.text('0:30'), findsNothing);
    });

    testWidgets('compact speed and volume keep 32px targets', (tester) async {
      final FakeAudioPlaybackController c = FakeAudioPlaybackController(
        tracks: _tracks,
      );
      addTearDown(c.dispose);
      await tester.pumpWidget(_frame(child: AudioPlayer(controller: c)));
      final Size speed = tester.getSize(
        find.bySemanticsLabel('Playback speed 1x, tap to change'),
      );
      expect(speed.width, 32);
      final Size mute = tester.getSize(find.bySemanticsLabel('Mute'));
      expect(mute.width, 32);
    });
  });
}
