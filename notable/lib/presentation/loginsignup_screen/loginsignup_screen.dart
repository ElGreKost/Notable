// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notable/routes/app_routes.dart';
import 'package:notable/screens/homepage/homepage_screen.dart';
import 'package:notable/services/auth_service.dart';

class LoginsignupScreen extends StatelessWidget {
  LoginsignupScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 25, top: 158, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Login or Create An Account",
                  ),
                ),
                Container(
                  width: 288,
                  margin: EdgeInsets.only(left: 20, right: 31),
                  child: Text(
                    "Login/Signup to enjoy all the services without any ads for free!",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 41),
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(height: 52),
                ElevatedButton(
                  onPressed: () {
                    onTapLogin(context);
                  },
                  child: Text('LogIn'),
                ),
                SizedBox(height: 9),
                ElevatedButton(
                  onPressed: () {
                    onTapCreateAnAccount(context);
                  },
                  child: Text('Create account'),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        Future currUid = AuthService().signIn(
          emailController.text,
          passwordController.text,
        );
        // Navigate to the homepageScreen upon successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomepageScreen(currUid: currUid))
        );
      } catch (e) {
        // Handle login errors (display error message or take appropriate action)
        // todo make the Forgot Password visible
        print('Login Error: $e');
      }
    }
  }

  onTapCreateAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }
}
