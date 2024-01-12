import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notable/app_state.dart';
import 'package:provider/provider.dart';
import '../core/utils/size_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../theme/theme_helper.dart';

void onPressedCreateAlert(
    {required BuildContext context,
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
      DialogButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed();
          },
          width: 120.h,
          child: Text('Continue', style: theme.textTheme.bodyMedium))
    ],
  ).show();
}

void onTapInputTextAlert({
  required BuildContext context,
  required String title,
  required Icon icon,
  required String labelText,
  required String buttonText,
  required String userUid
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
          // Retrieve the folder name from the text field
          String folderName = controller.text;

          // Add a new document to the 'folders' collection in Firestore
          await FirebaseFirestore.instance.collection('folders').add({
            'folderName': folderName, // Use the text from the controller
            'content': '',
            'userUid': userUid,
          });

          // Optionally, close the dialog
          Navigator.of(context).pop();
        },
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}


