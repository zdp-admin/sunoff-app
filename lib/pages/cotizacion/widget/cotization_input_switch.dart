import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget inputSwitch(SeccionModelo seccion) {
  return StreamBuilder(
    stream: seccion.bloc.isSwitchedStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text('Por Seccion'),
          ),
          Container(
            child: Switch(
              value: seccion.bloc.isSwitched,
              onChanged: seccion.switchForSecction,
              inactiveTrackColor: Colors.black12,
              activeTrackColor: Colors.black12,
              activeColor: PColors.pLightBlue,
              inactiveThumbColor: PColors.pLightBlue,
            ),
          ),
          Container(
            child: Text('Por vidrio'),
          )
        ],
      );
    },
  );
}
