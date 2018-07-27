import 'package:flutter/material.dart';
import 'login_screen.dart';

class SampleLoginScreen extends StatelessWidget {
  // instantiate the build view here
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: "Simple Login Screen",
        home: LoginScreen(),
      );
    }
}