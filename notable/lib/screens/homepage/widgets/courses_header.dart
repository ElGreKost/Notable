import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_state.dart';
import '../../../theme/custom_text_style.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alerts.dart';

Widget coursesHeader(BuildContext context, double horizontalMargin) {

  String? currUid = Provider.of<AppState>(context).userUid;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
    child: ListTile(
      leading: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          color: appTheme.black900,
          onPressed: () =>
              onTapInsertFolderAlert(
                  context: context,
                  title: 'Create Folder',
                  icon: const Icon(Icons.folder),
                  labelText: 'Name the new folder',
                  buttonText: 'Create',
                  userUid: currUid ?? 'was null')),
      title: Center(child: Text("ΜΑΘΗΜΑΤΑ", style: CustomTextStyles.titleLargeBlack900)),
      trailing: Icon(Icons.search_outlined, color: appTheme.black900),
    ),
  );
}