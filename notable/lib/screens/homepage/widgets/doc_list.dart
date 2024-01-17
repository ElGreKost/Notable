import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../app_state.dart';
import '../../../core/app_export.dart';
import '../../../widgets/alerts.dart';

class docListView extends StatelessWidget {
  final List<String> folderNames;

  const docListView({Key? key, required this.folderNames}) : super(key: key);

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
          bool isNote = (index % 2) == 1;
          return docListTile(context, folderName, isNote);
        },
      ),
    );
  }
}

Widget docListTile(context, folderName, bool isNote) {
  // good folder colors Warm Taupe {good red} (0xff9E786C), Cool Grey (0xff8A9A9A), Soft Sage {light grey} (0xff97A69D),
  // Pale Olive (0xffB0B089), Heather Grey {lighter pale olive} (B3AB9D), Camel {brownish} (B8A690), Sea Foam {Pale Olive + Light mint} (93A698)
  // Dusty Aqua {blue + green} (5B9B8A), OYSTER BAY {soft blue} (D4E6E5), Pewter {soft blue grey} (96A3A6),
  // MORNING MIST {grayish-green inviting} (E5E5E5), LINEN {GOOD FOR BACKGROUND} (FDF6E3), TEA GREEN {to replace notes color} (D0F0C0)
  return Container(
    decoration: BoxDecoration(
        color: isNote ? theme.colorScheme.onPrimaryContainer : const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: appTheme.gray400, blurRadius: 15.h, offset: const Offset(10, 5))]),
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
      trailing: popupMenu(context, folderName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}

Widget popupMenu(BuildContext context, String folderName) {
  // the folderName is passed because he have to declare the the activeDocument is the one that we clicked upon.(provider)
  Provider.of<AppState>(context, listen: false).setCurrFolder(folderName);
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
