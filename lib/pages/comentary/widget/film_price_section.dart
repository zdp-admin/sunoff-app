import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/pages/comentary/bloc/comentary_bloc.dart';

Widget rowPrice(ComentaryBloc bloc, List<Pelis> film) {
  return StreamBuilder<Object>(
      stream: bloc.priceForSeccionStream,
      builder: (context, snapshot) {
        return Column(
          children: film
              .map((e) => Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Expanded(
                            child: Text(e.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, color: PColors.pLightBlue))),
                        Container(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: false),
                              decoration: InputDecoration(
                                  labelText: 'Precio',
                                  prefix: Text('\$ '),
                                  suffix: Text('MXN')),
                              onChanged: (value) {
                                e.priceForSection = double.parse(value);
                                bloc.changePriceForSeccion(double.parse(value));
                              },
                            )),
                      ])))
              .toList(),
        );
      });
}
