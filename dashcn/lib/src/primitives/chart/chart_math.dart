// Ring-buffer window and scale helpers for the `chart` component.
//
// Widgets-only: `dart:math` only. The component owns the public model
// (`ChartSeries`, `ChartController`); this primitive owns the windowing
// math so streaming stays O(1) and testable without widgets.

import 'dart:math' as math;

/// Fixed-capacity window: `add` appends and drops the oldest entries past
/// [maxPoints]. When [maxPoints] <= 0 the window is unbounded.
class ChartRingBuffer<T> {
  /// Creates a window with the given capacity.
  ChartRingBuffer({this.maxPoints = 0, List<T>? initial});

  /// Maximum retained points; <= 0 means unbounded.
  final int maxPoints;

  final List<T> _items = <T>[];

  /// Creates a window from [items], keeping only the trailing window.
  factory ChartRingBuffer.from(List<T> items, {required int maxPoints}) {
    final buffer = ChartRingBuffer<T>(maxPoints: maxPoints);
    buffer.addAll(items);
    return buffer;
  }

  /// Current items, in insertion order.
  List<T> get items => List<T>.unmodifiable(_items);

  /// Current length.
  int get length => _items.length;

  /// Appends one item, trimming the head past the capacity.
  void add(T item) {
    _items.add(item);
    _trim();
  }

  /// Appends many items, trimming the head past the capacity.
  void addAll(Iterable<T> items) {
    _items.addAll(items);
    _trim();
  }

  /// Clears the window.
  void clear() => _items.clear();

  void _trim() {
    if (maxPoints <= 0) {
      return;
    }
    while (_items.length > maxPoints) {
      _items.removeAt(0);
    }
  }
}

/// Trims [values] to the trailing [maxPoints] entries (no-op when <= 0).
List<double> chartWindow(List<double> values, int maxPoints) {
  if (maxPoints <= 0 || values.length <= maxPoints) {
    return List<double>.from(values);
  }
  return values.sublist(values.length - maxPoints);
}

/// Minimum and maximum of [values]; empty input yields (0, 1).
({double min, double max}) chartExtent(Iterable<double> values) {
  var min = double.infinity;
  var max = double.negativeInfinity;
  var empty = true;
  for (final v in values) {
    if (v.isNaN) {
      continue;
    }
    empty = false;
    if (v < min) {
      min = v;
    }
    if (v > max) {
      max = v;
    }
  }
  if (empty) {
    return (min: 0, max: 1);
  }
  if (min == max) {
    final double pad = min == 0 ? 1 : min.abs() * 0.1;
    return (min: min - pad, max: max + pad);
  }
  return (min: min, max: max);
}

/// Rounds [min]/[max] out to at most [count] human-friendly ticks.
List<double> chartNiceTicks(double min, double max, int count) {
  final int safe = math.max(2, count);
  if (!(min < max) || min.isNaN || max.isNaN) {
    return <double>[min, max];
  }
  final double span = max - min;
  final double raw = span / (safe - 1);
  final double mag = math
      .pow(10, (math.log(raw) / math.ln10).floor())
      .toDouble();
  final double norm = raw / mag;
  final double step =
      (norm >= 5
          ? 5
          : norm >= 2
          ? 2
          : 1) *
      mag;
  final double start = (min / step).floor() * step;
  final List<double> ticks = <double>[];
  var v = start;
  var guard = 0;
  while (v <= max + step * 0.5 && guard < 32) {
    if (v >= min - step * 0.5) {
      ticks.add(double.parse(v.toStringAsFixed(6)));
    }
    v += step;
    guard++;
  }
  if (ticks.length < 2) {
    return <double>[min, max];
  }
  return ticks;
}

/// Lerps two value lists element-wise; missing entries hold their endpoint.
List<double> chartLerpValues(List<double> a, List<double> b, double t) {
  final int n = math.max(a.length, b.length);
  if (n == 0) {
    return const <double>[];
  }
  return List<double>.generate(n, (i) {
    final double va = i < a.length ? a[i] : (b.isNotEmpty ? b.last : 0);
    final double vb = i < b.length ? b[i] : (a.isNotEmpty ? a.last : 0);
    return va + (vb - va) * t;
  });
}

/// Fraction of [index]/[total] revealed at entrance [progress] (0..1).
double chartRevealFraction(int index, int total, double progress) {
  if (total <= 1) {
    return 1;
  }
  final double pos = progress * total;
  return (pos - index).clamp(0.0, 1.0);
}
