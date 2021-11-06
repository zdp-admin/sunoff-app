class ClienteModelo {
  late int id;
  late String name;
  late String address;

  ClienteModelo({this.id = 0, this.name = '', this.address = ''});

  factory ClienteModelo.fromJson(Map<String, dynamic> json) {
    ClienteModelo cliente = new ClienteModelo();
    cliente.id = int.parse((json['id'] ?? 0).toString());
    cliente.name = json['name'] ?? '';
    cliente.address = json['address'] ?? '';
    return cliente;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "name": this.name,
      "address": this.address,
    };
  }
}
