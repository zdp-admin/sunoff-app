import 'package:flutter/material.dart';
import 'package:sunoff/blocs/app_bloc.dart';

class AppProvider extends InheritedWidget {
  static AppProvider? _instance;

  factory AppProvider({required Widget child}) {
    return _instance ?? new AppProvider._internal(child: child);
  }

  AppProvider._internal({required Widget child}) : super(child: child);

  final appBloc = AppBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>())!.appBloc;
  }
}
