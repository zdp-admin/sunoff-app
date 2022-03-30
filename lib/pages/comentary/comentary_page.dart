import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/pages/comentary/bloc/comentary_bloc.dart';
import 'package:sunoff/pages/comentary/widget/button_submit_input.dart';
import 'package:sunoff/pages/comentary/widget/film_price_section.dart';
import 'package:sunoff/pages/comentary/widget/input_comentary.dart';
import 'package:sunoff/pages/pricing-details/pricing_details_page.dart';
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
  String? apiUrl = AppSettings().apiUrl;

  void submit() {
    bloc.changeLoading(true);
    CotizacionModel cot = this.widget.cotizacionModel;

    cot.comentario = this.bloc.comentary;
    cot.secciones.map((e) {
      e.bloc.changePeliculas(listPelis);
    });

    RestService().pricing(this.widget.cotizacionModel).then((value) {
      bloc.changeLoading(false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PricingDetailsPage(
                    cotization: value,
                    buildTypeId: this.widget.cotizacionModel.buildingTypeId,
                  )));
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Cotización guardada.')));
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    this.widget.cotizacionModel.secciones.forEach((element) {
      element.peliculas.forEach((element) {
        listPelis.contains(element) ? print(listPelis) : listPelis.add(element);
      });
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: rowPrice(bloc, listPelis),
                    ),
                    buttonSubmitInputB(bloc, submit, listPelis)
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}
