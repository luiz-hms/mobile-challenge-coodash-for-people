import 'dart:convert';
import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class UserSession extends ValueNotifier<UserModel?> {
  static const String _key = 'user_data';
  DatabaseHelper _db = DatabaseHelper.instance;
  UserSession() : super(null);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      value = UserModel.fromMap(json.decode(jsonString));
    }
  }

  Future<void> save(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(user.toMap()));
    value = user;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    value = null;
  }

  Future<void> updateUserSession({
    String? name,
    String? email,
    String? password,
  }) async {
    if (value != null) {
      final updatedUser = UserModel(
        id: value!.id,
        name: name ?? value!.name,
        email: email ?? value!.email,
        password: password ?? value!.password,
      );
      await clear();
      await save(updatedUser);
      await _db.updateUser(
        id: value!.id,
        name: name ?? value!.name,
        email: email ?? value!.email,
        password: password ?? value!.password,
      );
    }
  }
}
