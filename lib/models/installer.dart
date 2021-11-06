import 'package:flutter/cupertino.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';

class InstallerModel {
  int id;
  String address;
  int assistant;
  int typeBuilding;
  String timeIn;
  String timeOut;
  int glassesInstalled;
  double mtsInstalled;
  List<Pelis> films;
  String commentary;
  int installer;

  late TextEditingController nameController;
  late TextEditingController comentaryController;
  late TextEditingController installerController;

  InstallerModel({
    this.id = 0,
    this.address = '',
    this.assistant = 0,
    this.typeBuilding = 0,
    this.timeIn = '',
    this.timeOut = '',
    this.glassesInstalled = 0,
    this.mtsInstalled = 0,
    required this.films,
    this.commentary = '',
    this.installer = 0,
  }) {
    this.nameController = new TextEditingController(text: this.address);
    this.comentaryController = new TextEditingController(text: this.commentary);
    this.installerController =
        new TextEditingController(text: this.installer.toString());
  }

  factory InstallerModel.fromJson(Map<String, dynamic> json) {
    InstallerModel installerModel = new InstallerModel(films: []);
    installerModel.id = int.parse((json['id'] ?? 0).toString());
    installerModel.address = json['address'] ?? '';
    installerModel.assistant = int.parse((json['assistant'] ?? 0).toString());
    installerModel.typeBuilding =
        int.parse((json['type_building'] ?? 0).toString());
    installerModel.timeIn = json['time_in'] ?? '';
    installerModel.timeOut = json['time_out'] ?? '';
    installerModel.glassesInstalled =
        int.parse((json['glasses_installed'] ?? 0).toString());
    installerModel.mtsInstalled =
        double.parse((json['glasses_installed'] ?? 0).toString());
    installerModel.films = ((json['films'] ?? []) as Iterable)
        .map((images) => Pelis.fromJson(images))
        .toList();

    return installerModel;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "address": this.address,
      "assistant": this.assistant.toString(),
      "type_building": this.typeBuilding.toString(),
      "time_in": this.timeIn,
      "time_out": this.timeIn,
      "glasses_installed": this.glassesInstalled.toString(),
      "mts_installed": this.mtsInstalled.toString(),
      "films": this.films.map((films) => films.toJson()).toList(),
      "commentary": this.commentary,
    };
  }
}
