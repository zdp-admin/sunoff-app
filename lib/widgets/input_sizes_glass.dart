import 'package:flutter/material.dart';

Widget sizesInput(
  //int index,
  TextEditingController name,
  TextEditingController alto,
  TextEditingController ancho,
  /*Function(int) delete*/
) {
  return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Vidrio'),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: TextField(
                  controller: alto,
                  decoration: InputDecoration(
                      labelText: 'Alto',
                      border: OutlineInputBorder(),
                      isDense: true),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: TextField(
                  controller: ancho,
                  decoration: InputDecoration(
                      labelText: 'Ancho',
                      border: OutlineInputBorder(),
                      isDense: true),
                  keyboardType: TextInputType.number,
                ),
              ),
              /*GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      delete(index);
                    },
                  )*/
            ],
          )));
}
