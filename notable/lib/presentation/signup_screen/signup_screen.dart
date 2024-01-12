// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notable/routes/app_routes.dart';
import 'package:notable/services/auth_service.dart';

//TODO:  add a navigator from signupscreen to loginsignupscreen (velaki piso)

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

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
                    onTapCreateAnAccount(context);
                  }, child: Text('Create your account'),
                ),
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
        await AuthService().signIn(
          emailController.text,
          passwordController.text,
        );
        // Navigate to the homepageScreen upon successful login
        Navigator.pushNamed(context, AppRoutes.homepageScreen);
      } catch (e) {
        // Handle login errors (display error message or take appropriate action)
        print('Login Error: $e');
      }
    }
  }

  onTapCreateAnAccount(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Check if the email is already in use before signing up
        bool emailExists = await AuthService().isEmailInUse(emailController.text);

        if (emailExists) {
          // Display an error message if the email is already in use
          print('Email address is already in use');
        } else {
          // If the email is not in use, proceed with sign up
          await AuthService().signUp(
            emailController.text,
            passwordController.text,
          );
          // Navigate to the homepageScreen upon successful signup
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
        }
      } catch (e) {
        // Handle signup errors (display error message or take appropriate action)
        print('Signup Error: $e');
      }
    }
  }

}

