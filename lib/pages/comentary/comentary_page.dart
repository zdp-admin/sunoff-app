import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/pages/comentary/bloc/comentary_bloc.dart';
import 'package:sunoff/pages/comentary/widget/button_submit_input.dart';
import 'package:sunoff/pages/comentary/widget/input_comentary.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class ComentaryPage extends StatefulWidget {
  final CotizacionModel cotizacionModel;

  ComentaryPage({required this.cotizacionModel});

  @override
  ComentaryState createState() => new ComentaryState();
}

class ComentaryState extends State<ComentaryPage> {
  PreferencesUser pref = new PreferencesUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ComentaryBloc bloc = new ComentaryBloc();
  late List<Pelis> listPelis = [];

  void submit() {
    this.widget.cotizacionModel.comentario = this.bloc.comentary;
    setState(() {});

    appService<RestService>()
        .pricing(this.widget.cotizacionModel)
        .then((value) {
      print(value);
      appService<NavigationService>().navigateTo('profile');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    this.widget.cotizacionModel.secciones.forEach((element) {
      this.listPelis.addAll(element.peliculas);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: this._scaffoldKey,
        backgroundColor: appService<AppSettings>().appTheme!.backgroundColor,
        appBar: appBarCustom(context),
        drawer: drawerCustom(context),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width,
                    child: Text('Por último:',
                        style: TextStyle(
                          fontSize: 36,
                        ))),
                Text(
                  'Añade los comentarios finales:',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    inputComentary(bloc),
                    SizedBox(height: 35),
                    Text(
                      'Añade los precios de las películas:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black38),
                          borderRadius: BorderRadius.circular(5)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(children: [
                        Divider(),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Mate Blanco',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: PColors.pLightBlue)),
                                  Container(
                                      width: 100,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Precio',
                                          suffix: Text('MXN'),
                                          prefix: Text('\$ '),
                                          //border: InputBorder.none,
                                        ),
                                      ))
                                ])),
                        Divider(),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        Text('Seguridad',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: PColors.pLightBlue)),
                                      ])),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: 100,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Precio',
                                          suffix: Text('MXN'),
                                          prefix: Text('\$ '),
                                          //border: InputBorder.none,
                                        ),
                                      ))
                                ])),
                        Divider()
                      ]),
                    ),
                    /*Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                          children: this
                              .listPelis
                              .toSet()
                              .map((film) => Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        Expanded(
                                            child: Text(film.name,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                        PColors.pLightBlue))),
                                        Container(
                                            width: 100,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  labelText: 'Precio'),
                                              onChanged: (value) {
                                                film.priceForSection =
                                                    double.parse(value);
                                                this
                                                    .listPelis
                                                    .where((element) =>
                                                        element.id == film.id)
                                                    .forEach((element) {
                                                  element.priceForSection =
                                                      double.parse(value);
                                                });

                                                setState(() {});
                                              },
                                            ))
                                      ])))
                              .toList()),
                    ),*/
                    buttonSubmitInputB(bloc, submit)
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}
