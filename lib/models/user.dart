class User {
  late int id;
  late String name;
  late String surname;
  late String shortname;
  late String email;
  late String contactEmail;
  late String phone;

  User({
    this.id = 0,
    this.name = '',
    this.surname = '',
    this.shortname = '',
    this.email = '',
    this.contactEmail = '',
    this.phone = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse((json['id'] ?? 0).toString()),
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      shortname: json['short_name'] ?? '',
      email: json['email'] ?? '',
      contactEmail: json['contact_email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
