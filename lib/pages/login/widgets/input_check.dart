import 'package:flutter/material.dart';
import 'package:sunoff/pages/login/bloc/login_bloc.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';

Widget inputCheck(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.termAndConditionsStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Theme(
                data: Theme.of(context)
                    .copyWith(unselectedWidgetColor: Colors.black),
                child: Checkbox(
                  value: snapshot.data ?? false,
                  onChanged: (bool? value) =>
                      bloc.changeTermAndConditions(value ?? false),
                  checkColor: Colors.white,
                  activeColor: appService<AppSettings>().appTheme!.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  appService<NavigationService>()
                      .navigateTo('notice-privacity', arguments: true);
                },
                child: Text('Acepto el aviso de privacidad',
                    style: TextStyle(color: Colors.black)),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(snapshot.error as String,
                    style: TextStyle(color: Colors.red, fontSize: 11))),
          )
        ],
      );
    },
  );
}
