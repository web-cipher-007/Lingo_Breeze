import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF), // Soft indigo circle tint
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_stories_rounded,
                size: 64,
                color: Color(0xFF6366F1),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Word Deck is Empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 8),
            Text(
              'Start your learning journey by saving new phrases, translation tags, and definitions context cards.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[500], height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}