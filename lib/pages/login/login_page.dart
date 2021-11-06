import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/pages/login/bloc/login_bloc.dart';
import 'package:sunoff/pages/login/service/login_service.dart';
import 'package:sunoff/pages/login/widgets/button_submit.dart';
import 'package:sunoff/pages/login/widgets/input_email.dart';
import 'package:sunoff/pages/login/widgets/input_password.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/preference_user.dart';

import '../../services/setup_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PreferencesUser pref = new PreferencesUser();
  @override
  void initState() {
    super.initState();
    pref.activeRoute = 'login';
  }

  final LoginBloc formControl = LoginBloc();

  void submit(LoginBloc bloc, BuildContext context) {
    bloc.changeLoading(true);

    appService<LoginService>().auth(bloc.email, bloc.password).then((value) {
      if (value) {
        appService<NavigationService>().navigateToAndRemoveHistory('profile');
      } else {
        this.showAlert(context, 'Error',
            'Usuario o contraseña incorrecto.\nPor favor verifique los datos');
      }
    }).catchError((onError) {
      this.showAlert(
          context,
          'Error',
          onError is String
              ? onError
              : 'Ocurrió un error, por favor intenta más tarde');
    }).whenComplete(() {
      bloc.changeLoading(false);
    });
  }

  void showAlert(BuildContext context, String title, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
            ));
  }

  double widthImage(BuildContext context) {
    var width = MediaQuery.of(context).size.width * .8;
    return width > 400 ? 400 : width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(40),
                padding: EdgeInsets.only(bottom: 0),
                child: Center(
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/SunOff.png'),
                        fit: BoxFit.contain,
                      ),
                      Divider(
                        height: 35,
                      ),
                      Text(
                        'INICIAR SESIÓN',
                        style:
                            TextStyle(color: PColors.pLightBlue, fontSize: 30),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 10),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: inputEmail(formControl)),
            SizedBox(height: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: inputPassword(formControl)),
            SizedBox(height: 30),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: buttonSubmit(formControl, submit, context))
          ],
        ),
      )),
    );
  }
}
