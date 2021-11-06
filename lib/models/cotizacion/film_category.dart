class FilmCategory {
  late int id;
  late String name;
  late String code;

  FilmCategory() {
    this.id = 0;
    this.name = '';
    this.code = '';
  }

  factory FilmCategory.fromJson(Map<String, dynamic> json) {
    FilmCategory filmCategory = new FilmCategory();
    filmCategory.id = int.parse((json['id'] ?? 0).toString());
    filmCategory.name = json['name'] ?? '';
    filmCategory.code = json['code'] ?? '';
    return filmCategory;
  }

  Map<String, dynamic> toJson() {
    return {"id": this.id.toString(), "name": this.name, "code": this.code};
  }
}
