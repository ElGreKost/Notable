import 'package:flutter/material.dart';
import '../presentation/loginsignup_screen/loginsignup_screen.dart';
import '../presentation/signup_screen/signup_screen.dart';


class AppRoutes {
  static const String loginsignupScreen = '/loginsignup_screen';

  static const String signupScreen = 'signup_screen';

  static Map<String, WidgetBuilder> routes = {
    loginsignupScreen: (context) => LoginsignupScreen(),
    signupScreen: (context) => SignupScreen()
  };
}
