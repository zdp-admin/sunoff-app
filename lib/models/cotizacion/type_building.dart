class TypeBuilding {
  late int id;
  late String name;

  TypeBuilding({this.id = 0, this.name = ''});

  factory TypeBuilding.fromJson(Map<String, dynamic> json) {
    TypeBuilding buildingType = new TypeBuilding();
    buildingType.id = int.parse((json['id'] ?? 0).toString());
    buildingType.name = json['name'] ?? '';

    return buildingType;
  }
}
