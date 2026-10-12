---
title: "Class: RetryStrategy"
description: "Computes exponential backoff delays with jitter."
---

```dart
/// Computes exponential backoff delays with jitter.
class RetryStrategy {
  /// Creates a retry strategy.
  RetryStrategy({this.maxAttempts = 3, this.baseDelay = const Duration(milliseconds: 300), this.maxDelay = const Duration(seconds: 5), this.jitter = 0.2});
  /// Maximum number of attempts.
  final int maxAttempts;
  /// Delay of the first attempt.
  final Duration baseDelay;
  /// Upper bound of the computed delay.
  final Duration maxDelay;
  /// Fraction of random jitter, 0..1.
  final double jitter;
  /// The delay before attempt [attempt] (0-based), capped at [maxDelay].
  Duration delayForAttempt(int attempt);
}
```
