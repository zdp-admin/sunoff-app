import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget cPeliculasSelect(
    SeccionModelo section, List<Pelis> pelis, Function(SeccionModelo) addPeli) {
  return StreamBuilder(
    stream: section.bloc.peliStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder()),
                isExpanded: true,
                hint: Text('Peliculas'),
                value: snapshot.hasData ? snapshot.data : null,
                onChanged: (value) => section.bloc.changePeli(value!),
                items: pelis.map((valueItems) {
                  return DropdownMenuItem(
                      value: valueItems.id, child: Text(valueItems.name));
                }).toList(),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              decoration: ShapeDecoration(
                  color: Colors.green[300], shape: CircleBorder()),
              child: InkWell(
                child: IconButton(
                    onPressed: () => addPeli(section),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      );
    },
  );
}
