import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  static const String dbName = 'wordsDb.db';
  static const String tableName = 'tblWords';
  // tabela de palavras
  static const String columnId = 'id';
  static const String columnWord = 'word';
  static const String columnFavorite = 'favorite';
  static const String columnHistory = 'history';

  // tabela usuario
  static const String userTable = 'users';
  static const String userId = 'id';
  static const String userName = 'name';
  static const String userEmail = 'email';
  static const String userPassword = 'password';

  Future<Database> get database async {
    try {
      if (_database != null) return _database!;

      _database = await _initializeDatabase();
      return _database!;
    } catch (e) {
      throw Exception("Um erro ocorreu, tente novamente mais tarde");
    }
  }

  Future<Database> _initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnWord TEXT,
        $columnFavorite INTEGER DEFAULT 0,
        $columnHistory INTEGER DEFAULT 1
      );
    ''');
    await db.execute('''
      CREATE TABLE $userTable (
        $userId INTEGER PRIMARY KEY AUTOINCREMENT,
        $userName TEXT NOT NULL,
        $userEmail TEXT NOT NULL UNIQUE,
        $userPassword TEXT NOT NULL
      );
    ''');
  }

  Future<int> insertUser(String name, String email, String password) async {
    final db = await database;
    final existingUser = await db.query(
      userTable,
      where: '$userEmail = ?',
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      throw Exception('Email já cadastrado');
    }

    try {
      return await db.insert(userTable, {
        userName: name,
        userEmail: email,
        userPassword: password,
      });
    } catch (e) {
      throw Exception('Erro ao cadastrar usuário');
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    var result;
    try {
      final db = await database;
      final userResult = await db.query(
        userTable,
        where: '$userEmail = ? AND $userPassword = ?',
        whereArgs: [email, password],
      );

      if (userResult.isNotEmpty) {
        result = userResult.first;
      } else {
        result = null;
      }
    } catch (e) {
      result = null;
    }
    return result;
  }

  Future<int> insert(String word) async {
    try {
      final db = await database;
      return await db.insert(tableName, {
        columnWord: word,
        columnFavorite: 0,
        columnHistory: 1,
      });
    } catch (e) {
      throw Exception("erro ao salvar palavra");
    }
  }

  Future<void> cleanList(String columnName) async {
    try {
      final db = await database;
      await db.update(tableName, {'favorite': 0});
    } catch (e) {
      throw Exception('Erro ao limpar a lista');
    }
  }

  Future<int> update(String word, bool status) async {
    try {
      final db = await database;
      return await db.update(
        tableName,
        {'favorite': status ? 1 : 0},
        where: '$columnWord = ?',
        whereArgs: [word],
      );
    } catch (e) {
      throw Exception("Erro ao atualizar");
    }
  }

  Future<List<Map<String, dynamic>>> queryByColumn(
    String column,
    int value,
  ) async {
    try {
      final db = await database;
      return await db.query(
        tableName,
        where: '$column = ?',
        whereArgs: [value],
      );
    } catch (e) {
      throw Exception("Erro ao buscar lista");
    }
  }
}
