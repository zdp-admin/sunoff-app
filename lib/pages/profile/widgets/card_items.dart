import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:flutter/material.dart';

Widget cardItems(BuildContext context, IconData icon, String label) {
  return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 75,
      // decoration: new BoxDecoration(
      //     border: Border.all(width: 1.5, color: PColors.pLightBlue),
      //     borderRadius: BorderRadius.circular(13.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 50,
              color: appService<AppSettings>().appTheme!.primaryColor,
            ),
          ),
          VerticalDivider(),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 50),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ))
        ],
      ));
}
