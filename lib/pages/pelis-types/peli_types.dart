import 'package:sunoff/models/cotizacion/film_category.dart';
import 'package:sunoff/pages/pelis-types/widgets/card_items.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class PeliPage extends StatefulWidget {
  @override
  MenuState createState() => new MenuState();
}

class MenuState extends State<PeliPage> {
  PreferencesUser pref = new PreferencesUser();
  List<FilmCategory> filmCategory = [];

  @override
  void initState() {
    super.initState();
    this.getFilmCategory();
  }

  void getFilmCategory() {
    appService<RestService>().getFilmCategory().then((value) {
      setState(() {
        this.filmCategory = value;
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            onError is String ? onError : 'Error al consultar la información'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool haveFilms = this.filmCategory.length <= 0;
    return Scaffold(
        appBar: appBarCustom(context),
        drawer: drawerCustom(context),
        backgroundColor: Colors.white,
        body: haveFilms
            ? Container(
                margin: EdgeInsets.only(top: 2),
                child: LinearProgressIndicator(),
              )
            : Center(
                child: Container(
                  height: size.height * .8,
                  width: size.width > 700
                      ? 700
                      : MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width,
                          child: Text('Películas:',
                              style: TextStyle(
                                fontSize: 36,
                              ))),
                      Container(
                        child: Wrap(
                            verticalDirection: VerticalDirection.down,
                            runSpacing: 25,
                            children: this
                                .filmCategory
                                .map((category) => GestureDetector(
                                    onTap: () {
                                      appService<NavigationService>()
                                          .navigateTo('films-category',
                                              arguments: category.id);
                                    },
                                    child: cardItems(
                                        context, category.code, category.name)))
                                .toList()),
                      )
                    ],
                  ),
                ),
              ));
  }
}
