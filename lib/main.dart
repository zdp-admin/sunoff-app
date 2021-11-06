import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sunoff/providers/app_provider.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/router.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferencesUser();
  await prefs.initPrefs();

  setupService();

  runApp(SunOff());
}

class SunOff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));

    return AppProvider(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SunOff',
          theme: appService<AppSettings>().appTheme,
          localizationsDelegates: [GlobalMaterialLocalizations.delegate],
          supportedLocales: [const Locale('es')],
          navigatorKey: appService<NavigationService>().navigationKey,
          onGenerateRoute: generateRoute,
          home: StartUpView()),
    );
  }
}
