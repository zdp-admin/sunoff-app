import 'package:flutter/material.dart';

class MedidaModel {
  late int id;
  late String nombre;
  late double alto;
  late double ancho;
  late int sectionId;
  late TextEditingController altoController;
  late TextEditingController anchoController;

  MedidaModel(
      {this.id = 0,
      this.nombre = '',
      this.alto = 0,
      this.ancho = 0,
      this.sectionId = 0}) {
    this.altoController = new TextEditingController(text: '');
    this.anchoController = new TextEditingController(text: '');
  }

  factory MedidaModel.fromJson(Map<String, dynamic> json) {
    MedidaModel medidaModel = new MedidaModel();
    medidaModel.id = int.parse((json['id'] ?? 0).toString());
    medidaModel.alto = double.parse((json['height'] ?? 0).toString());
    medidaModel.ancho = double.parse((json['width'] ?? 0).toString());
    return medidaModel;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "name": this.nombre,
      "height": this.alto.toString(),
      "width": this.ancho.toString(),
    };
  }
}
