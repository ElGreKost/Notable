import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../backend/app_state.dart';
import '../../../backend/tree_note_manager.dart';
import '../../../core/app_export.dart';
import '../../../widgets/alerts.dart';

class docListView extends StatelessWidget {
  const docListView({Key? key}) : super(key: key);

  @override // todo simplify it
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> folders = Provider
        .of<TreeNoteManager>(context)
        .currSubfolders;
    List<Map<String, dynamic>> notes = Provider
        .of<TreeNoteManager>(context)
        .currNotes;
    List<String> folderNames = folders.map((folder) => folder['name'] as String? ?? 'deprecated store format').toList();
    List<String> noteNames = notes.map((note) => note['title'] as String? ?? 'was null note').toList();
    List<String> docNames = [...folderNames, ...noteNames];
    List<String> folderIds = folders.map((folder) => folder['id'] as String? ?? 'id error').toList();
    List<String> noteIds = notes.map((note) => note['id'] as String? ?? 'id error').toList();
    List<String> docIds = [...folderIds, ...noteIds];
    print(docNames);

    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 24.v),
        itemCount: docNames.length,
        itemBuilder: (context, index) {
          bool isFolder = index < folderNames.length ? true : false;
          String docName = docNames[index];
          String docId = docIds[index];
          return docListTile(context, docName, docId, isFolder);
        },
      ),
    );
  }
}

Widget docListTile(context, String docName, String docId, bool isFolder) {
  // good folder colors Warm Taupe {good red} (0xff9E786C), Cool Grey (0xff8A9A9A), Soft Sage {light grey} (0xff97A69D),
  // Pale Olive (0xffB0B089), Heather Grey {lighter pale olive} (B3AB9D), Camel {brownish} (B8A690), Sea Foam {Pale Olive + Light mint} (93A698)
  // Dusty Aqua {blue + green} (5B9B8A), OYSTER BAY {soft blue} (D4E6E5), Pewter {soft blue grey} (96A3A6),
  // MORNING MIST {grayish-green inviting} (E5E5E5), LINEN {GOOD FOR BACKGROUND} (FDF6E3), TEA GREEN {to replace notes color} (D0F0C0)

  Widget popupMenu(BuildContext context, String folderName) {
    // the folderName is passed because he have to declare the the activeDocument is the one that we clicked upon.(provider)
    return PopupMenuButton(
      color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
      offset: Offset(40.h, -30.v),
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) =>
      [
        PopupMenuItem(
            child: Center(
                child:
                IconButton(icon: Icon(Icons.file_download_outlined, color: appTheme.black900), onPressed: () {}))),
        PopupMenuItem(
            child: Center(
                child: IconButton(
                  icon: Icon(Icons.drive_file_rename_outline_outlined, color: appTheme.black900),
                  onPressed: () =>
                      onTapInsertFolderAlert(
                        context: context,
                        title: 'Rename Folder',
                        icon: const Icon(Icons.drive_file_rename_outline_rounded),
                        labelText: 'Rename current folder',
                        buttonText: 'Rename',
                        userUid: '',
                        useCase: 'rename',
                        docToRename: {'id': docId, 'type': isFolder ? 'folder' : 'note'},
                      ),
                )))
      ],
    );
  }

  // The List Tile
  return Container(
    decoration: BoxDecoration(
        color: isFolder ? const Color(0xffB0B089) : theme.colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: appTheme.gray400, blurRadius: 15.h, offset: const Offset(10, 5))]),
    child: ListTile(
      onTap: () {
        if (isFolder) {
          Provider.of<TreeNoteManager>(context, listen: false).navigateToSubfolder(docId);
          Provider.of<TreeNoteManager>(context, listen: false).appendToBreadcrumb(docName);
        } else {
          Provider.of<TreeNoteManager>(context, listen: false).setCurrNote(docName);
          Navigator.pushNamed(context, AppRoutes.opennoteScreen);
        }
      },
      leading: IconButton(
        icon: Icon(Icons.delete_outline, color: appTheme.black900),
        onPressed: () =>
            onPressedCreateAlert(
                context: context,
                title: 'Delete Folder',
                desc: 'The folder $docName will be deleted',
                type: AlertType.none,
                onPressed: () => Provider.of<TreeNoteManager>(context, listen: false).deleteItem(docId, isFolder ? 'folder' : 'note')),
      ),
      title: Center(
          child: Text(docName, style: theme.textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
      trailing: popupMenu(context, docName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
