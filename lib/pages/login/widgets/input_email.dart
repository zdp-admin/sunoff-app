import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/pages/login/bloc/login_bloc.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';

Widget inputEmail(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextField(
        keyboardType: TextInputType.emailAddress,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.person_outline, color: Colors.blue[900]),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            filled: true,
            fillColor: appService<AppSettings>().appTheme!.accentColor,
            alignLabelWithHint: false,
            labelText: 'Usuario',
            errorText: snapshot.error as String?,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        onChanged: bloc.changeEmail,
      );
    },
  );
}
