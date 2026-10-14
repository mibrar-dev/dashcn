// Canonical scorecard example for `file_diff_viewer`: first docs preview.
import 'package:flutter/widgets.dart';

import 'package:dashcn/src/components/file_diff_viewer/preview.dart';

/// Minimal example pumped by the scorecard harness.
Widget scorecardExample(BuildContext context) =>
    fileDiffViewerPreviews[0].builder(context);
