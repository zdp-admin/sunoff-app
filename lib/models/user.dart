class User {
  late int id;
  late String name;
  late String email;

  User({this.id = 0, this.name = '', this.email = ''});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: int.parse((json['id'] ?? 0).toString()),
        name: json['name'] ?? '',
        email: json['email'] ?? '');
  }
}
