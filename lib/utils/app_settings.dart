import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunoff/colors/light_colors.dart';

class AppSettings {
  String? apiUrl;

  late ThemeData? appTheme;
  late List<Locale>? locales;
  late Map<String, String>? headers;

  AppSettings() {
    this.apiUrl = '192.168.0.22:90';
    this.appTheme = ThemeData(
        primaryColor: PColors.pLightBlue,
        primaryColorDark: PColors.pDarkBlue,
        primaryColorLight: Colors.blue[50],
        backgroundColor: Colors.white,
        secondaryHeaderColor: Colors.blueGrey[50],
        accentColor: Colors.white,
        fontFamily: 'Montserrat');
    this.locales = [const Locale('es')];
    this.headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  }

  DateFormat get dateFormat {
    return new DateFormat('dd/MMMM/yyyy', 'es_MX');
  }

  DateFormat get weekdayFormat {
    return new DateFormat('E', 'es_MX');
  }

  DateFormat get hourNow {
    return new DateFormat('Hm', 'es_MX');
  }
}
