// Unit tests for the shared `primitives/search` ranker.
//
// Covers the tier order (exact > prefix > word-start > fuzzy > typo),
// highlight indices, length-then-stable tiebreaks, typo edit budgets,
// the bigram prefilter threshold and the 10k-item perf budget.

import 'package:dashcn/src/primitives/search/fuzzy_match.dart';
import 'package:dashcn/src/primitives/search/fuzzy_typo.dart';
import 'package:dashcn/src/primitives/search/search_index.dart';
import 'package:flutter_test/flutter_test.dart';

/// Labels the lowercased characters at [indices] spell in [label].
String _spell(String label, List<int> indices) =>
    indices.map((i) => label[i].toLowerCase()).join();

void main() {
  group('tiers', () {
    test('exact beats prefix beats word-start beats fuzzy', () {
      final List<FuzzyRankedItem> ranked = fuzzyRankResults('set', <String>[
        'offset',
        'User Settings',
        'Settings',
        'asset',
      ]);
      expect(ranked.map((h) => h.index).toSet(), <int>{0, 1, 2, 3});
      expect(ranked.map((h) => h.match.tier), <FuzzyMatchTier>[
        FuzzyMatchTier.prefix,
        FuzzyMatchTier.wordStart,
        FuzzyMatchTier.fuzzy,
        FuzzyMatchTier.fuzzy,
      ]);
      expect(ranked[0].index, 2);
      expect(ranked[1].index, 1);
    });

    test('exact match wins outright', () {
      final FuzzyMatch? match = fuzzyMatch('Settings', 'settings');
      expect(match, isNotNull);
      expect(match!.tier, FuzzyMatchTier.exact);
      expect(match.score, greaterThan(500000));
      expect(match.indices, List<int>.generate(8, (i) => i));
    });

    test('word prefix outranks initials outranks fuzzy', () {
      final FuzzyMatch? word = fuzzyMatch('set', 'User Settings');
      final FuzzyMatch? initials = fuzzyMatch('us', 'Up Settings');
      final FuzzyMatch? fuzzy = fuzzyMatch('stg', 'Settings');
      expect(word!.tier, FuzzyMatchTier.wordStart);
      expect(initials!.tier, FuzzyMatchTier.wordStart);
      expect(fuzzy!.tier, FuzzyMatchTier.fuzzy);
      expect(word.score, greaterThan(initials.score));
      expect(initials.score, greaterThan(fuzzy.score));
      expect(word.indices, <int>[5, 6, 7]);
      expect(_spell('Up Settings', initials.indices), 'us');
    });

    test('camelCase and separator bonuses apply', () {
      final FuzzyMatch? camel = fuzzyMatch('fb', 'fooBar');
      expect(camel, isNotNull);
      expect(camel!.tier, FuzzyMatchTier.fuzzy);
      expect(camel.indices, <int>[0, 3]);
      final FuzzyMatch? sep = fuzzyMatch('fb', 'foo-bar');
      expect(sep, isNotNull);
      // After a strong separator (+10) beats the camelCase link (+7).
      expect(sep!.score, greaterThan(camel.score));
    });

    test('typo tier runs only when tiers 1-4 find nothing', () {
      // 'apxle' is not a subsequence of 'Apple', so fuzzy finds nothing and
      // the 1-edit typo fallback answers.
      final List<FuzzyRankedItem> ranked = fuzzyRankResults('apxle', <String>[
        'Apple',
        'Application',
        'Banana',
      ]);
      expect(ranked.map((h) => h.index), <int>[0]);
      expect(ranked.single.match.tier, FuzzyMatchTier.typo);
      // A fuzzy hit suppresses the typo tier list-wide.
      final List<FuzzyRankedItem> fuzzy = fuzzyRankResults('aple', <String>[
        'Apple',
        'Banana',
      ]);
      expect(fuzzy.single.match.tier, FuzzyMatchTier.fuzzy);
    });

    test('empty query matches nothing; empty label never matches', () {
      expect(fuzzyRankResults('', <String>['a']), isEmpty);
      expect(fuzzyMatch('', 'Apple'), isNull);
      expect(fuzzyMatch('a', ''), isNull);
    });
  });

  group('indices', () {
    test('prefix and exact indices are the matched range', () {
      expect(fuzzyMatch('set', 'Settings')!.indices, <int>[0, 1, 2]);
    });

    test('fuzzy indices spell the query in order', () {
      const String label = 'User Settings Panel';
      const String query = 'setings';
      final FuzzyMatch? match = fuzzyMatch(query, label);
      expect(match, isNotNull);
      expect(_spell(label, match!.indices), query);
      // Ascending with no duplicates.
      expect(match.indices.toSet().length, query.length);
      for (int i = 1; i < match.indices.length; i++) {
        expect(match.indices[i], greaterThan(match.indices[i - 1]));
      }
    });
  });

  group('ordering', () {
    test('ties break by label length, then stable order', () {
      final List<FuzzyRankedItem> ranked = fuzzyRankResults('set', <String>[
        'Asset tag',
        'Reset!',
        'Settings',
      ]);
      // 'Settings' is the only prefix hit and ranks first despite being
      // longer; the fuzzy ties split by length, then input order.
      expect(ranked.first.index, 2);
      final List<String> labels = <String>['aa set xx', 'bb set yy'];
      final List<FuzzyRankedItem> ties = fuzzyRankResults('set', labels);
      expect(ties.map((h) => h.index), <int>[0, 1]);
    });
  });

  group('typo budgets', () {
    test('3-5 char tokens allow 1 edit, 6+ allow 2', () {
      // 'apple' (5 chars): 1 edit hits, 2 edits miss.
      expect(fuzzyTypoMatch('apxle', 'apple')!.tier, FuzzyMatchTier.typo);
      expect(fuzzyTypoMatch('axyle', 'apple'), isNull);
      // 'application' (11 chars): 2 edits hit, 3 edits miss.
      expect(fuzzyTypoMatch('apxlicaxion', 'the application grows'), isNotNull);
      expect(fuzzyTypoMatch('axylzcaxion', 'application'), isNull);
    });

    test('tokens shorter than 3 chars never typo-match', () {
      expect(fuzzyTypoMatch('ax', 'an ax to grind'), isNull);
    });

    test('an exact token hit is not a typo', () {
      expect(fuzzyTypoMatch('apple', 'apple'), isNull);
    });

    test('damerau distance counts a transposition as one edit', () {
      expect(damerauLevenshtein('abc', 'acb', 2), 1);
      expect(damerauLevenshtein('kitten', 'sitting', 3), 3);
      expect(damerauLevenshtein('abc', 'xyz', 1), greaterThan(1));
    });
  });

  group('prefilter', () {
    test('builds the bigram table only over 2000 items', () {
      expect(
        FuzzySearchIndex(List<String>.filled(2000, 'a')).usesPrefilter,
        isFalse,
      );
      expect(
        FuzzySearchIndex(List<String>.filled(2001, 'a')).usesPrefilter,
        isTrue,
      );
    });

    test('prefiltered ranking keeps the top hit', () {
      final List<String> labels = List<String>.generate(
        2500,
        (i) => 'item number $i value',
      );
      labels[1234] = 'special command palette entry';
      final FuzzySearchIndex index = FuzzySearchIndex(labels);
      expect(index.usesPrefilter, isTrue);
      final List<FuzzyRankedItem> ranked = index.rank('palette');
      expect(ranked, isNotEmpty);
      expect(ranked.first.index, 1234);
    });

    test('10k mixed items rank under 16ms with the right top hit', () {
      const List<String> verbs = <String>[
        'Calendar',
        'Search Emoji',
        'Launch',
        'Profile',
        'Mail',
        'Settings',
        'Create Project',
        'Delete Account',
        'Export Data',
        'Import Data',
      ];
      final List<String> labels = List<String>.generate(
        10000,
        (i) => '${verbs[i % verbs.length]} ${i ~/ verbs.length}',
      );
      final FuzzySearchIndex index = FuzzySearchIndex(labels);
      expect(index.usesPrefilter, isTrue);
      index.rank('warmup');
      // Best of five: the first runs still warm up the JIT and the GC.
      for (final String query in <String>['set', 'exp', 'crea']) {
        int best = 1 << 62;
        int hits = 0;
        for (int k = 0; k < 5; k++) {
          final Stopwatch sw = Stopwatch()..start();
          final List<FuzzyRankedItem> ranked = index.rank(query);
          sw.stop();
          hits = ranked.length;
          if (sw.elapsedMicroseconds < best) {
            best = sw.elapsedMicroseconds;
          }
        }
        expect(hits, greaterThan(0));
        expect(best, lessThan(16000), reason: 'query "$query" took ${best}us');
      }
      expect(
        labels[index.rank('set').first.index].startsWith('Settings'),
        isTrue,
      );
      expect(
        labels[index.rank('exp').first.index].startsWith('Export'),
        isTrue,
      );
    });
  });
}
