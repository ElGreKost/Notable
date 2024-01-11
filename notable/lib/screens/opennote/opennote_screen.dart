import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/alerts.dart';
import '../../widgets/edge_navigators.dart';

class OpennoteScreen extends StatelessWidget {
  const OpennoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    String noteTitle = 'Note Name';
    List<IconButton> tools = [
      IconButton(icon: const Icon(Icons.list), onPressed: () {}, iconSize: 40),
      IconButton(icon: const Icon(Icons.share), onPressed: () {}, iconSize: 40),
      IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}, iconSize: 40),
      IconButton(icon: const Icon(Icons.file_download_outlined), iconSize: 40
          , onPressed: () {onTapInputTextAlert(
              context: context, title: "Select Folder", icon: const Icon(Icons.folder),
              labelText: '', buttonText: "Save");}
      ),
      IconButton(icon: const Icon(Icons.star_border_outlined), onPressed: () {}, iconSize: 40),
      IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}, iconSize: 40),];
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            appBar: headerNavigator(context, noteTitle),
            body: SizedBox(
                height: 706.v,
                width: double.maxFinite,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        decoration: AppDecoration.fillLime,
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: tools)))),
            bottomNavigationBar: footerNavigator(context)));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the homepageScreen when the action is triggered.
  onTapImgFinalLogoEleven(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }

}


