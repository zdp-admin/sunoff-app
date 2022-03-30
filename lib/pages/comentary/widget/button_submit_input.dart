import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/pages/comentary/bloc/comentary_bloc.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';

Widget buttonSubmitInputB(
    ComentaryBloc bloc, Function() submit, List<Pelis> films) {
  return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext ctxLoading, AsyncSnapshot snp) {
        return StreamBuilder(
            stream: bloc.loadingStream,
            builder: (BuildContext ctx, AsyncSnapshot snpL) {
              return !snpL.hasData || snpL.data
                  ? Align(
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation(
                                  appService<AppSettings>()
                                      .appTheme!
                                      .primaryColorLight))),
                    )
                  : Opacity(
                      opacity:
                          films.any((element) => (element.priceForSection == 0))
                              ? 0.5
                              : 1,
                      child: ElevatedButton(
                          onPressed: films.any(
                                  (element) => (element.priceForSection == 0))
                              ? null
                              : () => submit(),
                          child: Text(
                            'Guardar',
                            style: TextStyle(fontSize: 18),
                          )));
            });
      });
}
