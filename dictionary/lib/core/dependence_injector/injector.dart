import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/domain/repositories/user_repository/user_repository.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:dictionary/services/user_session.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class Service {}

void setupServiceLocator() {
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
  locator.registerLazySingleton<UserSession>(() => UserSession());

  locator.registerLazySingleton<UserRepository>(
    () => UserRepository(locator<DatabaseHelper>(), locator<UserSession>()),
  );
  locator.registerSingleton<WordRepository>(
    WordRepository(locator<DatabaseHelper>(), locator<UserSession>()),
  );
}
