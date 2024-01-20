import 'package:flutter/material.dart';
import '../../backend/tree_note_manager.dart';
import 'widgets/export_widgets.dart';
import '../../core/app_export.dart';
import '../../backend/app_state.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    double horizontalMargin = 40.h;
    var appState = Provider.of<AppState>(context);
    String? displayName = appState.userDisplayName;
    String? userUid = appState.userUid;
    String? custom_img = appState.userImageUrl;
    var noteManager = Provider.of<TreeNoteManager>(context);
    noteManager.setUserUid(userUid);
    // print('read and initialized root path with userUid: ${noteManager.currentFolderRef}');
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(context, 'Username: ${displayName!}', custom_img!),
            SizedBox(height: 24.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: GradientBreadcrumb(
                breadcrumbs: noteManager.breadcrumb,
                onTapBreadcrumb: (index) {
                  int stepsToGoBack = noteManager.breadcrumb.length - 1 - index;
                  for (int i = 0; i < stepsToGoBack; i++) {
                    // Assuming you have a method to get the parent reference of the current folder
                    noteManager.moveToParentFolder();
                  }
                },
              ),
            ),
            SizedBox(height: 21.v),
            coursesHeader(context, horizontalMargin),
            SizedBox(height: 31.v),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                child: const docListView(),
              ),
            ),
            SizedBox(height: 24.v),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 9.h),
                  child: Icon(Icons.file_upload_outlined, color: appTheme.black900)),
            ),
          ],
        ),
        bottomNavigationBar: _buildFooter(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildFooter(BuildContext context) => Container(
        height: 40.v,
        decoration: AppDecoration.fillPrimary,
        child: Center(child: Text("Contact us:    theTeam@mail.com", style: CustomTextStyles.bodyLargeWhiteA700)),
      );
}
