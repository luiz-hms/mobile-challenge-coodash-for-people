import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class UserSession extends ValueNotifier<UserModel?> {
  static const String _key = 'user_data';

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

  Future<void> updateUser({String? name, String? email}) async {
    if (value != null) {
      final updatedUser = UserModel(
        id: value!.id,
        name: name ?? value!.name,
        email: email ?? value!.email,
      );
      await save(updatedUser);
    }
  }
}
