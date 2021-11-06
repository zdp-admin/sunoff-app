import 'package:flutter/material.dart';
import 'package:sunoff/pages/comentary/bloc/comentary_bloc.dart';

Widget buttonSubmitInputB(ComentaryBloc bloc, Function submit) {
  return StreamBuilder(
      stream: bloc.loadingStream,
      builder: (BuildContext ctxLoading, AsyncSnapshot shpLoading) {
        return StreamBuilder(
            stream: bloc.comentaryStream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return ElevatedButton(
                  onPressed: () => submit(),
                  child: Text(
                    'Guardar',
                    style: TextStyle(fontSize: 18),
                  ));
            });
      });
}
