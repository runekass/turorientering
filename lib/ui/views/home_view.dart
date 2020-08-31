import 'package:flutter/material.dart';
import 'package:turorientering/ui/shared/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: Text(
            'Home',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white),
        ),
      ),
    );
  }
}