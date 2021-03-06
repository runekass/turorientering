import 'package:turorientering/constants/route_names.dart';
import 'package:turorientering/locator.dart';
import 'package:turorientering/services/authentication_service.dart';
import 'package:turorientering/services/dialog_service.dart';
import 'package:turorientering/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Innloggingsfeil',
          description: 'Generell innloggingsfeil. Venligst prøv på nytt.',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Innloggingsfeil',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}