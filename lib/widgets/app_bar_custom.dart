import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/setup_service.dart';
import '../utils/app_settings.dart';

AppBar appBarCustom(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
  return AppBar(
    elevation: 3,
    backgroundColor: Theme.of(context).primaryColor,
    iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Image(
                image: AssetImage('assets/images/SunOffwt.png'),
                width: 50,
                height: 50),
            Text(
              appService<AppSettings>().dateFormat.format(DateTime.now()),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 10),
          ],
        ),
      )
    ],
  );
}
