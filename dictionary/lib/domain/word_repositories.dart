import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/data/models/word_models.dart';
import 'package:dictionary/services/user_session.dart';

class WordRepository {
  final DatabaseHelper db;
  final UserSession session;

  WordRepository(this.db, this.session);
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  int _requireUserId() {
    final id = session.value?.id;
    if (id == null) throw Exception('Usuário não logado');
    return id;
  }

  Future<int> insertWord(String palavra) async {
    final userId = _requireUserId();
    int id = await _dbHelper.insert(palavra, userId);
    return id;
  }

  Future<int> updateWord(String word, bool status) async {
    final userId = _requireUserId();
    int linhasAfetadas = await _dbHelper.update(word, status, userId);
    return linhasAfetadas;
  }

  Future<void> cleanList(String columName) async {
    final userId = _requireUserId();
    await _dbHelper.cleanList(columName, userId);
  }

  Future<List<WordModels>> getWordsByHistory() async {
    final userId = _requireUserId();
    final result = await _dbHelper.queryByColumn(
      DatabaseHelper.columnHistory,
      1,
      userId,
    );
    return result.map((map) => WordModels.fromMap(map)).toList();
  }

  Future<List<WordModels>> getWordsByFavorite() async {
    final userId = _requireUserId();
    final result = await _dbHelper.queryByColumn(
      DatabaseHelper.columnFavorite,
      1,
      userId,
    );
    return result.map((map) => WordModels.fromMap(map)).toList();
  }
}
