// Shared tiered fuzzy matcher for ranked search lists (tiers 1-4).
//
// Pure Dart: no Flutter imports, so the `search_bar` component and the
// `command` command palette both rank through this file (plus
// `fuzzy_typo.dart` and `search_index.dart`) instead of duplicating the
// algorithm.
//
// Tiers per item (best score wins):
//   1. exact match (case-insensitive equality),
//   2. prefix match (label starts with the query),
//   3. word-start / initials match (the query is a prefix of any word, or
//      its characters match the first letters of successive words in order),
//   4. fzf-style fuzzy subsequence scoring (query characters in order;
//      bonuses: word boundary +8, after a separator +9/+10, camelCase +7 and
//      a consecutive-run bonus; penalties: gap start -3, gap extension -1)
//      via a FuzzyMatchV2-style dynamic program.
// Tier 5 (typo tolerance) lives in `fuzzy_typo.dart`; list ranking in
// `search_index.dart`.
//
// Every hit carries the matched character indices for highlighting.

/// Which tier produced a [FuzzyMatch].
enum FuzzyMatchTier {
  /// Case-insensitive equality with the whole label.
  exact,

  /// The label starts with the query.
  prefix,

  /// The query starts a word inside the label, or matches word initials.
  wordStart,

  /// Ordered subsequence scored by the fzf-style dynamic program.
  fuzzy,

  /// A token within Damerau-Levenshtein distance of the query.
  typo,
}

/// One ranked hit: the score, the tier that won, and the label character
/// indices to highlight (ascending, suitable for building `TextSpan`s).
class FuzzyMatch {
  /// Creates a match result.
  const FuzzyMatch({
    required this.score,
    required this.tier,
    required this.indices,
  });

  /// Higher ranks first. Tier bases keep tiers ordered: exact 1,000,000,
  /// prefix 500,000, word-start 100,000+, fuzzy 10,000 + DP, typo ~1,000.
  final int score;

  /// The winning tier.
  final FuzzyMatchTier tier;

  /// Matched character positions in the original label, ascending.
  final List<int> indices;
}

/// Matches [query] against one [label]; null when nothing matches.
///
/// An empty query never matches here; callers show the unfiltered list.
/// With [skipFuzzy], only tiers 1-3 run (exact, prefix, word-start): the
/// bigram-prefiltered rank loop sets this for labels outside the query
/// bigrams' union, where the fuzzy DP is skipped as a prefilter tradeoff.
FuzzyMatch? fuzzyMatch(String query, String label, {bool skipFuzzy = false}) {
  if (query.isEmpty || label.isEmpty) {
    return null;
  }
  return _matchLowered(
    query.toLowerCase(),
    label,
    label.toLowerCase(),
    skipFuzzy,
  );
}

/// [fuzzyMatch] over pre-lowered forms, for hot rank loops.
///
/// [queryLower] must equal `query.toLowerCase()` and [labelLower] must equal
/// `label.toLowerCase()`; anything else is undefined behavior. Prefer
/// [fuzzyMatch] unless the loop already lowers both sides.
FuzzyMatch? fuzzyMatchLowered(
  String queryLower,
  String label,
  String labelLower, {
  bool skipFuzzy = false,
}) {
  if (queryLower.isEmpty || label.isEmpty) {
    return null;
  }
  return _matchLowered(queryLower, label, labelLower, skipFuzzy);
}

FuzzyMatch? _matchLowered(
  String q,
  String label,
  String lower,
  bool skipFuzzy,
) {
  final FuzzyMatch? cheap = _matchTiers13(q, label, lower);
  if (cheap != null || skipFuzzy) {
    return cheap;
  }
  return _matchFuzzy(q, label, lower);
}

/// Tiers 1-3 only: the cheap string scans the rank loop runs on every label
/// even when the bigram prefilter skips the fuzzy DP for it.
FuzzyMatch? _matchTiers13(String q, String label, String lower) {
  if (q == lower) {
    return FuzzyMatch(
      score: _exactScore,
      tier: FuzzyMatchTier.exact,
      indices: List<int>.generate(label.length, (i) => i),
    );
  }
  if (lower.startsWith(q)) {
    return FuzzyMatch(
      score: _prefixScore,
      tier: FuzzyMatchTier.prefix,
      indices: List<int>.generate(q.length, (i) => i),
    );
  }
  return _matchWordStart(q, lower);
}

const int _exactScore = 1000000;
const int _prefixScore = 500000;
const int _wordPrefixScore = 120000;
const int _initialsScore = 100000;
const int _fuzzyBase = 10000;

// Bonus/penalty constants from the spec.
const int _bonusWordBoundary = 8;
const int _bonusSeparatorStrong = 10;
const int _bonusSeparatorWeak = 9;
const int _bonusCamelCase = 7;
const int _bonusConsecutive = 5;
const int _penaltyGapStart = 3;
const int _penaltyGapExtension = 1;

/// Whether [code] (a UTF-16 code unit) separates search tokens.
///
/// Public so `fuzzy_typo.dart` tokenizes the same way without duplicating
/// the table.
bool isSearchSeparatorCode(int code) {
  return code == 0x20 || // space
      code == 0x5F || // _
      code == 0x2D || // -
      code == 0x2F || // /
      code == 0x5C || // \
      code == 0x2E || // .
      code == 0x3A || // :
      code == 0x3B || // ;
      code == 0x2C || // ,
      code == 0x28 || // (
      code == 0x29 || // )
      code == 0x5B || // [
      code == 0x5D || // ]
      code == 0x7B || // {
      code == 0x7D; // }
}

bool _isLower(int code) => code >= 0x61 && code <= 0x7A;
bool _isUpper(int code) => code >= 0x41 && code <= 0x5A;

/// Tier 3: a word prefix wins over initials; both beat fuzzy.
///
/// Allocation-free: the word scan walks separator positions inline and the
/// initials check runs twice (a boolean probe, then index collection only
/// on success) instead of building a starts list per label.
FuzzyMatch? _matchWordStart(String q, String lower) {
  final int n = lower.length;
  // Word-prefix scan (start 0 is the prefix tier, already handled).
  for (int i = 1; i < n; i++) {
    if (isSearchSeparatorCode(lower.codeUnitAt(i - 1)) &&
        i + q.length <= n &&
        lower.startsWith(q, i)) {
      return FuzzyMatch(
        score: _wordPrefixScore,
        tier: FuzzyMatchTier.wordStart,
        indices: List<int>.generate(q.length, (k) => i + k),
      );
    }
  }
  if (!_initialsHit(q, lower)) {
    return null;
  }
  final List<int> hits = <int>[];
  int qi = 0;
  if (lower.codeUnitAt(0) == q.codeUnitAt(0)) {
    hits.add(0);
    qi = 1;
  }
  for (int i = 1; i < n && qi < q.length; i++) {
    if (isSearchSeparatorCode(lower.codeUnitAt(i - 1)) &&
        lower.codeUnitAt(i) == q.codeUnitAt(qi)) {
      hits.add(i);
      qi++;
    }
  }
  return FuzzyMatch(
    score: _initialsScore,
    tier: FuzzyMatchTier.wordStart,
    indices: hits,
  );
}

/// Whether the query characters match successive word starts in order.
bool _initialsHit(String q, String lower) {
  if (lower.isEmpty || q.isEmpty) {
    return false;
  }
  int qi = 0;
  if (lower.codeUnitAt(0) == q.codeUnitAt(0)) {
    qi = 1;
    if (qi == q.length) {
      return true;
    }
  }
  for (int i = 1; i < lower.length && qi < q.length; i++) {
    if (isSearchSeparatorCode(lower.codeUnitAt(i - 1)) &&
        lower.codeUnitAt(i) == q.codeUnitAt(qi)) {
      qi++;
    }
  }
  return qi == q.length;
}

/// Per-position bonus of [label] at [index] (original case for camelCase).
int _bonusFor(String label, int index) {
  if (index == 0) {
    return _bonusWordBoundary;
  }
  final int prev = label.codeUnitAt(index - 1);
  final int curr = label.codeUnitAt(index);
  if (isSearchSeparatorCode(prev)) {
    // Slash-like separators score one less than blanks/underscores/dashes.
    if (prev == 0x2F || prev == 0x2E || prev == 0x3A) {
      return _bonusSeparatorWeak;
    }
    return _bonusSeparatorStrong;
  }
  if (_isLower(prev) && _isUpper(curr)) {
    return _bonusCamelCase;
  }
  return 0;
}

/// Necessary (not sufficient) subsequence check: every query code unit must
/// occur in the label. Two 64-bit bitsets over ASCII codes make this an
/// allocation-free O(m + n) scan that skips doomed DPs on the no-match path.
bool _mayContainSubsequence(String q, String lower) {
  int lo = 0;
  int hi = 0;
  bool foreign = false;
  for (int i = 0; i < lower.length; i++) {
    final int c = lower.codeUnitAt(i);
    if (c < 64) {
      lo |= 1 << c;
    } else if (c < 128) {
      hi |= 1 << (c - 64);
    } else {
      foreign = true;
    }
  }
  for (int i = 0; i < q.length; i++) {
    final int c = q.codeUnitAt(i);
    if (c < 64) {
      if ((lo & (1 << c)) == 0) {
        return false;
      }
    } else if (c < 128) {
      if ((hi & (1 << (c - 64))) == 0) {
        return false;
      }
    } else if (!foreign) {
      return false;
    }
  }
  return true;
}

/// Tier 4: FuzzyMatchV2-style dynamic program over the subsequence lattice.
///
/// `dp` holds the best score for matching `q[0..i]` ending exactly at
/// `lower[j]`; transitions charge a gap start (-3) plus extension (-1) per
/// skipped character and add the position bonus plus a consecutive-run bonus.
FuzzyMatch? _matchFuzzy(String q, String label, String lower) {
  final int m = q.length;
  final int n = lower.length;
  if (m > n || !_mayContainSubsequence(q, lower)) {
    return null;
  }
  final List<int> bonus = List<int>.generate(n, (j) => _bonusFor(label, j));
  const int negInf = -1 << 30;
  List<int> prev = List<int>.filled(n, negInf);
  // Backtrack: for row i, the previous match position of the winner at j.
  final List<List<int>> back = List<List<int>>.generate(
    m,
    (_) => List<int>.filled(n, -1),
  );
  for (int i = 0; i < m; i++) {
    final List<int> curr = List<int>.filled(n, negInf);
    // Running best of (prev[k] + k) for k <= j - 2, so gapped transitions
    // cost O(1): prev[k] - (j - k + 1) = (prev[k] + k) - j - 1.
    int bestVal = negInf;
    int bestK = -1;
    final int qc = q.codeUnitAt(i);
    for (int j = 0; j < n; j++) {
      if (i > 0 && j >= 2) {
        final int k = j - 2;
        if (prev[k] != negInf) {
          final int candidate = prev[k] + k;
          if (candidate > bestVal) {
            bestVal = candidate;
            bestK = k;
          }
        }
      }
      if (lower.codeUnitAt(j) != qc) {
        continue;
      }
      if (i == 0) {
        if (j == 0) {
          curr[j] = bonus[j];
          back[i][j] = -1;
        } else {
          curr[j] =
              bonus[j] - (_penaltyGapStart + (j - 1) * _penaltyGapExtension);
          back[i][j] = -2; // leading gap: no previous match.
        }
        continue;
      }
      int best = negInf;
      int bestPrev = -1;
      // Consecutive link: no gap penalty plus the run bonus.
      if (j > 0 && prev[j - 1] != negInf) {
        best = prev[j - 1] + _bonusConsecutive + bonus[j];
        bestPrev = j - 1;
      }
      // Gapped link through the running best (needs k <= j - 2).
      if (bestK != -1 && bestVal != negInf) {
        final int gapped = bestVal - j - 1 + bonus[j];
        if (gapped > best) {
          best = gapped;
          bestPrev = bestK;
        }
      }
      // A first-row equivalent for i > 0 cannot start here; every later row
      // needs a real predecessor, so j == 0 stays unreachable unless i == 0.
      curr[j] = best;
      back[i][j] = bestPrev;
    }
    prev = curr;
  }
  int end = -1;
  int bestScore = negInf;
  for (int j = 0; j < n; j++) {
    if (prev[j] > bestScore) {
      bestScore = prev[j];
      end = j;
    }
  }
  if (end == -1) {
    return null;
  }
  // Walk the backtrack chain to recover highlight indices.
  final List<int> reversed = <int>[];
  int row = m - 1;
  int col = end;
  while (row >= 0 && col >= 0) {
    reversed.add(col);
    col = back[row][col];
    row--;
  }
  if (reversed.length != m) {
    return null;
  }
  final List<int> indices = reversed.reversed.toList();
  return FuzzyMatch(
    score: _fuzzyBase + bestScore,
    tier: FuzzyMatchTier.fuzzy,
    indices: indices,
  );
}
