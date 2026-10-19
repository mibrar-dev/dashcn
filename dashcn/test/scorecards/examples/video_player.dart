// Canonical scorecard example for `video_player`: first docs preview.
import 'package:flutter/widgets.dart';

import 'package:dashcn/src/components/video_player/preview.dart';

/// Minimal example pumped by the scorecard harness.
Widget scorecardExample(BuildContext context) =>
    videoPlayerPreviews[0].builder(context);
