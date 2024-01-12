import 'package:cloud_firestore/cloud_firestore.dart';
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
    {required BuildContext context, required String title, required Icon icon, required String labelText, required String buttonText, required VoidCallback onPressed}) {
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
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}


class CreateFolderDialog extends StatefulWidget {
  const CreateFolderDialog({Key? key}) : super(key: key);

  @override
  State<CreateFolderDialog> createState() => _CreateFolderDialogState();
}

class _CreateFolderDialogState extends State<CreateFolderDialog> {
  String? _folderName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create a folder'),
      content: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.folder),
                labelText: 'Folder Name',
              ),
              onChanged: (folderName) {
                setState(() {
                  _folderName = folderName;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a folder name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_folderName != null) {
                  await FirebaseFirestore.instance.collection(_folderName!).doc('newDocumentName').set(<String, dynamic>{
                    'title': 'Example Document',
                    'content': 'This is an example document',
                  });
                  // Dismiss the dialog
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Create',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateFolderAlert extends StatelessWidget {
  const CreateFolderAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final folderName = await showDialog<String>(
          context: context,
          builder: (_) => CreateFolderDialog(),
        );

        if (folderName != null) {
          // Create the new collection with the specified folder name
          await FirebaseFirestore.instance.collection(folderName).doc('newDocumentName').set(<String, dynamic>{
            'title': 'Example Document',
            'content': 'This is an example document',
          });
        }
      },
      child: Text(
        'Create Folder',
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
