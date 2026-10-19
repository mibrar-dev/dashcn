import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/video_player/video_player.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('probe mute tap', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(width: 360, child: VideoPlayer(controller: c)),
          ),
        ),
      ),
    );
    final center = tester.getCenter(find.bySemanticsLabel('Mute'));
    debugPrint('mute center: $center');
    await tester.tapAt(center);
    await tester.pump();
    debugPrint('isMuted=${c.isMuted} isPlaying=${c.isPlaying}');
    final speedCenter = tester.getCenter(
      find.bySemanticsLabel('Playback speed 1.0x'),
    );
    debugPrint('speed center: $speedCenter');
    await tester.tapAt(speedCenter);
    await tester.pump();
    debugPrint(
      'speed open: ${find.bySemanticsLabel('Speed 2.0x').evaluate().length}',
    );
    debugPrint('isPlaying=${c.isPlaying}');
  });
}
