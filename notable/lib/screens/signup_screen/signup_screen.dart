import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/alerts.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:notable/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app_state.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 25.h, top: 158.v, right: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("Register to Notable",
                          style: theme.textTheme.displaySmall),
                    ),
                    Container(
                      width: 288.h,
                      margin: EdgeInsets.only(left: 20.h, right: 31.h),
                      child: Text(
                        "Create your very own account to enjoy all the services without any ads for free!",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.30),
                      ),
                    ),
                    SizedBox(height: 41.v),
                    Padding(
                      padding: EdgeInsets.only(right: 7.h),
                      child: CustomTextFormField(
                        controller: emailController,
                        hintText: "your.org@mail.com",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Padding(
                      padding: EdgeInsets.only(right: 7.h),
                      child: CustomTextFormField(
                        controller: passwordController,
                        hintText: "YourStrongPassword",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    CustomElevatedButton(
                      text: "Create your Notable account",
                      margin: EdgeInsets.only(left: 29.h, right: 39.h),
                      onPressed: () {
                        onTapCreateAnAccount(context);
                      },
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ),
            if (loading)
              Center(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Navigates to the createAccountScreen when the action is triggered.
  void onTapCreateAnAccount(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          loading = true; // Set loading to true before making the request
        });

        // Check if the email is already in use before signing up
        bool emailExists = await AuthService().isEmailInUse(
            emailController.text);

        if (emailExists) {
          // Display an error message if the email is already in use
          print('Email address is already in use');
        } else {

          User? currUser = await AuthService().signUp(
            emailController.text,
            passwordController.text,
          );
          await FirebaseFirestore.instance.collection('users').add(<String, dynamic>{
            'email': emailController.text
          });

          Provider.of<AppState>(context, listen: false).setUser(currUser);
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
        }
      } catch (e) {
        // Handle signup errors (display error message or take appropriate action)
        print('Signup Error: $e');
      } finally {
        setState(() {
          loading =
          false; // Set loading to false after the request has completed
        });
      }
    }
  }
}
