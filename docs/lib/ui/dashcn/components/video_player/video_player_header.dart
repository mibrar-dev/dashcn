// Bar header for `video_player`: title/subtitle + time.
//
// Split from `video_player_controls.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// Title/subtitle header with elapsed/total (or LIVE) on the right.
Widget videoBarHeader({
  required BuildContext context,
  required VideoPlaybackController c,
  required VideoPlayerTheme style,
  required Color fg,
  required Duration Function(VideoPlaybackController c) total,
  String? title,
  String? subtitle,
  VideoPartBuilder? headerBuilder,
  VideoPartBuilder? timeLabelBuilder,
}) {
  if (headerBuilder != null) {
    return headerBuilder(context, c);
  }
  final String time = c.isLive
      ? '${formatMediaTime(c.position)}  •  LIVE'
      : '${formatMediaTime(c.position)} / ${formatMediaTime(total(c))}';
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (title != null)
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: fg,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (subtitle != null)
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: fg.withAlpha(0xB3), fontSize: 12),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        timeLabelBuilder?.call(context, c) ??
            Text(
              time,
              maxLines: 1,
              style:
                  style.timeTextStyle ??
                  TextStyle(color: fg.withAlpha(0xCC), fontSize: 12),
            ),
      ],
    ),
  );
}
