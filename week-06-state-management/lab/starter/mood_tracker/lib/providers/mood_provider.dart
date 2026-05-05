import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mood_entry.dart';

// =============================================================================
//  1: Implement the MoodNotifier class
//
// Create a class that extends StateNotifier<List<MoodEntry>>.
//
// The constructor should initialize with sample data so you can see entries
// in the UI right away. Create 2-3 sample MoodEntry objects.
//
// Then implement three methods:
//   - addMood(int score, String? note) — creates a new MoodEntry and adds
//     it to the beginning of the list using immutable state update:
//       state = [newEntry, ...state];
//
//   - deleteMood(String id) — removes the entry with the given id:
//       state = state.where((e) => e.id != id).toList();
//
//   - updateMood(String id, int score, String? note) — finds the entry by id
//     and replaces it using copyWith:
//       state = state.map((e) => e.id == id ? e.copyWith(...) : e).toList();
//
// Hint: Remember that StateNotifier requires IMMUTABLE state updates.
// You must reassign `state`, not mutate the existing list.
// =============================================================================

//  1: Uncomment and complete the MoodNotifier class below:
//
class MoodNotifier extends StateNotifier<List<MoodEntry>> {
  MoodNotifier()
    : super([
        MoodEntry(
          score: 3,
          note: "Feeling great!",
          createdAt: DateTime.now().subtract(Duration(hours: 2)),
        ),
        MoodEntry(
          score: 2,
          note: "A bit tired",
          createdAt: DateTime.now().subtract(Duration(hours: 5)),
        ),
        MoodEntry(
          score: 4,
          note: "Productive day",
          createdAt: DateTime.now().subtract(Duration(days: 1)),
        ),
      ]);

  void addMood(int score, String? note) {
    final newEntry = MoodEntry(
      score: score,
      note: note,
      createdAt: DateTime.now(),
    );
    state = [newEntry, ...state];
  }

  void deleteMood(String id) {
    state = state.where((e) => e.id != id).toList();
  }

  void updateMood(String id, int score, String? note) {
    state = state
        .map((e) => e.id == id ? e.copyWith(score: score, note: note) : e)
        .toList();
  }
}

// =============================================================================
//  2: Define the providers
//
// Create two providers:
//
// 1. moodProvider — a StateNotifierProvider that exposes MoodNotifier:
//      final moodProvider = StateNotifierProvider<MoodNotifier, List<MoodEntry>>((ref) {
//        return MoodNotifier();
//      });
//
// 2. moodStatsProvider — a computed Provider that derives statistics from
//    the mood list. It should return a Map<String, dynamic> with keys:
//      - 'totalEntries': number of entries
//      - 'averageScore': average score (double), or 0.0 if empty
//      - 'highestScore': maximum score, or 0 if empty
//      - 'lowestScore': minimum score, or 0 if empty
//
//    Use ref.watch(moodProvider) to get the current mood list.
//
// Hint: This is "derived state" — it automatically recalculates whenever
// the mood list changes. No manual syncing needed!
// =============================================================================

final moodProvider = StateNotifierProvider<MoodNotifier, List<MoodEntry>>((
  ref,
) {
  return MoodNotifier();
});

final moodStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final moods = ref.watch(moodProvider);
  if (moods.isEmpty) {
    return {
      'totalEntries': 0,
      'averageScore': 0.0,
      'highestScore': 0,
      'lowestScore': 0,
    };
  }
  final scores = moods.map((e) => e.score).toList();
  return {
    'totalEntries': moods.length,
    'averageScore': scores.reduce((a, b) => a + b) / scores.length,
    'highestScore': scores.reduce((a, b) => a > b ? a : b),
    'lowestScore': scores.reduce((a, b) => a < b ? a : b),
  };
});
