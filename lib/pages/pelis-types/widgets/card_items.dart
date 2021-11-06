import 'package:sunoff/colors/light_colors.dart';
import 'package:flutter/material.dart';

Widget cardItems(BuildContext context, String code, String label) {
  late IconData icon;

  switch (code) {
    case '01':
      icon = Icons.thermostat;
      break;
    case '02':
      icon = Icons.security;
      break;
    default:
      icon = Icons.window;
  }

  return Container(
      padding: EdgeInsets.only(left: 7),
      width: MediaQuery.of(context).size.width * .8,
      height: 75,
      decoration: new BoxDecoration(
          border: Border.all(width: 1.5, color: PColors.pLightBlue),
          borderRadius: BorderRadius.circular(13.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 50,
              color: PColors.pLightBlue,
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 50),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: PColors.pDarkBlue),
            ),
          ))
        ],
      ));
}
