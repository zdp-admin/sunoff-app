import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';
import 'package:sunoff/pages/cotizacion/bloc/cotizacion_bloc.dart';
import 'package:sunoff/pages/cotizacion/widget/cotizacion_imput_image_gallery.dart';
import 'package:sunoff/pages/cotizacion/widget/widgets_export.dart';

import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/setup_service.dart';

class CotizacionPage extends StatefulWidget {
  final CotizacionModel cotizacionModel;
  CotizacionPage({required this.cotizacionModel});
  //--------------Agregar un listado de secciones para guardar temporalmente
  //--------------Luego en submit final cargarlas---------------------------

  @override
  _CotizacionPageState createState() => _CotizacionPageState();
}

class _CotizacionPageState extends State<CotizacionPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  CotizacionBloc bloc = CotizacionBloc();
  Key keybody = Key(DateTime.now().microsecond.toString());

  @override
  void initState() {
    super.initState();

    this.bloc.changeSecciones([SeccionModelo.fromJson({})]);

    this._tabController = TabController(vsync: this, length: 1);

    this.bloc.changeMedidas([MedidaModel.fromJson({})]);

    this.bloc.changeMeasuresCount(1);
  }

  void addSection() {
    List<SeccionModelo> secciones = this.bloc.secciones;
    secciones.add(SeccionModelo.fromJson({}));

    this.bloc.changeSecciones(secciones);

    this._tabController = TabController(length: secciones.length, vsync: this);

    this
        ._tabController
        .animateTo(secciones.length - 1, duration: Duration(milliseconds: 5));

    setState(() {});
  }

  void removeSection(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eliminar Sección'),
            content: Text('¿Seguro quieres eliminar esta sección?'),
            actions: [
              TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text('Eliminar'),
                  onPressed: () {
                    List<SeccionModelo> secciones = this.bloc.secciones;

                    if (secciones.length > 1) {
                      setState(() {
                        int index = this._tabController.index;
                        secciones.removeAt(index);

                        this.bloc.changeSecciones(secciones);

                        this._tabController = TabController(
                            length: this.bloc.secciones.length, vsync: this);
                        this
                            ._tabController
                            .animateTo(index > 0 ? index - 1 : 0);

                        this.keybody =
                            Key(DateTime.now().millisecond.toString());
                      });

                      Navigator.pop(context);
                    }
                  }),
            ],
          );
        });
  }

  //--------------Posible desuso-------------------
  void changeSwitch() {
    if (this.bloc.isSwitched) {
      List<MedidaModel> newmedidas = [];

      for (int i = 0; i < this.bloc.measuresCount; i++) {
        newmedidas.add(MedidaModel.fromJson({}));
      }

      this.bloc.changeMedidas(newmedidas);
    } else {
      this.bloc.changeMedidas([MedidaModel.fromJson({})]);
    }
  }

  void addPeli(SeccionModelo section) {
    try {
      section.addFilms(widget.cotizacionModel.films);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          duration: Duration(seconds: 1),
          content: Text(e is String ? e : 'Error al agregar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.keybody,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('SECCIONES'),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 40),
              child: StreamBuilder(
                stream: this.bloc.seccionesStream,
                builder: (BuildContext context, AsyncSnapshot snp) {
                  List<SeccionModelo> secciones = snp.hasData ? snp.data : [];
                  return TabBar(
                      isScrollable: true,
                      controller: this._tabController,
                      tabs: secciones.length == 0
                          ? List.generate(this._tabController.length,
                                  (index) => index + 1)
                              .map((e) => SingleChildScrollView())
                              .toList()
                          : secciones
                              .asMap()
                              .entries
                              .map((seccion) => StreamBuilder(
                                    stream: seccion.value.bloc.nameStream,
                                    builder: (BuildContext ctx,
                                        AsyncSnapshot snpname) {
                                      return Container(
                                          child: Text(
                                        this._tabController.index != seccion.key
                                            ? seccion.value.bloc.name != ''
                                                ? seccion.value.bloc.name
                                                : 'Nueva Sección'
                                            : snpname.hasData
                                                ? snpname.data
                                                : 'Nueva Sección',
                                      ));
                                    },
                                  ))
                              .toList());
                },
              )),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: StreamBuilder(
          stream: this.bloc.seccionesStream,
          builder: (BuildContext context, AsyncSnapshot snp) {
            List<SeccionModelo> secciones = snp.hasData ? snp.data : [];

            return TabBarView(
              controller: this._tabController,
              children: secciones.length == 0
                  ? List.generate(
                          this._tabController.length, (index) => index + 1)
                      .map((e) => SingleChildScrollView())
                      .toList()
                  : secciones
                      .map((seccion) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 12),
                              child: Column(
                                children: [
                                  Container(child: cinputName(seccion)),
                                  SizedBox(height: 20),
                                  Container(child: glassCounter(seccion)),
                                  SizedBox(height: 20),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: inputSwitch(seccion),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: cinputPorSeccion(seccion),
                                  ),
                                  SizedBox(height: 20),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: cPeliculasSelect(seccion,
                                        widget.cotizacionModel.films, addPeli),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: cListPeliculas(seccion),
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Container(
                                    child: cinputInstaller(seccion),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.center,
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          cinputImage(context, seccion),
                                          cinputImageGallery(context, seccion),
                                        ],
                                      ),
                                      StreamBuilder(
                                        stream: seccion.bloc.imagenStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<File> snapshot) {
                                          bool validFile = snapshot.hasData &&
                                              snapshot.data != null &&
                                              snapshot.data!.path != '';

                                          return Container(
                                            child: !validFile
                                                ? Center()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    color: Colors.red,
                                                    child: Stack(
                                                      children: [
                                                        Material(
                                                          elevation: 10,
                                                          child: Container(
                                                            height: 250,
                                                            child: Image.file(
                                                              snapshot.data!,
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 8,
                                                                      right: 8),
                                                              height: 25,
                                                              width: 25,
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  FloatingActionButton(
                                                                child: Icon(Icons
                                                                    .cancel),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    seccion.bloc
                                                                        .changeImagen(
                                                                            new File(''));
                                                                  });
                                                                },
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                          );
                                        },
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
            );
          },
        ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
            ),
            backgroundColor: Colors.transparent,
            onTap: (int index) {
              SeccionModelo currentSeccion =
                  this.bloc.secciones[this._tabController.index];

              if (index == 0) {
                this.bloc.secciones.length == 1
                    ? null
                    : this.removeSection(context);
              } else if (index == 1) {
                bool allComplete = this.bloc.secciones.every((element) =>
                    element.bloc.name != '' &&
                    element.bloc.peliculas.length > 0 &&
                    element.bloc.medidas.every(
                        (medida) => medida.alto > 0 && medida.ancho > 0));

                if (!allComplete) {
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(currentSeccion.bloc.name == ''
                          ? 'Ingresa nombre a la sección.'
                          : currentSeccion.bloc.medidas.every((medida) =>
                                  medida.alto <= 0 && medida.ancho <= 0)
                              ? 'Revisa las medidas.'
                              : 'Agrega una película.')));

                  return;
                }

                widget.cotizacionModel.secciones = this
                    .bloc
                    .secciones
                    .map((seccion) => seccion.bloc.toModel())
                    .toList();

                setState(() {});

                appService<NavigationService>().navigateTo('comentary-page',
                    arguments: widget.cotizacionModel);
              } else {
                currentSeccion.bloc.name != '' &&
                        currentSeccion.bloc.peliculas.length > 0 &&
                        currentSeccion.bloc.medidas.every(
                            (element) => element.alto > 0 && element.ancho > 0)
                    ? addSection()
                    : ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(currentSeccion.bloc.name == ''
                            ? 'Ingresa nombre a la sección.'
                            : currentSeccion.bloc.medidas.every((medida) =>
                                    medida.alto <= 0 && medida.ancho <= 0)
                                ? 'Revisa las medidas.'
                                : 'Agrega una película.')));
              }
            },
            items: [
              BottomNavigationBarItem(
                  label: 'Eliminar Sección',
                  icon: Icon(Icons.delete,
                      color: bloc.secciones.length == 1
                          ? Colors.red[200]
                          : Colors.red[500])),
              BottomNavigationBarItem(
                label: 'Continuar',
                icon: Icon(Icons.done),
              ),
              BottomNavigationBarItem(
                label: 'Añadir Sección',
                icon: Icon(Icons.add),
              )
            ]));
  }
}
