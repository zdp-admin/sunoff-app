import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/utils/validators.dart';
import 'package:uuid/uuid.dart';

class CotizacionBloc with Validators {
  BehaviorSubject<List<SeccionModelo>> _seccionesController =
      BehaviorSubject<List<SeccionModelo>>();
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<bool> _isSwitchedController = BehaviorSubject<bool>();
  BehaviorSubject<int> _measuresCountController = BehaviorSubject<int>();
  BehaviorSubject<List<MedidaModel>> _medidasController =
      BehaviorSubject<List<MedidaModel>>();
  BehaviorSubject<List<Pelis>> _peliculasController =
      BehaviorSubject<List<Pelis>>();
  BehaviorSubject<double> _instaladorController = BehaviorSubject<double>();
  BehaviorSubject<File> _imagenController = BehaviorSubject<File>();
  BehaviorSubject<int> _peliController = BehaviorSubject<int>();
  TextEditingController nombreController = TextEditingController();

  Stream<List<SeccionModelo>> get seccionesStream =>
      _seccionesController.stream;
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateEmpty);
  Stream<bool> get isSwitchedStream => _isSwitchedController.stream;
  Stream<int> get measuresCountStream => _measuresCountController.stream;
  Stream<List<MedidaModel>> get medidasStream => _medidasController.stream;
  Stream<List<Pelis>> get peliculasStream => _peliculasController.stream;
  Stream<double> get instaladorStream =>
      _instaladorController.stream.transform(validatedouble);
  Stream<File> get imagenStream => _imagenController.stream;
  Stream<int> get peliStream => _peliController.stream;
  Stream<bool> get formValidStream => Rx.combineLatest3(
      nameStream, medidasStream, peliculasStream, (a, b, c) => true);

  Function(List<SeccionModelo>) get changeSecciones =>
      _seccionesController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(bool) get changeisSwitched => _isSwitchedController.sink.add;
  Function(int) get changeMeasuresCount => _measuresCountController.sink.add;
  Function(List<MedidaModel>) get changeMedidas => _medidasController.sink.add;
  Function(List<Pelis>) get changePeliculas => _peliculasController.sink.add;
  Function(double) get changeInstalador => _instaladorController.sink.add;
  Function(File) get changeImagen => _imagenController.sink.add;
  Function(int) get changePeli => _peliController.sink.add;

  List<SeccionModelo> get secciones => _seccionesController.valueOrNull ?? [];
  String get name => _nameController.valueOrNull ?? '';
  bool get isSwitched => _isSwitchedController.valueOrNull ?? false;
  int get measuresCount => _measuresCountController.valueOrNull ?? 0;
  List<MedidaModel> get medidas => _medidasController.valueOrNull ?? [];
  List<Pelis> get peliculas => _peliculasController.valueOrNull ?? [];
  double get instalador => _instaladorController.valueOrNull ?? 0;
  File get imagen => _imagenController.valueOrNull ?? new File('');
  int get peli => _peliController.valueOrNull ?? 0;

  CotizacionBloc() {
    this.changeMeasuresCount(1);
    this.changeMedidas([MedidaModel.fromJson({})]);
  }

  SeccionModelo toModel() {
    var uuid = Uuid();
    SeccionModelo seccionModelo = new SeccionModelo();
    seccionModelo.nombre = this.name;
    seccionModelo.porVidrio = this.isSwitched;
    seccionModelo.conteoMedidas = this.measuresCount;
    seccionModelo.medidas = this.medidas;
    seccionModelo.peliculas = this.peliculas;
    seccionModelo.instalador = this.instalador;
    seccionModelo.imagen = this.imagen;
    seccionModelo.uuid = uuid.v1();

    return seccionModelo;
  }

  void clear() {
    this._nameController = BehaviorSubject<String>();
    this._isSwitchedController = BehaviorSubject<bool>();
    this._measuresCountController = BehaviorSubject<int>();
    this._instaladorController = BehaviorSubject<double>();
    this.changeImagen(new File(''));
    this._peliController = BehaviorSubject<int>();
    this.changePeliculas([]);
    this.changeMedidas([MedidaModel.fromJson({})]);
    this.changeMeasuresCount(1);
  }

  dispose() {
    _seccionesController.close();
    _nameController.close();
    _isSwitchedController.close();
    _measuresCountController.close();
    _instaladorController.close();
    _imagenController.close();
    _medidasController.close();
    _peliculasController.close();
    _peliController.close();
  }
}
