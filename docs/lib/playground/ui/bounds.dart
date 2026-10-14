// Dependent slider ranges for the playground panel.
//
// A slider target may track the live values of sibling controls instead of
// its static spec bounds: the `slider` component's `value` tracks the live
// `min`/`max`, and `pagination`'s `page` clamps to the live `totalPages`
// (P9-2a open questions).
//
// The table is data, not per-component code: [PlaygroundPanel] accepts a
// `boundedBy` map (`target -> source names`) defaulting to
// [kDefaultBoundedBy]. A two-source entry reads a live `[min, max]` range
// from its siblings; a one-source entry clamps the target below the live
// source while keeping the target's own static lower bound. Entries whose
// controls are missing or non-numeric are ignored, so the same table is
// safe for every component.
//
// Future generator contract: if `gen_docs_data` ever emits a per-control
// `boundedBy` member on `ControlSpec`, prefer it over this table (the
// generated `docs_controls.dart` carries no such member today, so the table
// is the only source).

import '../../generated/docs_controls.dart';
import '../values.dart';

/// Default dependent ranges: target control -> live source controls.
///
/// `value: [min, max]` covers the `slider` component; `page: [totalPages]`
/// covers `pagination`. Both apply only when the named siblings exist.
const Map<String, List<String>> kDefaultBoundedBy = <String, List<String>>{
  'value': <String>['min', 'max'],
  'page': <String>['totalPages'],
};

/// Live `(min, max)` for a slider [control], or null when unbounded.
///
/// Returns the live range when [boundedBy] (default [kDefaultBoundedBy])
/// maps [control] to two numeric siblings present in [spec]; otherwise the
/// control's own static bounds (which may be null on either side).
({double min, double max})? sliderBounds(
  ComponentControls spec,
  PlaygroundValues values,
  ControlSpec control, {
  Map<String, List<String>>? boundedBy,
}) {
  final Map<String, List<String>> table = boundedBy ?? kDefaultBoundedBy;
  final List<String>? sources = table[control.name];
  if (sources != null && sources.length == 2) {
    final double? lo = _liveNumber(values, sources[0]);
    final double? hi = _liveNumber(values, sources[1]);
    if (lo != null && hi != null) {
      return (min: lo <= hi ? lo : hi, max: lo <= hi ? hi : lo);
    }
  }
  if (control.min == null && control.max == null) {
    return null;
  }
  return (
    min: control.min ?? control.max ?? 0,
    max: control.max ?? control.min ?? 0,
  );
}

/// Clamps every bounded target into its live range.
///
/// Also repairs inverted live ranges (`min > max`): the just-changed bound
/// wins and the other follows it, so the previewed widget (whose constructor
/// requires `min <= max`) never throws. Returns the names that changed
/// (targets and any repaired bounds).
List<String> clampBoundedValues(
  ComponentControls spec,
  PlaygroundValues values, {
  String? changed,
  Map<String, List<String>>? boundedBy,
}) {
  final Map<String, List<String>> table = boundedBy ?? kDefaultBoundedBy;
  final List<String> touched = <String>[];
  for (final MapEntry<String, List<String>> entry in table.entries) {
    final ControlSpec? target = _editableSlider(spec, entry.key);
    if (target == null) {
      continue;
    }
    if (entry.value.length == 2) {
      final ControlSpec? loSpec = _editableSlider(spec, entry.value[0]);
      final ControlSpec? hiSpec = _editableSlider(spec, entry.value[1]);
      if (loSpec == null || hiSpec == null) {
        continue;
      }
      double? lo = _liveNumber(values, loSpec.name);
      double? hi = _liveNumber(values, hiSpec.name);
      if (lo == null || hi == null) {
        continue;
      }
      if (lo > hi) {
        if (changed == loSpec.name) {
          hi = lo;
          _writeNumber(values, hiSpec, hi);
          touched.add(hiSpec.name);
        } else if (changed == hiSpec.name) {
          lo = hi;
          _writeNumber(values, loSpec, lo);
          touched.add(loSpec.name);
        } else {
          // Seeded state (query, defaults): order the pair, keeping the
          // range instead of collapsing it.
          final double orderedLo = lo <= hi ? lo : hi;
          final double orderedHi = lo <= hi ? hi : lo;
          lo = orderedLo;
          hi = orderedHi;
          _writeNumber(values, loSpec, lo);
          _writeNumber(values, hiSpec, hi);
          touched.add(loSpec.name);
          touched.add(hiSpec.name);
        }
      }
      // The kit slider asserts `max > min`: widen a collapsed live range by
      // one step of the upper control so the preview never throws.
      if (lo >= hi) {
        final double step = _positiveStep(hiSpec);
        hi = lo + step;
        _writeNumber(values, hiSpec, hi);
        touched.add(hiSpec.name);
      }
      if (_clampTarget(values, target, lo, hi)) {
        touched.add(target.name);
      }
    } else if (entry.value.length == 1) {
      final ControlSpec? hiSpec = _editableSlider(spec, entry.value[0]);
      final double? hi = hiSpec == null
          ? null
          : _liveNumber(values, hiSpec.name);
      if (hiSpec == null || hi == null) {
        continue;
      }
      final double lo = target.min ?? 0;
      if (_clampTarget(values, target, lo, hi)) {
        touched.add(target.name);
      }
    }
  }
  return touched;
}

/// The editable slider control named [name], or null.
ControlSpec? _editableSlider(ComponentControls spec, String name) {
  for (final ControlSpec control in spec.controls) {
    if (control.name == name &&
        control.isEditable &&
        control.kind == ControlKind.slider) {
      return control;
    }
  }
  return null;
}

/// The live numeric value of [name], or null when absent/non-numeric.
double? _liveNumber(PlaygroundValues values, String name) {
  final Object? raw = values.valueOf(name);
  if (raw is num) {
    return raw.toDouble();
  }
  return null;
}

/// Writes [value] back with the control's int/double shape.
void _writeNumber(PlaygroundValues values, ControlSpec control, double value) {
  values.set(control.name, control.isInt ? value.round() : value);
}

/// One display step of [control] (the widening unit for collapsed ranges).
double _positiveStep(ControlSpec control) {
  final double? step = control.step;
  if (step != null && step > 0) {
    return step;
  }
  return control.isInt ? 1 : 0.1;
}

/// Clamps [target] into `[lo, hi]`; true when the value changed.
bool _clampTarget(
  PlaygroundValues values,
  ControlSpec target,
  double lo,
  double hi,
) {
  final Object? raw = values.valueOf(target.name);
  if (raw is! num) {
    return false;
  }
  final double current = raw.toDouble();
  final double clamped = current.clamp(lo, hi).toDouble();
  if (clamped == current) {
    return false;
  }
  _writeNumber(values, target, clamped);
  return true;
}
