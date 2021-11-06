import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:sunoff/pages/login/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'login':
      return MaterialPageRoute(
          builder: (context) => LoginPage(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => Container(), settings: settings);
  }
}
