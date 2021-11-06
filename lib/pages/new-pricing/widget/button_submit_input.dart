import 'package:flutter/material.dart';
import 'package:sunoff/pages/new-pricing/bloc_new_pricing/new_pricing_bloc.dart';

Widget buttonSubmitInput(NewPricingBloc bloc, Function submit) {
  return StreamBuilder(
      stream: bloc.loadingStream,
      builder: (BuildContext ctxLoading, AsyncSnapshot shpLoading) {
        return StreamBuilder(
            stream: bloc.formValidStream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return Opacity(
                  opacity: snapshot.hasData ? 1 : .5,
                  child: ElevatedButton(
                      onPressed: snapshot.hasData ? () => submit() : null,
                      child: Text(
                        'Continuar',
                        style: TextStyle(fontSize: 18),
                      )));
            });
      });
}
