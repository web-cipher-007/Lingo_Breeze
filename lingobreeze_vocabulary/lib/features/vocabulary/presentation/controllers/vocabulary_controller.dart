import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/repositories/vocabulary_remote_datasoure.dart';
import '../../domain/entities/vocabulary_word.dart';

// 1. Dependency Injection Providers
final httpClientProvider = Provider((ref) => http.Client());

final vocabularyDataSourceProvider = Provider((ref) {
  final client = ref.watch(httpClientProvider);
  return VocabularyRemoteDataSource(client: client);
});

// 2. State Controller Notifier (Manages List State dynamically)
class VocabularyNotifier extends AsyncNotifier<List<VocabularyWord>> {
  late final VocabularyRemoteDataSource _dataSource;

  @override
  Future<List<VocabularyWord>> build() async {
    _dataSource = ref.watch(vocabularyDataSourceProvider);
    return _loadWords();
  }

  // Internal helper to get list from data source
  Future<List<VocabularyWord>> _loadWords() async {
    return await _dataSource.fetchWords();
  }

  // Refresh Action (Fulfills Pull-to-refresh UX requirement)
  Future<void> refreshWords() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadWords());
  }

  // Action to Create/Add a word
  Future<bool> addNewWord({
    required String word,
    required String meaning,
    required String translation,
  }) async {
    try {
      // Temporarily use loading state or handle action overlays
      final newWord = await _dataSource.addWord(word, meaning, translation);
      
      // Smart local state update: instead of a full network refetch, append item to existing UI state
      state = AsyncValue.data([newWord, ...?state.value]);
      return true;
    } catch (error, stackTrace) {
      // In production apps, handle side-effect errors cleanly
      return false;
    }
  }
}

// 3. Globally accessible Riverpod state provider
final vocabularyProvider = AsyncNotifierProvider<VocabularyNotifier, List<VocabularyWord>>(() {
  return VocabularyNotifier();
});