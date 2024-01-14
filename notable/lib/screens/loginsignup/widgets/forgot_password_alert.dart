import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void onTapForgotPasswordAlert({
  required BuildContext context,
  required String title,
  required Icon icon,
  required String labelText,
  required String buttonText,
}) {
  // Create a TextEditingController
  TextEditingController controller = TextEditingController();

  Alert(
    context: context,
    title: title,
    content: Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            icon: icon,
            labelText: labelText,
          ),
          controller: controller,
        ),
      ],
    ),
    buttons: [
      DialogButton(
        // todo for Gianni
        onPressed: () async {},
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}