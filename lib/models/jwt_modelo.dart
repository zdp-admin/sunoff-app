import 'package:sunoff/models/user.dart';

class JwtModelo {
  late String iss;
  late int iat;
  late int nbf;
  late String jti;
  late int sub;
  late String prv;
  late User user;

  JwtModelo() {
    this.iss = '';
    this.iat = 0;
    this.nbf = 0;
    this.jti = '';
    this.sub = 0;
    this.prv = '';
    this.user = new User();
  }

  factory JwtModelo.fromJson(Map<String, dynamic> json) {
    JwtModelo jwtModelo = new JwtModelo();
    jwtModelo.iss = json['iss'] ?? '';
    jwtModelo.iat = int.parse((json['iat'] ?? 0).toString());
    jwtModelo.nbf = int.parse((json['nbf'] ?? 0).toString());
    jwtModelo.jti = json['jti'] ?? '';
    jwtModelo.sub = int.parse((json['sub'] ?? 0).toString());
    jwtModelo.prv = json['prv'] ?? '';
    jwtModelo.user = User.fromJson(json['user'] ?? {});
    return jwtModelo;
  }
}
