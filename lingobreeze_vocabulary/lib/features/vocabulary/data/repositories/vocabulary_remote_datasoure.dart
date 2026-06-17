import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vocabulary_word_model.dart';

class VocabularyRemoteDataSource {
  final String baseUrl = 'http://192.168.254.183:3000/';
  final http.Client client;

  VocabularyRemoteDataSource({required this.client});

  Future<List<VocabularyWordModel>> fetchWords() async {
    final response = await client.get(Uri.parse('$baseUrl/words'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => VocabularyWordModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words from server');
    }
  }

  Future<VocabularyWordModel> addWord(String word, String meaning, String translation) async {
    final response = await client.post(
      Uri.parse('$baseUrl/words'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'word': word,
        'meaning': meaning,
        'translation': translation,
      }),
    );

    if (response.statusCode == 201) {
      return VocabularyWordModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to save word onto the server');
    }
  }
}