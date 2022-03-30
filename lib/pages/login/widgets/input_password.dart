import 'package:flutter/material.dart';
import 'package:sunoff/pages/login/bloc/login_bloc.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';

Widget inputPassword(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
        enableSuggestions: false,
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.lock_outlined, color: Colors.blue[900]),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            filled: true,
            fillColor: appService<AppSettings>().appTheme!.accentColor,
            labelText: 'Contraseña',
            errorText: snapshot.error as String?,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.white, style: BorderStyle.solid, width: 2))),
        onChanged: bloc.changePassword,
      );
    },
  );
}
