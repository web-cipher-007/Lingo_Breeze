import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/vocabulary_controller.dart';
import '../widgets/add_word_bottom_sheet.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/vocabulary_card.dart';

class VocabularyScreen extends ConsumerWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch our Riverpod provider state asynchronously
    final vocabularyState = ref.watch(vocabularyProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Clean off-white background
      appBar: AppBar(
        title: const Text(
          'My Vocabulary',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: vocabularyState.when(
        // 1. LOADING STATE
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
          ),
        ),
        // 2. ERROR STATE
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.redAccent),
                const SizedBox(height: 16),
                const Text(
                  'Connection Error',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Could not connect to the LingoBreeze Node.js server.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => ref.read(vocabularyProvider.notifier).refreshWords(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        // 3. SUCCESS DATA STATES (Handles both Empty and Filled)
        data: (words) {
          if (words.isEmpty) {
            return const EmptyStateView();
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(vocabularyProvider.notifier).refreshWords(),
            color: const Color(0xFF6366F1),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: words.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return VocabularyCard(vocabulary: words[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Allows sheet to push up over soft keyboard
            backgroundColor: Colors.transparent,
            builder: (context) => const AddWordBottomSheet(),
          );
        },
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Word', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}