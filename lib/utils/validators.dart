import 'dart:async';

import 'package:sunoff/models/cotizacion/medida_model.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

class Validators {
  final validEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern as String);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es valido');
    }
  });

  final validPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 0) {
      sink.add(password);
    } else {
      sink.addError('Ingrese una contraseña');
    }
  });

  final validateEmpty =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length > 0 && value != '') {
      sink.add(value);
    } else {
      sink.addError('El campo es requerido');
    }
  });

  final validateGlassesCount =
      StreamTransformer<double, double>.fromHandlers(handleData: (value, sink) {
    if (value > 0.0) {
      sink.add(value);
    } else {
      sink.addError('Ingrese la cantidad de vidrios');
    }
  });

  final validateInstaller =
      StreamTransformer<double, double>.fromHandlers(handleData: (value, sink) {
    Pattern pattern = r'^\d*(\.\d+)?$';
    RegExp regExp = new RegExp(pattern as String);

    if (regExp.hasMatch(value.toString())) {
      var valdouble = double.parse(value.toString());
      if (valdouble > 0) {
        sink.add(value);
      } else {
        sink.addError('Ingrese un instalador');
      }
    } else {
      sink.addError('Agregue un número válido');
    }
  });

  final validatedouble =
      StreamTransformer<double, double>.fromHandlers(handleData: (value, sink) {
    Pattern pattern = r'^\d*(\.\d+)?$';
    RegExp regExp = new RegExp(pattern as String);

    if (regExp.hasMatch(value.toString())) {
      var valdouble = double.parse(value.toString());
      if (valdouble >= 0) {
        sink.add(value);
      } else {
        sink.addError('Invalido');
      }
    } else {
      sink.addError('Invalido');
    }
  });

  final validateBySection =
      StreamTransformer<SeccionModelo, SeccionModelo>.fromHandlers(
          handleData: (value, sink) {
    Pattern pattern = r'^\d*(\.\d+)?$';
    RegExp regExp = new RegExp(pattern as String);

    if (regExp.hasMatch(value.medidas.toString()) &&
        regExp.hasMatch(value.medidas.toString())) {
      var numAlto = double.parse(value.medidas.toString());
      var numAncho = double.parse(value.medidas.toString());
      if (numAlto > 0 && numAncho > 0) {
        sink.add(value);
      } else {
        sink.addError('Inválido');
      }
    } else {
      sink.addError('Inválido');
    }
  });

  final validateByGlass =
      StreamTransformer<List<MedidaModel>, List<MedidaModel>>.fromHandlers(
          handleData: (value, sink) {
    Pattern pattern = r'^\d*(\.\d+)?$';
    RegExp regExp = new RegExp(pattern as String);

    bool allvalid = value.any((element) =>
        Validators.validRegex(regExp, element.alto.toString()) &&
        Validators.validRegex(regExp, element.ancho.toString()));

    sink.add(value);

    if (!allvalid) {
      sink.addError('Complete los datos');
    }
  });

  static bool validRegex(RegExp reg, String value) {
    return reg.hasMatch(value);
  }

  final validNumber =
      StreamTransformer<int, int>.fromHandlers(handleData: (value, sink) {
    Pattern pattern = r'^[0-9]+$';
    RegExp regExp = new RegExp(pattern as String);

    if (regExp.hasMatch(value.toString())) {
      var valint = int.parse(value.toString());
      if (valint > 0) {
        sink.add(value);
      } else {
        sink.addError('valor minimo es 1');
      }
    } else {
      sink.addError('numero no valido');
    }
  });

  final validateDate = StreamTransformer<DateTime, DateTime>.fromHandlers(
      handleData: (value, sink) {
    if (value != '') {
      sink.add(value);
    } else {
      sink.addError('El campo es requerido');
    }
  });

  final validTermAndConditions =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (value, sink) {
    if (value) {
      sink.add(value);
    } else {
      sink.addError('Es necesario aceptar el aviso de privacidad');
    }
  });
}
