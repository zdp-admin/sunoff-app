import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/pages/profile/widgets/card_items.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class ProfilePage extends StatefulWidget {
  @override
  MenuState createState() => new MenuState();
}

class MenuState extends State<ProfilePage> {
  PreferencesUser pref = new PreferencesUser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCustom(context),
        drawer: drawerCustom(context),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width > 700
                  ? 700
                  : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * .15,
                    width: MediaQuery.of(context).size.width,
                    child: Text('¡Hola, ${pref.me().user.name}!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 48)),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(color: PColors.pLightBlue)),
                          onPressed: () {
                            appService<NavigationService>()
                                .navigateTo('new-pricing');
                          },
                          child: cardItems(
                              context, Icons.description, 'Nueva Cotización')),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(color: PColors.pLightBlue)),
                        onPressed: () {
                          appService<NavigationService>()
                              .navigateTo('peliculas');
                        },
                        child: cardItems(context, Icons.window, 'Películas'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(color: PColors.pLightBlue)),
                        onPressed: () {
                          appService<NavigationService>().navigateTo('pricing');
                        },
                        child: cardItems(
                            context, Icons.monetization_on, 'Presupuestos'),
                      ),
                      SizedBox(height: 20),
                      /*GestureDetector(
                        onTap: () {
                          appService<NavigationService>()
                              .navigateTo('installer');
                        },
                        child:
                            cardItems(context, Icons.handyman, 'Instalación'),
                      ),*/
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
