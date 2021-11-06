import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/pages/login/bloc/login_bloc.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';

Widget buttonSubmit(LoginBloc bloc, Function(LoginBloc, BuildContext) submit,
    BuildContext context) {
  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: StreamBuilder(
              stream: bloc.loadingStream,
              builder: (BuildContext ctx, AsyncSnapshot sht) {
                return !sht.hasData || sht.data
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
                    : Center(
                        child: Text(
                        'INGRESAR',
                        style: TextStyle(color: PColors.pDarkBlue),
                      ));
              }),
        ),
        style: ElevatedButton.styleFrom(
            textStyle: TextStyle(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            side: BorderSide(
                width: 1.0,
                color: appService<AppSettings>().appTheme!.primaryColor),
            elevation: 4.0,
            primary: Colors.blue[300], // color when button is available
            onSurface: Colors.white), // color when button is disabled
        onPressed: snapshot.hasData && !bloc.loading
            ? () => submit(bloc, context)
            : null,
      );
    },
  );
}
