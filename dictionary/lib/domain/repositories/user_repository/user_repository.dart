import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/data/models/user_model.dart';
import 'package:dictionary/services/user_session.dart';

class UserRepository {
  final DatabaseHelper db;
  final UserSession session;

  UserRepository(this.db, this.session);

  Future<int> insertUser(String name, String email, String password) async {
    final id = await db.insertUser(name, email, password);
    final userMap = await db.loginUser(email, password);
    if (userMap != null) {
      await session.save(UserModel.fromMap(userMap));
    }
    return id;
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final userMap = await db.loginUser(email, password);
    if (userMap != null) {
      final model = UserModel.fromMap(userMap);
      await session.clear();
      await session.save(model);
      return userMap;
    }
    return null;
  }

  Future<int> updateUser({
    required int id,
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await db.updateUser(
      id: id,
      name: name,
      email: email,
      password: password,
    );

    final updatedUser = await db.loginUser(email, password);
    if (updatedUser != null) {
      await session.save(UserModel.fromMap(updatedUser));
    }

    return result;
  }

  Future<void> logout() async {
    await session.clear();
  }
}
