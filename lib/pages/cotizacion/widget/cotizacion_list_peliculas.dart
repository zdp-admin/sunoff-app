import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget cListPeliculas(SeccionModelo section) {
  return StreamBuilder(
    stream: section.bloc.peliculasStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      List<Pelis> pelis = snapshot.hasData ? snapshot.data : [];

      return Container(
        child: Column(
            children: pelis
                .asMap()
                .entries
                .map((peli) => Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1))),
                      child: ListTile(
                        title: Text(
                          'Película ${peli.value.name}',
                          style: TextStyle(color: PColors.pLightBlue),
                        ),
                        leading: Icon(Icons.window),
                        trailing: Icon(
                          Icons.done,
                          color: PColors.pLightBlue,
                        ),
                      ),
                    ))
                .toList()),
      );
    },
  );
}
