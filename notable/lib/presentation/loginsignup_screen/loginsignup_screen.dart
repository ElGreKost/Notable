// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notable/routes/app_routes.dart';
import 'package:notable/screens/homepage/homepage_screen.dart';
import 'package:notable/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

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
        User? currUser = await AuthService().signIn(
          emailController.text,
          passwordController.text,
        );
        if (currUser != null) {
          //String? currUid = Provider.of<AppState>(context).userUid;
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
          print("Folders: ");
          for (var folder in folders) {
            print(folder.toString());
          }

          // Use folders as needed (e.g., update AppState or UI)
          // Provider.of<AppState>(context, listen: false).setFolders(folders);
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
          Provider.of<AppState>(context, listen: false).setUser(currUser);
        } else {
          print('user was null');
        }
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

