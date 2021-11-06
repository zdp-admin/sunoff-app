import 'package:flutter/material.dart';
import 'package:sunoff/services/navigation_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/preference_user.dart';

class StartupViewModel extends ChangeNotifier {
  final PreferencesUser _pref = new PreferencesUser();
  final NavigationService? _navigationService = appService<NavigationService>();

  Future<void> handleStartUp() async {
    bool loggedUser = _pref.logged;

    await Future.delayed(Duration(milliseconds: 500));

    if (loggedUser) {
      _navigationService!.navigateToAndRemoveHistory('profile');
    } else {
      _navigationService!.navigateToAndRemoveHistory('login');
    }
  }
}
