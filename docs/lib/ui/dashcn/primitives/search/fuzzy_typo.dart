// Tier-5 typo tolerance for ranked search lists.
//
// Pure Dart: no Flutter imports. Used by `search_index.dart` (and through it
// by the `search_bar` component and the `command` command palette) as the
// last-resort tier when tiers 1-4 find nothing.
//
// Tokens shorter than 3 characters never typo-match; tokens of 3-5
// characters allow 1 edit, tokens of 6+ allow 2.

import 'fuzzy_match.dart';

/// Base score of typo hits: below every tier 1-4 score by construction.
const int _typoBase = 1000;

/// Bounded Damerau-Levenshtein (optimal string alignment) with an early exit
/// when the length difference already exceeds [maxDist].
int damerauLevenshtein(String a, String b, int maxDist) {
  if (a == b) {
    return 0;
  }
  final int m = a.length;
  final int n = b.length;
  if ((m - n).abs() > maxDist) {
    return maxDist + 1;
  }
  if (m == 0) {
    return n;
  }
  if (n == 0) {
    return m;
  }
  List<int> prevPrev = List<int>.filled(n + 1, 0);
  List<int> prev = List<int>.generate(n + 1, (j) => j);
  for (int i = 1; i <= m; i++) {
    final List<int> curr = List<int>.filled(n + 1, 0);
    curr[0] = i;
    int rowMin = curr[0];
    for (int j = 1; j <= n; j++) {
      final int cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      int value = prev[j] + 1; // deletion
      final int insertion = curr[j - 1] + 1;
      if (insertion < value) {
        value = insertion;
      }
      final int substitution = prev[j - 1] + cost;
      if (substitution < value) {
        value = substitution;
      }
      // Adjacent transposition.
      if (i > 1 &&
          j > 1 &&
          a.codeUnitAt(i - 1) == b.codeUnitAt(j - 2) &&
          a.codeUnitAt(i - 2) == b.codeUnitAt(j - 1)) {
        final int swap = prevPrev[j - 2] + 1;
        if (swap < value) {
          value = swap;
        }
      }
      curr[j] = value;
      if (value < rowMin) {
        rowMin = value;
      }
    }
    if (rowMin > maxDist) {
      return maxDist + 1;
    }
    prevPrev = prev;
    prev = curr;
  }
  return prev[n];
}

/// Tier 5: typo tolerance over the label's tokens. Returns the best token
/// hit, or null. Tokens shorter than 3 characters never typo-match; tokens
/// of 3-5 characters allow 1 edit, tokens of 6+ allow 2.
FuzzyMatch? fuzzyTypoMatch(String query, String label) {
  final String q = query.toLowerCase();
  if (q.isEmpty || label.isEmpty) {
    return null;
  }
  FuzzyMatch? best;
  for (final _Token token in _tokensOf(label)) {
    final int len = token.text.length;
    if (len < 3) {
      continue;
    }
    final int maxDist = len >= 6 ? 2 : 1;
    final int dist = damerauLevenshtein(q, token.text.toLowerCase(), maxDist);
    if (dist > maxDist || dist == 0) {
      // 0 means an exact token hit, which tiers 1-4 already scored higher.
      continue;
    }
    final int score = _typoBase - dist * 100;
    if (best == null || score > best.score) {
      best = FuzzyMatch(
        score: score,
        tier: FuzzyMatchTier.typo,
        indices: List<int>.generate(len, (i) => token.start + i),
      );
    }
  }
  return best;
}

class _Token {
  const _Token(this.text, this.start);
  final String text;
  final int start;
}

Iterable<_Token> _tokensOf(String label) sync* {
  int i = 0;
  while (i < label.length) {
    // Skip separators.
    while (i < label.length && isSearchSeparatorCode(label.codeUnitAt(i))) {
      i++;
    }
    if (i >= label.length) {
      break;
    }
    final int start = i;
    while (i < label.length && !isSearchSeparatorCode(label.codeUnitAt(i))) {
      i++;
    }
    yield _Token(label.substring(start, i), start);
  }
}
