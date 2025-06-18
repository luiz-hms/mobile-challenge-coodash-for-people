import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/domain/repositories/user_repository/user_repository.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:dictionary/services/user_session.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class Service {}

void setupServiceLocator() {
  locator.registerLazySingleton<UserSession>(() => UserSession()..load());
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
  locator.registerSingleton<WordRepository>(
    WordRepository(locator(), locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepository(locator(), locator()),
  );
}
