import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class General {
  selectDate(BuildContext context, DateTime dateInitial,
      Function(DateTime) change, DateTime lastDate) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: dateInitial,
        firstDate: DateTime(1993),
        lastDate: lastDate,
        locale: const Locale("es", "MX"),
        builder: (BuildContext ctx, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
            ),
            child: child!,
          );
        });

    if (date != null) {
      change(date);
    }
  }

  selectTime(BuildContext context, Function(TimeOfDay) change) async {
    final TimeOfDay? date = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext ctx, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
            ),
            child: child!,
          );
        });

    if (date != null) {
      change(date);
    }
  }

  //--------------------------------?????????????????---------------------------
  // double calculateDistance(double currentLat, double currentLong, double lat,
  //     double long, String type) {
  //   var radioLatCurrent = pi * currentLat / 180;
  //   var radioLat = pi * lat / 180;
  //   var longResult = currentLong - long;
  //   var radioLongResult = pi * longResult / 180;
  //   var distance = sin(radioLatCurrent) * sin(radioLat) +
  //       cos(radioLatCurrent) * cos(radioLat) * cos(radioLongResult);

  //   distance = (acos(distance) * 180 / pi) * 60 * 1.1515;

  //   if (type == "K") {
  //     distance *= 1609.344;
  //   }

  //   if (type == "N") {
  //     distance *= 0.8684;
  //   }

  //   return distance > 2000 ? distance / 1000 : distance;
  // }

  void showAlert(BuildContext context, String title, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(message, textAlign: TextAlign.center),
            ));
  }
}
