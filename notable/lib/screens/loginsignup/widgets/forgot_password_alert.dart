import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void onTapForgotPasswordAlert({
  required BuildContext context,
  required String title,
  required Icon icon,
  required String labelText,
  required String buttonText,
  required Function onTapForgotPassword, // Pass the onTapForgotPassword function as a parameter
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
        onPressed: () async {
          print(controller.text);
          onTapForgotPassword(context, controller.text); // Call onTapForgotPassword when the button is pressed
        },
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}
