import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_state.dart';
import '../../../core/app_export.dart';

class FoldersListView extends StatelessWidget {
  final List<String> folderNames;

  const FoldersListView({
    Key? key,
    required this.folderNames
  }) : super(key: key);

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
          onPressed: () => Provider.of<AppState>(context, listen: false).deleteFolder(folderName)),
      title: Center(
          child: Text(folderName, style: theme.textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
      trailing: IconButton(icon: Icon(Icons.file_download_outlined, color: appTheme.black900), onPressed: () {}),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
