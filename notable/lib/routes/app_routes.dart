import 'package:flutter/material.dart';
import '../presentation/loginsignup_screen/loginsignup_screen.dart';
import '../presentation/signup_screen/signup_screen.dart';
import '../screens/homepage/homepage_screen.dart';
import '../screens/camera/camera_screen.dart';
import '../screens/loginsignup/loginsignup_screen.dart';
import '../screens/opennote/opennote_screen.dart';
import '../screens/create_account/create_account_screen.dart';
import '../screens/my_profile/my_profile_screen.dart';
import '../screens/app_navigation/app_navigation_screen.dart';
import '../screens/textpreview/textpreview_page.dart';


class AppRoutes {
  static const String loginsignupScreen = '/loginsignup_screen';
  static const String loginsignupScreen1 = '/loginsignup_screen';

  static const String homepageScreen = '/homepage_screen';

  static const String cameraScreen = '/camera_ui_iossixteen_screen';

  static const String textpreviewPage = '/textpreview_page';

  static const String opennoteScreen = '/opennote_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String myProfileScreen = '/my_profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String signupScreen = 'signup_screen';

  // Creates the connection between a String that is the name of the page,
  //  and a Widget that is the page itself.
  static Map<String, WidgetBuilder> routes = {
    loginsignupScreen: (context) => LoginsignupScreen(),
    loginsignupScreen1: (context) => LoginsignupScreen1(),
    homepageScreen: (context) => HomepageScreen(),
    cameraScreen: (context) => CameraScreen(),
    textpreviewPage: (context) => const TextPreviewPage(), // changed from page-container to page
    opennoteScreen: (context) => OpennoteScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    myProfileScreen: (context) => MyProfileScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen(),
    signupScreen: (context) => SignupScreen()
  };
}
