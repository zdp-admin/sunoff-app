import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

Widget glassCounter(SeccionModelo seccion) {
  return StreamBuilder(
    stream: seccion.bloc.measuresCountStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                'Vidrios',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Ink(
                      decoration: ShapeDecoration(
                          color: Colors.green[300], shape: CircleBorder()),
                      child: IconButton(
                          constraints:
                              BoxConstraints(maxWidth: 40, maxHeight: 40),
                          onPressed: seccion.deleteGlass,
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${snapshot.hasData ? snapshot.data : 1}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    child: Ink(
                      decoration: ShapeDecoration(
                          color: Colors.green[300], shape: CircleBorder()),
                      child: IconButton(
                          constraints:
                              BoxConstraints(maxWidth: 40, maxHeight: 40),
                          onPressed: seccion.addGlass,
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
