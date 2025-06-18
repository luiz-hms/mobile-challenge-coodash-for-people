import 'package:dictionary/data/data_source/database_helper.dart';

class UserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  Future<int> insertUser(String name, String email, passWord) async {
    int id = await _dbHelper.insertUser(name, email, passWord);
    return id;
  }

  Future<Map<String, dynamic>?> loginUser(String email, String passWord) async {
    final user = await _dbHelper.loginUser(email, passWord);
    return user;
  }
}
