import 'package:flutter/material.dart';
import 'package:notable/backend/app_state.dart';
import 'package:notable/backend/tree_note_manager.dart';
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
    required String useCase,
    required Map<String, dynamic> docToRename, // todo maybe create new widget that will have this extra feature

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
          String newName = controller.text;
          switch (useCase) {
            case 'addNote':
              Provider.of<TreeNoteManager>(context, listen: false).createNote(newName, '');
              break;
            case 'rename':
              print('id was : ${docToRename["id"]} \n type was ${docToRename['type']}');
              Provider.of<TreeNoteManager>(context, listen: false).renameItem(docToRename['id'], newName, docToRename['type']);
              // Provider.of<AppState>(context, listen: false).setCurrFolder(tileFolderName);
              // Provider.of<AppState>(context, listen: false).renameDoc(newName);
              break;
            case 'addFolder':
              Provider.of<TreeNoteManager>(context, listen: false).createFolder(newName);
              break;
          }

          Navigator.of(context).pop();
        },
        color: theme.colorScheme.primary.withOpacity(0.9),
        child: Text(buttonText, style: TextStyle(color: appTheme.whiteA700, fontSize: 20.h)),
      )
    ],
  ).show();
}
