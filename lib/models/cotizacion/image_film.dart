class ImageFilm {
  late int id;
  late int filmId;
  late String pathImage;
  late String linkImage;

  ImageFilm() {
    this.id = 0;
    this.filmId = 0;
    this.pathImage = '';
    this.linkImage = '';
  }

  factory ImageFilm.fromJson(Map<String, dynamic> json) {
    ImageFilm imagePeli = new ImageFilm();
    imagePeli.id = int.parse((json['id'] ?? 0).toString());
    imagePeli.filmId = int.parse((json['film_id'] ?? 0).toString());
    imagePeli.pathImage = json['path_image'] ?? '';
    imagePeli.linkImage = json['link_image'] ?? '';
    return imagePeli;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "film_id": this.filmId.toString(),
      "path_image": this.pathImage,
      "link_image": this.linkImage,
    };
  }
}
