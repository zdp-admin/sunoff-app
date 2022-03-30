import 'package:sunoff/models/cotizacion/cliente_modelo.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/models/cotizacion/type_building.dart';

class CotizacionModel {
  late int id;
  late DateTime date;
  late ClienteModelo cliente;
  late List<SeccionModelo> secciones;
  late String comentario;
  late int buildingTypeId;
  late int clientId;
  late TypeBuilding typeBuilding;
  late int userId;
  List<Pelis> films = [];

  CotizacionModel() {
    this.id = 0;
    this.date = DateTime.now();
    this.cliente = ClienteModelo.fromJson({});
    this.secciones = [];
    this.comentario = '';
    this.buildingTypeId = 0;
    this.clientId = 0;
    this.typeBuilding = TypeBuilding.fromJson({});
    this.userId = 0;
  }

  factory CotizacionModel.fromJson(Map<String, dynamic> json) {
    CotizacionModel cotizacionModel = CotizacionModel();
    cotizacionModel.id = int.parse((json['id'] ?? 0).toString());
    cotizacionModel.date = DateTime.parse((json['created_at'] ?? '0000-00-00'));
    cotizacionModel.cliente = ClienteModelo.fromJson(json['client'] ?? {});
    cotizacionModel.secciones = ((json['sections'] ?? []) as Iterable)
        .map((item) => SeccionModelo.fromJson(item))
        .toList();
    cotizacionModel.comentario = json['comentary'] ?? '';
    cotizacionModel.buildingTypeId =
        int.parse((json['building_type_id'] ?? 0).toString());
    cotizacionModel.typeBuilding =
        TypeBuilding.fromJson(json['building_type'] ?? {});
    cotizacionModel.clientId = int.parse((json['clientId'] ?? 0).toString());
    cotizacionModel.userId = int.parse((json['user_id'] ?? 0).toString());

    return cotizacionModel;
  }

  Map<String, dynamic> toJson() {
    return {
      "building_type_id": this.buildingTypeId.toString(),
      "comentary": this.comentario,
      "client": this.cliente.toJson(),
      "sections": this.secciones.map((section) => section.toJson()).toList(),
      "client_id": this.clientId.toString(),
    };
  }
}
