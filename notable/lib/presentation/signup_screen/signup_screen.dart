// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:noteable_v0/services/auth_service.dart';



class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  }, child: Text('LogIn'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapLogin(BuildContext context) async {
    if (_formKey.currentState?alidate() ?? false) {
      try {
        await AuthService().signIn(
          emailController.text,
          passwordController.text,
        );
        // Navigate to the homepageScreen upon successful login
        Navigator.pushNamed(context, AppRoutesomepageScreen);
      } catch (e) {
        // Handle login errors (display error message or take appropriate action)
        print('Login Error: $e');
      }
    }
  }

  onTapCreateAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }
}
