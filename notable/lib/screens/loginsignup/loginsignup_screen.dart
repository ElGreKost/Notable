import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notable/screens/loginsignup/widgets/forgot_password_alert.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:notable/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app_state.dart';
import 'package:provider/provider.dart';


class LoginsignupScreen1 extends StatefulWidget {
  LoginsignupScreen1({Key? key}) : super(key: key);

  @override
  _LoginsignupScreen1State createState() => _LoginsignupScreen1State();
}

class _LoginsignupScreen1State extends State<LoginsignupScreen1> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                      child: Text("Welcome to Notable",
                          style: theme.textTheme.displaySmall),
                    ),
                    Container(
                      width: 288.h,
                      margin: EdgeInsets.only(left: 20.h, right: 31.h),
                      child: Text(
                        "Login/Create an account to enjoy all the services without any ads for free!",
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
                            color: Theme
                                .of(context)
                                .primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.fSize,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            onTapForgotPasswordAlert(
                              context: context,
                              title: 'Forgot Password',
                              icon: const Icon(Icons.mail_outline),
                              labelText: 'Enter your email',
                              buttonText: 'Send email',
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

  onTapLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          loading = true;
        });

        User? currUser = await AuthService().signIn(
          emailController.text,
          passwordController.text,
        );

        if (currUser != null) {
          String userId = currUser.uid;
          var foldersSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('folders')
              .get();

          List<Map<String, dynamic>> folders = [];
          for (var doc in foldersSnapshot.docs) {
            folders.add(doc.data() as Map<String, dynamic>);
          }
          // Print the contents of the folders list
          print("\n\n\n\n\n\n\n\n\nFolders: ");
          for (var folder in folders) {
            print(folder.toString());
          }
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
          Provider.of<AppState>(context, listen: false).setUser(currUser);
        } else {
          print('user was null');
        }

      } catch (e) {
        print('Login Error: $e');
        // Handle login errors (display error message or take appropriate action)
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  /// Navigates to the createAccountScreen when the action is triggered.
  onTapCreateAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }


  void onTapForgotPassword(BuildContext context, String email) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Set loading to true before making the request
        setState(() {
          loading = true;
        });

        // Call your AuthService method to send the password reset email
        await AuthService().sendPasswordResetEmail(email);

        // TODO: show a success message e.g. "Password reset email sent"
        // For example, you can use a SnackBar to display a message to the user:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset email sent to $email'),
          ),
        );

        Navigator.pop(context); // Close the alert dialog
      } catch (e) {
        // Handle any error that may occur during the password reset process
        print('Password Reset Error: $e');
      } finally {
        // Set loading to false after the request has completed
        setState(() {
          loading = false;
        });
      }
    }
  }
}
