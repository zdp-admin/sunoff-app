import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/pages/cotizacion/bloc/cotizacion_bloc.dart';

Widget cinputBySection(
    CotizacionBloc bloc,
    TextEditingController altoController,
    TextEditingController anchoController) {
  return StreamBuilder(
      stream: bloc.medidasStream,
      builder: (BuildContext ctx, AsyncSnapshot<List<MedidaModel>> snp) {
        return Container(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Total: ',
                          style: TextStyle(fontSize: 20),
                        )),
                    Flexible(
                      flex: 2,
                      child: TextField(
                        controller: altoController,
                        onChanged: (String value) {
                          List<MedidaModel> section = bloc.medidas;
                          section = double.parse(value) as List<MedidaModel>;
                          bloc.changeMedidas(section);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            labelText: 'Alto',
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText:
                                snp.hasError ? snp.error.toString() : null),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 2,
                      child: TextField(
                        controller: anchoController,
                        onChanged: (String value) {
                          List<MedidaModel> section = bloc.medidas;
                          section = double.parse(value) as List<MedidaModel>;
                          bloc.changeMedidas(section);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            isDense: true,
                            labelText: 'Ancho',
                            border: OutlineInputBorder(),
                            errorText:
                                snp.hasError ? snp.error.toString() : null),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                      ),
                    ),
                  ],
                )));
      });
}
