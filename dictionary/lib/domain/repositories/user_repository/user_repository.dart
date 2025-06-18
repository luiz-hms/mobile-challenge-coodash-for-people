import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/services/user_session.dart';

class UserRepository {
  final DatabaseHelper db;
  final UserSession session;

  UserRepository(this.db, this.session);
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  Future<int> insertUser(String name, String email, passWord) async {
    int id = await _dbHelper.insertUser(name, email, passWord);
    return id;
  }

  Future<Map<String, dynamic>?> loginUser(String email, String passWord) async {
    final user = await _dbHelper.loginUser(email, passWord);
    return user;
  }

  Future<int> updateUser({
    required int id,
    required String name,
    required String email,
    required String password,
  }) async {
    return await db.updateUser(
      id: id,
      name: name,
      email: email,
      password: password,
    );
  }
}
