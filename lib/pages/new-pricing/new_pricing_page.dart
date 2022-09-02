import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/cliente_modelo.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/models/cotizacion/type_building.dart';
import 'package:sunoff/pages/new-pricing/bloc_new_pricing/new_pricing_bloc.dart';
import 'package:sunoff/pages/new-pricing/widget/button_submit_input.dart';
import 'package:sunoff/pages/new-pricing/widget/inputAddress.dart';
import 'package:sunoff/pages/new-pricing/widget/inputName.dart';
import 'package:sunoff/pages/new-pricing/widget/input_type_building.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class NewPricingPage extends StatefulWidget {
  @override
  NewPricingState createState() => new NewPricingState();
}

class NewPricingState extends State<NewPricingPage> {
  PreferencesUser pref = new PreferencesUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final NewPricingBloc bloc = new NewPricingBloc();
  List<TypeBuilding> buildingType = [];
  List<Pelis> pelis = [];

  void _submit() {
    ClienteModelo cliente = bloc.toModelClient();

    CotizacionModel cotizacionModel = new CotizacionModel();

    cotizacionModel.buildingTypeId = bloc.typeBuilding;
    cotizacionModel.cliente = cliente;
    cotizacionModel.films = this.pelis;

    appService<NavigationService>()
        .navigateTo('new-pricing-details', arguments: cotizacionModel);
  }

  void getBuildingType() {
    RestService().getBuildingType().then((value) {
      this.buildingType = value;
      setState(() {});
    });
  }

  void getPelis() {
    RestService().getPelis().then((value) {
      this.pelis = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    this.getPelis();
    this.getBuildingType();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      backgroundColor: appService<AppSettings>().appTheme!.backgroundColor,
      appBar: appBarCustom(context),
      drawer: drawerCustom(context),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Nueva Cotización:',
                      style: TextStyle(
                        fontSize: 36,
                      ))),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Registra los siguientes datos:',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 35),
                  inputNameP(bloc),
                  inputAddress(bloc),
                  inputTypeBuilding(bloc, buildingType),
                  buttonSubmitInput(bloc, _submit)
                ],
              )),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
