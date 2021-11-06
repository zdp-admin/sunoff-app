import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunoff/models/jwt_modelo.dart';
import 'package:sunoff/utils/decode_jwt.dart';

class PreferencesUser {
  static final PreferencesUser _instance = new PreferencesUser._internal();

  factory PreferencesUser() {
    return _instance;
  }

  PreferencesUser._internal();
  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  int get id => _prefs.getInt('id') ?? 0;
  set id(int value) => _prefs.setInt('id', value);

  String get name => _prefs.getString('name') ?? '';

  set name(String value) => _prefs.setString('name', value);

  bool get logged {
    return _prefs.getBool('logged') ?? false;
  }

  set logged(bool value) {
    _prefs.setBool('logged', value);
  }

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  String get activeRoute {
    return _prefs.getString('active_route') ?? '';
  }

  set activeRoute(String value) {
    _prefs.setString('active_route', value);
  }

  void loggout() {
    _prefs.clear();
  }

  JwtModelo me() {
    var jwtObject = parseJwt(this.token);
    JwtModelo userToken = JwtModelo.fromJson(jwtObject!);

    return userToken;
  }
}
