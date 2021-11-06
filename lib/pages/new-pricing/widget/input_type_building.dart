import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/models/cotizacion/type_building.dart';
import 'package:sunoff/pages/new-pricing/bloc_new_pricing/new_pricing_bloc.dart';

Widget inputTypeBuilding(
    NewPricingBloc bloc, List<TypeBuilding> typeConstruction) {
  return StreamBuilder(
    stream: bloc.typeBuildingStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black38),
              borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            underline: SizedBox(),
            isExpanded: true,
            hint: Text('Tipo de Construcción'),
            value: snp.hasData ? snp.data : null,
            onChanged: (value) => bloc.changetypeBuilding(value as int),
            items: typeConstruction.map((valueItems) {
              return DropdownMenuItem(
                value: valueItems.id,
                child: Text(valueItems.name),
              );
            }).toList(),
          ));
    },
  );
}
