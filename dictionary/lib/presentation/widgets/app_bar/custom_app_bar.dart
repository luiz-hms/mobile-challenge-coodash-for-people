import 'package:dictionary/core/routes/named_routes.dart';
import 'package:dictionary/services/user_session.dart';
import 'package:flutter/material.dart';

AppBar CustomAppBar(BuildContext context, String title) {
  UserSession userSessionRepository = UserSession();
  return AppBar(
    actions: [
      IconButton(
        onPressed: () async {
          await userSessionRepository.clear();
          Navigator.of(context).pushNamed(NamedRoute.settings);
        },
        icon: Icon(Icons.settings, color: Color(0xfff56E0f)),
      ),
      IconButton(
        onPressed: () async {
          await userSessionRepository.clear();
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(NamedRoute.login, (route) => false);
        },
        icon: Icon(Icons.logout, color: Color(0xfff56E0f)),
      ),
    ],
    title: Text(
      title,
      style: TextStyle(color: Color(0xff151419), fontWeight: FontWeight.w700),
    ),
    /*
    const Text(
      title,
      style: TextStyle(color: Color(0xff151419), fontWeight: FontWeight.w700),
    ),
    */
    centerTitle: true,
    backgroundColor: Color(0xfffbfbfb),
    elevation: 1,
  );
}
