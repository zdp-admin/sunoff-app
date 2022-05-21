import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:sunoff/models/cotizacion/type_building.dart';
import 'package:sunoff/models/user.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/drawer_custom.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';

class PricingDetailsPage extends StatefulWidget {
  late final CotizacionModel cotization;
  late final int? buildTypeId;
  PricingDetailsPage({required this.cotization, this.buildTypeId});

  @override
  PricingDetailsState createState() => new PricingDetailsState();
}

class PricingDetailsState extends State<PricingDetailsPage> {
  PreferencesUser pref = new PreferencesUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? apiUrl = AppSettings().apiUrl;
  final oCcy = new NumberFormat("#,##0.00", "es_MX");
  final GlobalKey genKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  User contact = new User();

  @override
  void initState() {
    super.initState();
    this.getContact();
  }

  void getContact() {
    RestService().getUserById(this.widget.cotization.userId).then((value) {
      {
        setState(() {
          this.contact = value;
        });
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            onError is String ? onError : 'Error al consultar el contacto'),
      ));
    });
  }

  Future<dynamic> showCaptureWidget(BuildContext context,
      Uint8List captureImage, CotizacionModel cotizacion, double? pixelRatio) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text('VISTA PREVIA'),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      ShareFilesAndScreenshotWidgets().shareScreenshot(
                          genKey,
                          pixelRatio!,
                          'Ticket',
                          '${cotizacion.cliente.name}_${cotizacion.id}.png',
                          'image/png');

                      Future.delayed(Duration(seconds: 5), () {
                        appService<NavigationService>().navigateTo('profile');
                      });
                    }))
          ],
        ),
        body: InteractiveViewer(
          child: Center(
            child: captureImage != null
                ? Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.memory(captureImage))
                : Center(
                    child: Text('Ups, falló la captura.'),
                  ),
          ),
        ),
      ),
    );
  }

  String sumaMts2(List<MedidaModel> medida) {
    double mts = 0;

    mts = medida
        .map((e) => (e.alto * e.ancho))
        .toList()
        .fold(0, (prev, element) => double.parse(prev.toString()) + element);

    return mts.toString();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CotizacionModel cot = widget.cotization;
    String fechaCot = cot.date.toString().substring(0, 10);
    fechaCot = AppSettings().dateFormat.format(DateTime.parse(fechaCot));
    TypeBuilding bType = widget.cotization.typeBuilding;

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
                    child: Text('Resumen',
                        style: TextStyle(
                            fontSize: 28, fontStyle: FontStyle.italic)),
                  )),
                ],
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: RepaintBoundary(
                key: genKey,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(children: [
                    Container(
                        child: Stack(
                      children: [
                        Center(
                          child: Container(
                              height: 100,
                              child: Image.asset('assets/images/SunOff.png')),
                        ),
                        Container(
                          color: Colors.white70,
                          child: Column(
                            children: [
                              Text('${widget.cotization.cliente.name}',
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('${widget.cotization.cliente.address}\n',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    Text('Tipo: ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Container(
                                        child: bType.name != ''
                                            ? Text(bType.name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black))
                                            : Text(
                                                this.widget.buildTypeId == 1
                                                    ? 'Residencial'
                                                    : this.widget.buildTypeId ==
                                                            2
                                                        ? 'Comercial'
                                                        : 'Intermediario',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                  ])),
                              Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    Text('Secciones: ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Text(
                                        '${widget.cotization.secciones.length}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ])),
                            ],
                          ),
                        ),
                      ],
                    )),
                    Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
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
                                                  fontSize: 20,
                                                  color: PColors.pLightBlue)),
                                          Text('${section.nombre}',
                                              style: TextStyle(
                                                  fontSize: 20,
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
                                          Text(
                                              section.conteoMedidas != 0
                                                  ? '${section.conteoMedidas}'
                                                  : section.porVidrio
                                                      ? '${section.medidas.length}'
                                                      : '${section.conteoMedidas}',
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
                                                  fontSize: 16,
                                                  color: PColors.pLightBlue)),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Text('Mts2',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      inherit: false)),
                                            ),
                                          ),
                                          Text(
                                              '${(section.medidas.map((e) => (e.alto * e.ancho)).toList().fold(0, (prev, element) => double.parse(prev.toString()) + element) + (section.instalador)).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: PColors.pLightBlue)),
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
                                                            '\$ ${oCcy.format(film.priceForSection * double.parse((section.medidas.map((e) => (e.alto * e.ancho)).toList().fold(0, (prev, element) => double.parse(prev.toString()) + element) + (section.instalador)).toStringAsFixed(2)))}',
                                                            // '\$ ${oCcy.format((section.medidas.map((e) => double.parse((e.alto * e.ancho).toStringAsFixed(2))).toList().fold(0, (prev, element) => double.parse(prev.toString()) + element) + (section.instalador)) * film.priceForSection)}',
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
                                        child: size.width < 700
                                            ? section.pathImage != ''
                                                ? Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    height: 200,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: FadeInImage(
                                                        image: NetworkImage(
                                                          'http://${this.apiUrl}/public/${section.pathImage}',
                                                        ),
                                                        placeholder: AssetImage(
                                                            'assets/images/Pulse.gif'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ))
                                                : Center()
                                            : Center()),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Divider(
                                        thickness: 3,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )))
                            .toList(),
                      ),
                    ),
                    cot.comentario == ''
                        ? Text('')
                        : Center(child: Text(cot.comentario)),
                    Center(
                      child: Text(
                        '''\nCotización realizada el $fechaCot
Le atendió ${contact.name} ${contact.surname}.
Cel. ${contact.phone}
${contact.contactEmail}
Oficina 3331274426
www.sunoff.com.mx''',
//                         (cot.userId) == 4
//                             ? '''\nCotización realizada el $fechaCot
// Le atendió Gladimar Castellanos.
// Cel. 3311670664
// ventas@sunoff.com.mx
// Oficina 3331274426
// www.sunoff.com.mx'''
//                             : cot.userId == 5
//                                 ? '''\nCotización realizada el $fechaCot
// Le atendió Paula Vázquez.
// Cel. 3125504121
// comercializacion@sunoff.com.mx
// Oficina 3331274426
// www.sunoff.com.mx'''
//                                 : '''\nCotización realizada el $fechaCot
// Le atendió Francisco Molina.
// Cel. 3331274426
// direccion@sunoff.com.mx
// Oficina 3331274426
// www.sunoff.com.mx''',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Text(
              'Compartir Ticket',
              style: TextStyle(color: Colors.black45),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  double pixelRatio = MediaQuery.of(context).devicePixelRatio;
                  screenshotController
                      .capture(
                          pixelRatio: pixelRatio,
                          delay: Duration(milliseconds: 10))
                      .then((captureImage) async {
                    showCaptureWidget(context, captureImage!,
                        this.widget.cotization, pixelRatio);
                    setState(() {});
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
