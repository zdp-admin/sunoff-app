import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/pages/new-pricing/bloc_new_pricing/new_pricing_bloc.dart';

Widget inputAddress(NewPricingBloc bloc) {
  return StreamBuilder(
    stream: bloc.addressStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
              decoration: InputDecoration(
                  labelText: 'Dirección',
                  helperText: 'Calle No, Colonia, Ciudad, Estado.',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.4,
                          color: Colors.grey,
                          style: BorderStyle.solid)),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  errorText: snp.hasError ? snp.error.toString() : null),
              onChanged: (String value) => bloc.changeAddress(value)));
    },
  );
}
