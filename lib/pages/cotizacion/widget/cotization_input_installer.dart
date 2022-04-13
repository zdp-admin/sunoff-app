import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget cinputInstaller(SeccionModelo section) {
  return StreamBuilder(
    stream: section.bloc.instaladorStream,
    builder: (BuildContext context, AsyncSnapshot snp) {
      return TextField(
          controller: section.instaladorController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: 'Instalador',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.4,
                      color: Colors.grey,
                      style: BorderStyle.solid)),
              border: OutlineInputBorder(),
              errorText: snp.hasError ? snp.error.toString() : null,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 16)),
          onChanged: (String value) {
            double install = section.bloc.instalador;
            install = double.parse(value);
            section.bloc.changeInstalador(install);
          });
    },
  );
}
