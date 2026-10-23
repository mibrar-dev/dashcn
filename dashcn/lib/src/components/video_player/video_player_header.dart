// Bar header for `video_player`: title/subtitle + time.
//
// Split from `video_player_controls.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import '../../primitives/localizations/localizations.dart';
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
  final TextStyle timeStyle =
      style.timeTextStyle ?? TextStyle(color: fg.withAlpha(0xCC), fontSize: 12);
  final Widget time =
      timeLabelBuilder?.call(context, c) ??
      Text(
        c.isLive
            ? formatMediaTime(c.position)
            : '${formatMediaTime(c.position)} / ${formatMediaTime(total(c))}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: timeStyle,
      );
  final Widget? liveBadge = c.isLive
      ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFDC2626),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ExcludeSemantics(
            child: Text(
              ComponentLocalizations.of(context).mediaLiveBadge,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
        )
      : null;
  // Custom time widgets may not have a baseline; keep them in a centred
  // row. The default Text time shares one baseline Row with the title.
  if (timeLabelBuilder != null) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: fg,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(child: time),
          if (liveBadge != null) ...<Widget>[
            const SizedBox(width: 8),
            liveBadge,
          ],
        ],
      ),
    );
  }
  // Title and time share one baseline Row (both Text, so baseline holds);
  // subtitle and the LIVE chip sit below, so long titles ellipsize without
  // the time or chip overlapping the title area.
  final Widget badgeSlot = liveBadge ?? const SizedBox.shrink();
  final bool hasSecondRow = subtitle != null || liveBadge != null;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Expanded(
              child: Text(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: fg,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 8), child: time),
          ],
        ),
        if (hasSecondRow)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: subtitle != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: <Widget>[
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: fg.withAlpha(0xB3), fontSize: 12),
                    ),
                  ),
                if (subtitle != null && liveBadge != null)
                  const SizedBox(width: 8),
                badgeSlot,
              ],
            ),
          ),
      ],
    ),
  );
}
