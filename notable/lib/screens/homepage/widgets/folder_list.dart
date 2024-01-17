import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../app_state.dart';
import '../../../core/app_export.dart';
import '../../../widgets/alerts.dart';

class FoldersListView extends StatelessWidget {
  final List<String> folderNames;

  const FoldersListView({Key? key, required this.folderNames}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 24.v),
        itemCount: folderNames.length,
        itemBuilder: (context, index) {
          String folderName = folderNames[index];
          return folderListTile(context, folderName);
        },
      ),
    );
  }
}

Widget folderListTile(context, folderName) {
  return Container(
    decoration: BoxDecoration(color: theme.colorScheme.onPrimaryContainer, borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      onTap: () {
        Provider.of<AppState>(context, listen: false).setCurrFolder(folderName);
        Navigator.pushNamed(context, AppRoutes.opennoteScreen);
      },
      leading: IconButton(
        icon: Icon(Icons.delete_outline, color: appTheme.black900),
        onPressed: () => onPressedCreateAlert(
            context: context,
            title: 'Delete Folder',
            desc: 'The folder $folderName will be deleted',
            type: AlertType.none,
            onPressed: () => Provider.of<AppState>(context, listen: false).deleteFolder(folderName)),
      ),
      title: Center(
          child: Text(folderName, style: theme.textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
      trailing: popupMenu(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}

Widget popupMenu(BuildContext context) {
  return PopupMenuButton(
    color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
    offset: Offset(40.h, -30.v),
    icon: const Icon(Icons.more_vert),
    itemBuilder: (context) => [
      PopupMenuItem(
          child: Center(
              child: IconButton(icon: Icon(Icons.file_download_outlined, color: appTheme.black900), onPressed: () {}))),
      PopupMenuItem(
          child: Center(
              child: IconButton(
        icon: Icon(Icons.drive_file_rename_outline_outlined, color: appTheme.black900),
        onPressed: () => onTapInsertFolderAlert(
            context: context,
            title: 'Rename Folder',
            icon: const Icon(Icons.drive_file_rename_outline_rounded),
            labelText: 'Rename current folder',
            buttonText: 'Rename',
            userUid: '',
            useCase: 'rename'),
      )))
    ],
  );
}
