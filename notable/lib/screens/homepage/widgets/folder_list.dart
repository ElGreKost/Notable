import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

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
          return folderListTile(folderNames[index]);
        },
      ),
    );
  }
}

Widget folderListTile(folderName) => Container(
      decoration: BoxDecoration(color: theme.colorScheme.onPrimaryContainer, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: IconButton(icon: Icon(Icons.delete_outline, color: appTheme.black900), onPressed: () {}),
        title: Center(
            child: Text(folderName, style: theme.textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
        trailing: IconButton(icon: Icon(Icons.file_download_outlined, color: appTheme.black900), onPressed: () {}),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
