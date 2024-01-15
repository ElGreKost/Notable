import 'package:flutter/material.dart';
import 'package:notable/screens/loginsignup/widgets/forgot_password_alert.dart';
import '../../core/app_export.dart';
import '../../widgets/alerts.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:notable/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app_state.dart';
import 'package:provider/provider.dart';

class LoginsignupScreen1 extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
                      child: Text("Welcome to Notable", style: theme.textTheme.displaySmall),
                    ),
                    Container(
                      width: 288.h,
                      margin: EdgeInsets.only(left: 20.h, right: 31.h),
                      child: Text(
                        "Login/Create an account to enjoy all the services without any ads for free!",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(height: 1.30),
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
                      text: "Login",
                      margin: EdgeInsets.only(left: 29.h, right: 39.h),
                      onPressed: () {
                        onTapLogin(context);
                      },
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          onTapCreateAnAccount(context);
                        },
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.fSize,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: TextButton(
                        onPressed: () => onTapForgotPasswordAlert(
                          context: context,
                          title: 'Forgot Password',
                          icon: const Icon(Icons.mail_outline),
                          labelText: 'Enter your email',
                          buttonText: 'Reset Password',
                          onTapForgotPassword: onTapForgotPassword,
                        ),
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.fSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (loading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onTapLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        loading = true;

        User? currUser = await AuthService().signIn(
          emailController.text,
          passwordController.text,
        );

        if (currUser != null) {
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
        } else {
          print('user was null');
        }

        Provider.of<AppState>(context, listen: false).setUser(currUser);
      } catch (e) {
        print('Login Error: $e');
        // Handle login errors (display error message or take appropriate action)
      } finally {
        loading = false;
      }
    }
  }

  void onTapCreateAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }

  void onTapForgotPassword(BuildContext context, String email) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        loading = true;

        await AuthService().sendPasswordResetEmail(email);
        // TODO: show a success message e.g. "Password reset email sent"
        Navigator.pop(context);
      } catch (e) {
        // Handle any error that may occur during the password reset process
        print('Password Reset Error: $e');
      } finally {
        loading = false;
      }
    }
  }
}
