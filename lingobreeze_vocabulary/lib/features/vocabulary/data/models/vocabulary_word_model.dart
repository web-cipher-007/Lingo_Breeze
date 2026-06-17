import '../../domain/entities/vocabulary_word.dart';

class VocabularyWordModel extends VocabularyWord {
  const VocabularyWordModel({
    required super.id,
    required super.word,
    required super.meaning,
    required super.translation,
    super.createdAt,
  });

  // Convert Node.js API JSON response into Flutter Model
  factory VocabularyWordModel.fromJson(Map<String, dynamic> json) {
    return VocabularyWordModel(
      id: json['id'] ?? '',
      word: json['word'] ?? '',
      meaning: json['meaning'] ?? '',
      translation: json['translation'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt']) 
          : null,
    );
  }

  // Convert Model back into JSON payload for the POST request
  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'translation': translation,
    };
  }
}