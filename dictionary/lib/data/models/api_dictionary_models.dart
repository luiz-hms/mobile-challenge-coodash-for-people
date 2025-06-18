class ApiDictionaryModels {
  final String word;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;
  final License license;
  final List<String> sourceUrls;

  ApiDictionaryModels({
    required this.word,
    required this.phonetics,
    required this.meanings,
    required this.license,
    required this.sourceUrls,
  });

  factory ApiDictionaryModels.fromJson(Map<String, dynamic> json) {
    return ApiDictionaryModels(
      word: json['word'],
      phonetics:
          (json['phonetics'] as List)
              .map((item) => Phonetic.fromJson(item))
              .toList(),
      meanings:
          (json['meanings'] as List)
              .map((item) => Meaning.fromJson(item))
              .toList(),
      license: License.fromJson(json['license']),
      sourceUrls: List<String>.from(json['sourceUrls'] ?? []),
    );
  }
}

class Phonetic {
  final String? text;
  final String? audio;

  Phonetic({this.text, this.audio});

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(text: json['text'], audio: json['audio']);
  }
}

class Meaning {
  final String partOfSpeech;
  final List<Definition> definitions;

  Meaning({required this.partOfSpeech, required this.definitions});

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'],
      definitions:
          (json['definitions'] as List)
              .map((item) => Definition.fromJson(item))
              .toList(),
    );
  }
}

class Definition {
  final String definition;
  final String? example;

  Definition({required this.definition, this.example});

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(definition: json['definition'], example: json['example']);
  }
}

class License {
  final String name;
  final String url;

  License({required this.name, required this.url});

  factory License.fromJson(Map<String, dynamic> json) {
    return License(name: json['name'], url: json['url']);
  }
}
