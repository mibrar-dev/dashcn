// The video frame stage: background, poster/content, loading, error,
// centre play button and captions overlay.
//
// Split from `video_player.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// The video frame contents (everything under the control bar).
class VideoPlayerStage extends StatelessWidget {
  /// Creates a stage.
  const VideoPlayerStage({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    required this.showPoster,
    this.poster,
    this.content,
    this.captions,
    this.showControls = true,
    this.posterBuilder,
    this.playButtonBuilder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  /// Playback controller.
  final VideoPlaybackController controller;

  /// Resolved theme.
  final VideoPlayerTheme style;

  /// Foreground colour.
  final Color fg;

  /// Whether the poster shows instead of [content].
  final bool showPoster;

  /// Still shown before first play (or when there is no [content]).
  final Widget? poster;

  /// The video frame (the docs adapter plugs the plugin texture here).
  final Widget? content;

  /// Caption/label overlay above the control bar.
  final Widget? captions;

  /// Whether the control bar is shown (offsets the captions overlay).
  final bool showControls;

  /// Overrides the poster/frame area.
  final VideoPartBuilder? posterBuilder;

  /// Overrides the centre play button.
  final VideoPartBuilder? playButtonBuilder;

  /// Overrides the loading indicator.
  final VideoPartBuilder? loadingBuilder;

  /// Builds the error overlay; receives the controller error.
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    final VideoPlaybackController c = controller;
    final ThemeColors colors = Theme.of(context).colors;
    final Widget? posterOverride = posterBuilder?.call(context, c);
    final Widget? frameContent =
        posterOverride ?? (showPoster ? poster : content);
    final Widget? loadingOverride = c.isBuffering
        ? loadingBuilder?.call(context, c) ??
              Icon(LucideIcons.loaderCircle, size: 32, color: fg)
        : null;
    final Widget? playOverride =
        (!c.isPlaying && c.error == null && !c.isBuffering)
        ? playButtonBuilder?.call(context, c) ??
              videoPlayButton(context, style, fg, c, big: true)
        : null;
    final Widget? errorOverride = c.error != null
        ? errorBuilder?.call(context, c.error!) ??
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    ComponentLocalizations.of(context).mediaPlaybackFailed,
                    style: TextStyle(color: fg, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: c.play,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(
                          Theme.of(context).radiusSm,
                        ),
                      ),
                      child: Text(
                        ComponentLocalizations.of(context).errorActionRetry,
                        style: TextStyle(color: fg, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              )
        : null;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ColoredBox(
          color: style.background?.resolve(colors) ?? const Color(0xFF000000),
        ),
        frameContent ?? const SizedBox.shrink(),
        if (loadingOverride != null) Center(child: loadingOverride),
        if (errorOverride != null) Center(child: errorOverride),
        if (playOverride != null) Center(child: playOverride),
        _captionOverlay(context),
      ],
    );
  }

  Widget _captionOverlay(BuildContext context) {
    final VideoPlaybackController c = controller;
    // Single source of truth is the captions toggle; [VideoPlayer] seeds
    // owned (uncontrolled) fakes from `initialCaptionsEnabled`.
    if (!c.areCaptionsEnabled) {
      return const SizedBox.shrink();
    }
    String? cueText;
    for (final VideoCaptionCue cue in c.cues) {
      if (cue.isActive(c.position)) {
        cueText = cue.text;
        break;
      }
    }
    final Widget? captionWidget = cueText != null
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xCC000000),
              borderRadius: BorderRadius.circular(Theme.of(context).radiusSm),
            ),
            child: Text(
              cueText,
              style:
                  style.captionsTextStyle ?? TextStyle(color: fg, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          )
        : captions;

    if (captionWidget == null) return const SizedBox.shrink();

    return Positioned(
      left: 12,
      right: 12,
      bottom: showControls ? 64 : 12,
      child: Center(
        child: DefaultTextStyle(
          style: style.captionsTextStyle ?? TextStyle(color: fg, fontSize: 13),
          textAlign: TextAlign.center,
          child: captionWidget,
        ),
      ),
    );
  }
}
