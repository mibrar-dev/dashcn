// Named examples for the `tracker` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'tracker.dart';

/// All four levels.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 320,
    child: Tracker(
      semanticLabel: docsSample(context, 'Activity tracker'),
      data: <TrackerData>[
        TrackerData(
          tooltip: Text(docsSample(context, 'Healthy')),
          level: TrackerLevel.fine,
        ),
        TrackerData(
          tooltip: Text(docsSample(context, 'Degraded')),
          level: TrackerLevel.warning,
        ),
        TrackerData(
          tooltip: Text(docsSample(context, 'Down')),
          level: TrackerLevel.critical,
        ),
        TrackerData(
          tooltip: Text(docsSample(context, 'No data')),
          level: TrackerLevel.unknown,
        ),
        TrackerData(
          tooltip: Text(docsSample(context, 'Healthy')),
          level: TrackerLevel.fine,
        ),
        TrackerData(
          tooltip: Text(docsSample(context, 'Healthy')),
          level: TrackerLevel.fine,
        ),
      ],
    ),
  );
}

/// Taller segments with a wider gap through the widget leg.
Widget _customSize(BuildContext context) {
  return SizedBox(
    width: 320,
    child: Tracker(
      theme: TrackerTheme(itemHeight: 24, gap: 4, radius: 4),
      data: <TrackerData>[
        TrackerData(tooltip: Text('One'), level: TrackerLevel.fine),
        TrackerData(tooltip: Text('Two'), level: TrackerLevel.critical),
        TrackerData(
          tooltip: Text(docsSample(context, 'Three')),
          level: TrackerLevel.warning,
        ),
      ],
    ),
  );
}

/// Fine segments tinted with the primary token through a scoped theme.
Widget _themed(BuildContext context) {
  return SizedBox(
    width: 320,
    child: ComponentTheme<TrackerTheme>(
      data: TrackerTheme(
        fine: ThemedColor.ref(ColorRef.primary),
        itemHeight: 16,
      ),
      child: Tracker(
        data: <TrackerData>[
          TrackerData(tooltip: Text('One'), level: TrackerLevel.fine),
          TrackerData(tooltip: Text('Two'), level: TrackerLevel.fine),
          TrackerData(
            tooltip: Text(docsSample(context, 'Three')),
            level: TrackerLevel.fine,
          ),
        ],
      ),
    ),
  );
}

/// Named docs examples for `tracker`; the first entry is the default.
List<ComponentPreview> get trackerPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Custom size'), _customSize),
  ComponentPreview(docsSample(null, 'Themed'), _themed),
];
