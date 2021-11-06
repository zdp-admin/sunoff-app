import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget cinputName(SeccionModelo seccion) {
  return StreamBuilder(
    stream: seccion.bloc.nameStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return TextField(
          controller: seccion.nombreController,
          decoration: InputDecoration(
              labelText: 'Nombre de Sección',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.4,
                      color: Colors.grey,
                      style: BorderStyle.solid)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              errorText: snp.hasError ? snp.error.toString() : null),
          onChanged: (String value) {
            seccion.bloc.changeName(value);
          });
    },
  );
}
