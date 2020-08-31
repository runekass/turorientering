import 'package:turorientering/constants/route_names.dart';
import 'package:turorientering/locator.dart';
import 'package:turorientering/services/authentication_service.dart';
import 'package:turorientering/services/navigation_service.dart';
import 'package:turorientering/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}