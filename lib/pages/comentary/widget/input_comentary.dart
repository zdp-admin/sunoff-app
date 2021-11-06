import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/pages/comentary/bloc/comentary_bloc.dart';

Widget inputComentary(ComentaryBloc bloc) {
  return StreamBuilder(
    stream: bloc.comentaryStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: TextField(
              minLines: 8,
              maxLines: 10,
              decoration: InputDecoration(
                  labelText: 'Comentarios',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder()),
              onChanged: (String value) => bloc.changeComentary(value)));
    },
  );
}
