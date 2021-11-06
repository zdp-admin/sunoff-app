import 'package:flutter/material.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/list_title_custom.dart';

Drawer drawerCustom(BuildContext context) {
  PreferencesUser pref = new PreferencesUser();
  Color _mainColor = appService<AppSettings>().appTheme!.primaryColor;
  void logOut(BuildContext context) {
    pref.loggout();
    appService<NavigationService>().navigateToAndRemoveHistory('login');
  }

  void showAlert(BuildContext context, String title, String message,
      Function(BuildContext context) logout) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    logout(context);
                  },
                )
              ],
            ));
  }

  return Drawer(
    child: Container(
        color: appService<AppSettings>().appTheme!.accentColor,
        child: ListView(physics: BouncingScrollPhysics(), children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: appService<AppSettings>().appTheme!.primaryColorLight),
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15),
                child: Image(
                  image: AssetImage('assets/images/SunOff.png'),
                  width: 200,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            color: appService<AppSettings>().appTheme!.accentColor,
            child: Column(
              children: [
                listTileCustom('Menú', Icon(Icons.home, color: _mainColor), () {
                  if (pref.logged) {
                    appService<NavigationService>().navigateTo('profile');
                  } else {
                    appService<NavigationService>().navigateTo('login');
                  }
                }),
                listTileCustom('Nueva Cotización',
                    Icon(Icons.description, color: _mainColor), () {
                  appService<NavigationService>().navigateTo('new-pricing');
                }),
                listTileCustom(
                    'Películas', Icon(Icons.window, color: _mainColor), () {
                  appService<NavigationService>().navigateTo('peliculas');
                }),
                listTileCustom('Presupuesto',
                    Icon(Icons.monetization_on, color: _mainColor), () {
                  appService<NavigationService>().navigateTo('pricing');
                }),
                listTileCustom('Agregar Instalación',
                    Icon(Icons.handyman, color: _mainColor), () {
                  appService<NavigationService>().navigateTo('installer');
                }),
                Divider(),
                if (pref.logged) ...[
                  listTileCustom(
                      'CERRAR SESIÓN', Icon(Icons.login, color: _mainColor),
                      () {
                    showAlert(context, 'Sesion',
                        '¿Estas seguro de cerrar sesion?', logOut);
                  })
                ]
              ],
            ),
          )
        ])),
  );
}
