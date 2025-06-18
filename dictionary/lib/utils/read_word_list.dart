import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<String>> fetchWordsFromJson() async {
  // Lê o arquivo JSON de assets
  String jsonString = await rootBundle.loadString(
    'assets/words_dictionary.json',
  );

  // Decodifica o JSON
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  // Extrai a lista de nomes
  List<String> nomes = List<String>.from(jsonData['wordsJson']);

  return nomes;
}
