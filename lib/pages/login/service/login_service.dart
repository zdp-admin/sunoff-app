import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sunoff/models/auth_response.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';

import 'package:http/http.dart' as http;

class LoginService {
  String? apiUrl;
  late PreferencesUser pref;
  Map<String, String>? headers;
  String? unencodedPath = '';

  LoginService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
    this.headers = appService<AppSettings>().headers;
    this.pref = new PreferencesUser();
  }

  Future<bool> auth(String email, String password) async {
    var bytesToken = utf8.encode('${password}u420qwd');
    var token = sha1.convert(bytesToken).toString();

    var body = new Map<String, String>();
    body['email'] = email;
    body['password'] = password;
    body['token'] = token;
    body['uuid'] = '45a8477ac5594f611233f13a21614f8af981e5e6';

    Uri url = new Uri.https('${this.apiUrl}', '/public/auth/login');

    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      AuthResponse objResponse =
          AuthResponse.fromJson(jsonDecode(response.body));

      this.pref.logged = true;
      this.pref.token = objResponse.accessToken;

      return true;
    }

    throw ('Error al iniciar sesión');
  }
}
