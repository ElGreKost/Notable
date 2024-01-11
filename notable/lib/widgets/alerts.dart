import 'package:flutter/material.dart';
import '../core/utils/size_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../theme/theme_helper.dart';

void onPressedCreateAlert({required BuildContext context,
  required String title,
  required String desc,
  required type,
  required VoidCallback onPressed}) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(onPressed: () {
            Navigator.pop(context);
            onPressed();
          }, width: 120.h, child: Text('Continue', style: theme.textTheme.bodyMedium))
    ],
  ).show();
}


void onTapInputTextAlert(
    {required BuildContext context, required String title, required Icon icon, required String labelText, required String buttonText}) {
  Alert(
    context: context,
    title: title,
    content: Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            icon: icon,
            labelText: labelText,
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}