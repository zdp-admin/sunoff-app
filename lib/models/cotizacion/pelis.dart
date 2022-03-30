import 'package:sunoff/models/cotizacion/image_film.dart';

class Pelis {
  late int id;
  late String name;
  late double price;
  late double priceForSection;
  late String description;
  late int filmCategoryId;
  late List<ImageFilm> images;

  Pelis() {
    this.id = 0;
    this.name = '';
    this.price = 0;
    this.priceForSection = 0;
    this.description = '';
    this.images = [];
    this.filmCategoryId = 0;
  }

  factory Pelis.fromJson(Map<String, dynamic> json) {
    Pelis peli = new Pelis();

    peli.id = int.parse((json['id'] ?? 0).toString());
    peli.name = json['name'] ?? '';
    peli.price = double.parse((json['price'] ?? 0).toString());

    if (json['pivot'] != null) {
      peli.priceForSection =
          double.parse((json['pivot']['price'] ?? 0).toString());
    }

    peli.description = json['description'] ?? '';
    peli.filmCategoryId = int.parse((json['film_category_id'] ?? 0).toString());
    peli.images = ((json['images'] ?? []) as Iterable)
        .map((image) => ImageFilm.fromJson(image))
        .toList();

    return peli;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "name": this.name,
      "price": this.price.toString(),
      "price_for_section": this.priceForSection.toString(),
      "description": this.description,
      "film_category_id": this.filmCategoryId.toString(),
    };
  }
}
