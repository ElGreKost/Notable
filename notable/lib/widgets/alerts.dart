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
          color: theme.colorScheme.primary.withOpacity(0.9),
          onPressed: () {
            Navigator.pop(context);
            onPressed();
          },
          width: 120.h,
          child: Text('Continue', style: theme.textTheme.bodyMedium))
    ],
  ).show();
}

void onTapInsertFolderAlert(
    {required BuildContext context,
    required String title,
    required Icon icon,
    required String labelText,
    required String buttonText,
    required String userUid,
      required String useCase
    }) {
  TextEditingController controller = TextEditingController();

  Alert(
    context: context,
    title: title,
    content: Column(
      children: <Widget>[
        TextFormField(decoration: InputDecoration(icon: icon, labelText: labelText), controller: controller),
      ],
    ),
    buttons: [
      DialogButton(
        onPressed: () {
          String folderName = controller.text;
          if (useCase == 'add') {
            Provider.of<AppState>(context, listen: false).addNote(folderName);
          } else if (useCase == 'rename') {
            Provider.of<AppState>(context, listen: false).rename(folderName);
          }
          Navigator.of(context).pop();
        },
        color: theme.colorScheme.primary.withOpacity(0.9),
        child: Text(buttonText, style: TextStyle(color: appTheme.whiteA700, fontSize: 20.h)),
      )
    ],
  ).show();
}
