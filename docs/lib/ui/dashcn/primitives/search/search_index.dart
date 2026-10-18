// Ranked-search index with a character-bigram prefilter.
//
// Pure Dart: no Flutter imports. The `search_bar` component and the
// `command` command palette both rank through this file (plus
// `fuzzy_match.dart` and `fuzzy_typo.dart`) instead of duplicating the
// algorithm.

import 'fuzzy_match.dart';
import 'fuzzy_typo.dart';

/// One ranked row: the [index] into the input list plus its [match].
class FuzzyRankedItem {
  /// Creates a ranked row.
  const FuzzyRankedItem({required this.index, required this.match});

  /// Position of the label in the input list.
  final int index;

  /// The winning match for that label.
  final FuzzyMatch match;
}

/// Ranks [labels] for [query]: tiers 1-4 first; the typo tier runs only when
/// no label matches tiers 1-4. Ordered by score, then label length, then
/// the input order. An empty query matches nothing.
List<FuzzyRankedItem> fuzzyRankResults(String query, List<String> labels) {
  return FuzzySearchIndex(labels).rank(query);
}

/// A reusable ranked-search index with a character-bigram prefilter.
///
/// The bigram table is built only for lists over [prefilterThreshold]
/// items; smaller lists are scanned directly so short-list recall is exact.
/// The table maps each lowercase character bigram to the label indices that
/// contain it. Tiers 1-3 scan every label (they are cheap string scans);
/// the fuzzy DP and the typo fallback run only on the union of the query
/// bigrams' posting lists, which preserves typo recall because a 1-2 edit
/// typo keeps most of the token's bigrams.
class FuzzySearchIndex {
  /// Builds an index over [labels] (kept by reference, not copied).
  FuzzySearchIndex(this.labels) {
    if (labels.length > prefilterThreshold) {
      _bigrams = _buildBigrams(labels);
    }
  }

  /// Lists longer than this get a bigram prefilter table.
  static const int prefilterThreshold = 2000;

  /// The indexed labels, by reference.
  final List<String> labels;

  Map<String, List<int>>? _bigrams;

  /// Whether the bigram prefilter table was built.
  bool get usesPrefilter => _bigrams != null;

  static Map<String, List<int>> _buildBigrams(List<String> labels) {
    final Map<String, List<int>> table = <String, List<int>>{};
    for (int i = 0; i < labels.length; i++) {
      final String lower = labels[i].toLowerCase();
      for (int j = 0; j + 1 < lower.length; j++) {
        final String bigram = lower.substring(j, j + 2);
        (table[bigram] ??= <int>[]).add(i);
      }
    }
    return table;
  }

  /// Candidate label indices whose bigrams overlap [query]'s (diagnostic).
  List<int> prefilterCandidates(String query) {
    final Map<String, List<int>>? table = _bigrams;
    final String q = query.toLowerCase();
    if (table == null || q.length < 2) {
      return List<int>.generate(labels.length, (i) => i);
    }
    final Set<int> out = <int>{};
    for (int j = 0; j + 1 < q.length; j++) {
      final List<int>? posting = table[q.substring(j, j + 2)];
      if (posting != null) {
        out.addAll(posting);
      }
    }
    final List<int> sorted = out.toList()..sort();
    return sorted;
  }

  /// Ranks [labels] for [query]; see [fuzzyRankResults].
  List<FuzzyRankedItem> rank(String query) {
    if (query.isEmpty) {
      return const <FuzzyRankedItem>[];
    }
    final String q = query.toLowerCase();
    final List<FuzzyRankedItem> hits = <FuzzyRankedItem>[];
    final bool prefiltered = _bigrams != null;
    final Set<int> fuzzySet = prefiltered
        ? prefilterCandidates(query).toSet()
        : const <int>{};
    for (int i = 0; i < labels.length; i++) {
      final String label = labels[i];
      if (label.isEmpty) {
        continue;
      }
      final String lower = label.toLowerCase();
      // Tiers 1-3 scan every label; the prefilter gates only the fuzzy DP.
      final bool gated = prefiltered && !fuzzySet.contains(i);
      final FuzzyMatch? match = fuzzyMatchLowered(
        q,
        label,
        lower,
        skipFuzzy: gated,
      );
      if (match != null) {
        hits.add(FuzzyRankedItem(index: i, match: match));
      }
    }
    if (hits.isNotEmpty) {
      hits.sort(_compareLabels);
      return hits;
    }
    // Typo fallback: only when tiers 1-4 find nothing list-wide. With a
    // prefilter it scans the same bigram-union candidates (a 1-2 edit typo
    // keeps most of the token's bigrams, so recall is preserved).
    final Iterable<int> typoScope = prefiltered ? fuzzySet : _allIndices();
    for (final int i in typoScope) {
      final FuzzyMatch? match = fuzzyTypoMatch(query, labels[i]);
      if (match != null) {
        hits.add(FuzzyRankedItem(index: i, match: match));
      }
    }
    hits.sort(_compareLabels);
    return hits;
  }

  Iterable<int> _allIndices() sync* {
    for (int i = 0; i < labels.length; i++) {
      yield i;
    }
  }

  /// Score first, then shorter labels, then the stable input order.
  int _compareLabels(FuzzyRankedItem a, FuzzyRankedItem b) {
    if (a.match.score != b.match.score) {
      return b.match.score.compareTo(a.match.score);
    }
    final int lenA = labels[a.index].length;
    final int lenB = labels[b.index].length;
    if (lenA != lenB) {
      return lenA.compareTo(lenB);
    }
    return a.index.compareTo(b.index);
  }
}
