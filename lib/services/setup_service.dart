import 'package:get_it/get_it.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/general.dart';

import '../pages/login/service/login_service.dart';

GetIt appService = GetIt.instance;

void setupService() {
  appService.registerLazySingleton(() => AppSettings());
  appService.registerLazySingleton(() => NavigationService());
  appService.registerLazySingleton(() => LoginService());
  appService.registerLazySingleton(() => General());
  appService.registerLazySingleton(() => RestService());
}
