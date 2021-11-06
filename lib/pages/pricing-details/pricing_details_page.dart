import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class PricingDetailsPage extends StatefulWidget {
  final CotizacionModel cotization;

  PricingDetailsPage({required this.cotization});

  @override
  PricingDetailsState createState() => new PricingDetailsState();
}

class PricingDetailsState extends State<PricingDetailsPage> {
  PreferencesUser pref = new PreferencesUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  /*double sumaMts(double alto, double ancho) {
    double mts = 0;

    mts = mts + alto * ancho;

    return mts;
  }

  String sumaMts(double alto, double ancho) {
    double mts = 0;

    mts = mts + alto * ancho;

    return mts.toString();
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      backgroundColor: appService<AppSettings>().appTheme!.backgroundColor,
      appBar: appBarCustom(context),
      drawer: drawerCustom(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Expanded(
                      child: Container(
                    child: Text('Detalles',
                        style: TextStyle(
                            fontSize: 28, fontStyle: FontStyle.italic)),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(255, 255, 255, 0.5),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(children: [
                Container(
                    child: Column(
                  children: [
                    Text('${widget.cotization.cliente.name}',
                        style: TextStyle(
                            fontSize: 26,
                            color: PColors.pLightBlue,
                            fontWeight: FontWeight.bold)),
                    Text('${widget.cotization.cliente.address}\n',
                        textAlign: TextAlign.justify,
                        style:
                            TextStyle(fontSize: 22, color: PColors.pLightBlue)),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text('Tipo: ',
                              style: TextStyle(
                                  fontSize: 20, color: PColors.pLightBlue)),
                          Text(widget.cotization.typeBuilding.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: PColors.pLightBlue)),
                        ])),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text('Secciones: ',
                              style: TextStyle(
                                  fontSize: 20, color: PColors.pLightBlue)),
                          Text('${widget.cotization.secciones.length}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: PColors.pLightBlue)),
                        ])),
                  ],
                )),
                Divider(
                  thickness: 3,
                ),
                Container(
                  child: Column(
                    children: widget.cotization.secciones
                        .map((section) => Container(
                                child: Column(
                              children: [
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Text('Sección: ',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: PColors.pLightBlue)),
                                      Text('${section.nombre}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: PColors.pLightBlue))
                                    ])),
                                SizedBox(height: 10),
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Text('Vidrios: ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: PColors.pLightBlue)),
                                      Text('${section.medidas.length}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: PColors.pLightBlue))
                                    ])),
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Text(' - Medida: ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: PColors.pLightBlue)),
                                      Text('',
                                          //section.medidas.forEach((element) => sumaMts(element.alto, element.ancho))
                                          //'${section.medidas.fold(0, (previousValue, element) => previousValue + (element.alto * element.ancho))} M2',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: PColors.pLightBlue))
                                    ])),
                                SizedBox(height: 18),
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Text('Películas: ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: PColors.pLightBlue)),
                                      Text('Total:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: PColors.pLightBlue))
                                    ])),
                                Container(
                                  child: Column(
                                    children: section.peliculas
                                        .map((film) => Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                  Text(' - ${film.name}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: PColors
                                                              .pLightBlue)),
                                                  Column(children: [
                                                    Text(
                                                        '\$ ${film.priceForSection * section.medidas.fold(0, (previousValue, element) => previousValue + (element.alto * element.ancho))}',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: PColors
                                                                .pLightBlue)),
                                                  ]),
                                                ])))
                                        .toList(),
                                  ),
                                ),
                                Container(
                                    child: section.pathImage != ''
                                        ? Column(
                                            children: [
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                  child: Image.file(
                                                      File(section.pathImage))),
                                            ],
                                          )
                                        : Center()),
                                Divider(
                                  thickness: 3,
                                ),
                              ],
                            )))
                        .toList(),
                  ),
                ),
                /*Container(
                    child: Column(
                        children: this
                            .widget
                            .cotization
                            .secciones
                            .map((item) => Column(children: [
                                  Text(
                                    'Total de la sección ${item.nombre}:',
                                    style: TextStyle(
                                        color: PColors.pLightBlue,
                                        fontSize: 18),
                                  ),
                                  Column(
                                    children: item.peliculas
                                        .map((peli) =>
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('${peli.name}'),
                                                  Text(
                                                      '${peli.priceForSection * 1}')
                                                ]))
                                        .toList(),
                                  )
                                  //Row(children: [Text('Total general:')],)
                                ]))
                            .toList())),
                Divider(
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagesPage()));
                        },
                        child: Text('Ver Fotos')),
                  ],
                ),
                Divider(
                  thickness: 3,
                ),*/
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
