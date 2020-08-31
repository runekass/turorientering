import 'package:turorientering/constants/route_names.dart';
import 'package:turorientering/ui/shared/ui_helper.dart';
import 'package:turorientering/ui/widgets/busy_button.dart';
import 'package:turorientering/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:turorientering/viewmodels/signup_view_model.dart';
import 'package:turorientering/ui/shared/app_colors.dart';
import 'package:turorientering/services/navigation_service.dart';
import 'package:turorientering/locator.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: darkBlue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Registrering',
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.white,
                ),
              ),
              verticalSpaceMedium,
              InputField(
                placeholder: 'Navn',
                controller: fullNameController,
              ),
              InputField(
                placeholder: 'Mobil',
                controller: mobileController,
              ),
              InputField(
                placeholder: 'Epost',
                controller: emailController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Passord',
                password: true,
                controller: passwordController,
                additionalNote: 'Passordet må være minumum 6 tegn.',
              ),
              verticalSpaceMedium,
              // TODO Create login button to redirect back to login view
              Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BusyButton(
                      title: 'Innlogging',
                      busy: model.busy,
                      onPressed: () {
                        _navigationService.navigateTo(LoginViewRoute);
                      },
                    ),
                    BusyButton(
                      title: 'Registrer',
                      busy: model.busy,
                      onPressed: () {
                        model.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          fullName: fullNameController.text,
                          mobile: mobileController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}