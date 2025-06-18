import 'package:dictionary/domain/repositories/user_repository/user_repository.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class Service {}

void setupServiceLocator() {
  locator.registerSingleton<WordRepository>(WordRepository());
  locator.registerSingleton<UserRepository>(UserRepository());
}
