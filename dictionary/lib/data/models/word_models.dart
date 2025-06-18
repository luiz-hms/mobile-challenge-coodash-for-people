class WordModels {
  final int? id;
  final String word;
  final bool favorite;
  final bool history;

  WordModels({
    this.id,
    required this.word,
    required this.favorite,
    required this.history,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'favorite': favorite ? 1 : 0,
      'history': history ? 1 : 0,
    };
  }

  factory WordModels.fromMap(Map<String, dynamic> map) {
    return WordModels(
      id: map['id'],
      word: map['word'],
      favorite: map['favorite'] == 1,
      history: map['history'] == 1,
    );
  }
}
