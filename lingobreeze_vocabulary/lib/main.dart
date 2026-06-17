import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/vocabulary/presentation/screens/vocabulary_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: LingoBreezeApp(),
    ),
  );
}

class LingoBreezeApp extends StatelessWidget {
  const LingoBreezeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LingoBreeze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VocabularyScreen()
    );
  }
}