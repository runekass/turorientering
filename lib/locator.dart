import 'package:turorientering/services/authentication_service.dart';
import 'package:turorientering/services/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'package:turorientering/services/navigation_service.dart';
import 'package:turorientering/services/dialog_service.dart';

GetIt locator = GetIt.instance;


void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}