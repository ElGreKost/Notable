import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginsignupScreen1 extends StatelessWidget {
  LoginsignupScreen1({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 25.h, top: 158.v, right: 25.h),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Welcome to Notable", style: theme.textTheme.displaySmall)),
                      Container(
                          width: 288.h,
                          margin: EdgeInsets.only(left: 20.h, right: 31.h),
                          child: Text("Create an account to enjoy all the services without any ads for free!",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium!.copyWith(height: 1.30))),
                      SizedBox(height: 41.v),
                      Padding(
                          padding: EdgeInsets.only(right: 7.h),
                          child: CustomTextFormField(
                              controller: emailController,
                              hintText: "your.org@mail.com",
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress)),
                      SizedBox(height: 8.v),
                      Padding(
                          padding: EdgeInsets.only(right: 7.h),
                          child: CustomTextFormField(
                            controller: passwordController,
                            hintText: "YourStrongPassword",
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: true,
                          )),
                      SizedBox(height: 8.v),
                      CustomElevatedButton(
                          text: "Login",
                          margin: EdgeInsets.only(left: 29.h, right: 39.h),
                          onPressed: () {
                            onTapLogin(context);
                          },
                          alignment: Alignment.center),
                      Center(
                          child: TextButton(
                              onPressed: () {
                                onTapCreateAnAccount(context);
                              },
                              child: Text("Create an account",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor, // Adjust the color as needed
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.fSize, // Adjust the font size as needed
                                  )))),
                      Center(
                          child: TextButton(
                              onPressed: () {
                                // onTapInputTextAlert(
                                //   context: context,
                                //   title: 'Reset Password',
                                //   labelText: 'Email',
                                //   icon: const Icon(Icons.account_circle),
                                //   buttonText: 'Submit',
                                //   onPressed: () => Navigator.pop(context)
                                // );
                              },
                              child: Text("Forgot your password?",
                                  style: TextStyle(
                                    color: Colors.blue, // Adjust the color as needed
                                    fontSize: 16.fSize, // Adjust the font size as needed
                                  )))),
                    ])))));
  }

  /// Navigates to the homepageScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }

  /// Navigates to the createAccountScreen when the action is triggered.
  onTapCreateAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.createAccountScreen);
  }
}
