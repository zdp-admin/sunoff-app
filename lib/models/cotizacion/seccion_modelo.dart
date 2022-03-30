import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sunoff/blocs/seccion_bloc.dart';
import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/pages/cotizacion/bloc/cotizacion_bloc.dart';

class SeccionModelo {
  late String uuid;
  late int id;
  late String nombre;
  late bool porVidrio;
  late int conteoMedidas;
  late List<MedidaModel> medidas;
  late List<Pelis> peliculas;
  late double instalador;
  late File? imagen;
  late String pathImage;
  late int pricingId;
  late TextEditingController nombreController;
  late TextEditingController instaladorController;
  late CotizacionBloc bloc;

  SeccionModelo() {
    this.uuid =
        '${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}';
    this.id = 0;
    this.nombre = '';
    this.porVidrio = false;
    this.conteoMedidas = 0;
    this.medidas = [];
    this.peliculas = [];
    this.instalador = 0;
    this.imagen = new File('');
    this.pathImage = '';
    this.pricingId = 0;
    this.nombreController = TextEditingController();
    this.instaladorController = TextEditingController();
    this.bloc = new CotizacionBloc();
  }

  factory SeccionModelo.fromJson(Map<String, dynamic> json) {
    SeccionModelo seccionModelo = new SeccionModelo();
    seccionModelo.id = int.parse((json['id'] ?? 0).toString());
    seccionModelo.nombre = json['name'] ?? '';
    seccionModelo.porVidrio =
        int.parse((json['by_section'] ?? 0).toString()) == 1;
    seccionModelo.conteoMedidas =
        int.parse((json['measures_count'] ?? 0).toString());
    seccionModelo.medidas = ((json['measures'] ?? []) as Iterable)
        .map((item) => MedidaModel.fromJson(item))
        .toList();
    seccionModelo.peliculas = ((json['films'] ?? []) as Iterable)
        .map((item) => Pelis.fromJson(item))
        .toList();
    seccionModelo.instalador =
        double.parse((json['installer'] ?? 0).toString());
    seccionModelo.imagen = json['imagen'] ?? new File('');
    seccionModelo.pathImage = json['image_path'] ?? '';

    return seccionModelo;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "uuid": this.uuid,
      "name": this.nombre,
      "by_section": this.porVidrio.toString(),
      "measures_count": this.conteoMedidas.toString(),
      "installer": this.instalador.toString(),
      "image_path": this.pathImage.toString(),
      "pricing_id": this.pricingId.toString(),
      "films": this.peliculas.map((peli) => peli.toJson()).toList(),
      "measures": this.medidas.map((medidas) => medidas.toJson()).toList(),
    };
  }

  void addGlass() {
    int measuresCount = this.bloc.measuresCount;
    measuresCount++;
    this.bloc.changeMeasuresCount(measuresCount);

    if (this.bloc.isSwitched) {
      List<MedidaModel> medidas = this.bloc.medidas;
      medidas.add(MedidaModel.fromJson({}));

      this.bloc.changeMedidas(medidas);
    }
  }

  void deleteGlass() {
    int measuresCount = this.bloc.measuresCount;

    if (measuresCount > 1) {
      measuresCount--;
      this.bloc.changeMeasuresCount(measuresCount);

      if (this.bloc.isSwitched) {
        List<MedidaModel> medidas = this.bloc.medidas;
        medidas.removeLast();

        this.bloc.changeMedidas(medidas);
      }
    }
  }

  void switchForSecction(bool value) {
    this.bloc.changeisSwitched(value);
    List<MedidaModel> medidas = [];

    if (value) {
      for (int i = 0; i < this.bloc.measuresCount; i++) {
        medidas.add(MedidaModel.fromJson({}));
      }

      this.bloc.changeMedidas(medidas);
    } else {
      medidas.add(MedidaModel.fromJson({}));
      this.bloc.changeMedidas(medidas);
    }
  }

  void addFilms(List<Pelis> films) {
    int currentFilm = this.bloc.peli;
    List<Pelis> currentFilms = this.bloc.peliculas;

    if (currentFilms.where((element) => element.id == currentFilm).length >=
        1) {
      throw ('Pelicula Repetida');
    }

    Pelis selectedFilm =
        films.firstWhere((element) => element.id == currentFilm);

    currentFilms.add(selectedFilm);
    this.bloc.changePeliculas(currentFilms);
  }

  void getImage(final _picker) async {
    var pickedFile;
    pickedFile = await _picker.getImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

    if (pickedFile != null) {
      this.bloc.changeImagen(new File(pickedFile.path));
      this.imagen = this.bloc.imagen;
    }
  }
}
