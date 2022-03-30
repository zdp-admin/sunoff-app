import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget cinputPorSeccion(SeccionModelo seccion) {
  return StreamBuilder(
      stream: seccion.bloc.medidasStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<MedidaModel> medidas = snapshot.hasData ? snapshot.data : [];
        return Wrap(
            runSpacing: 10,
            children: medidas
                .asMap()
                .entries
                .map((medida) => Row(children: [
                      Expanded(
                        flex: 2,
                        child: StreamBuilder(
                          stream: seccion.bloc.isSwitchedStream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Container(
                              child: Text(
                                  !seccion.bloc.isSwitched
                                      ? 'Total: '
                                      : 'Vidrio ${medida.key + 1}',
                                  style: TextStyle(fontSize: 20)),
                            );
                          },
                        ),
                      ),
                      Flexible(
                          flex: 2,
                          child: TextField(
                            onChanged: (value) {
                              List<MedidaModel> list = seccion.bloc.medidas;
                              list[medida.key].ancho = double.parse(value);
                              seccion.bloc.changeMedidas(list);
                            },
                            keyboardType: TextInputType.number,
                            controller: medida.value.anchoController,
                            decoration: InputDecoration(
                                labelText: 'Ancho en mts',
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12)),
                          )),
                      SizedBox(width: 20),
                      Flexible(
                          flex: 2,
                          child: TextField(
                            onChanged: (value) {
                              List<MedidaModel> list = seccion.bloc.medidas;
                              list[medida.key].alto = double.parse(value);
                              seccion.bloc.changeMedidas(list);
                            },
                            keyboardType: TextInputType.number,
                            controller: medida.value.altoController,
                            decoration: InputDecoration(
                                labelText: 'Alto en mts',
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12)),
                          )),
                    ]))
                .toList());
      });
}
