import 'package:flutter/material.dart';
import 'widgets/export_widgets.dart';
import '../../core/app_export.dart';
import '../../app_state.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    double horizontalMargin = 40.h;
    List<String> folderNames = Provider.of<AppState>(context).folderNames;
    String? displayName = Provider.of<AppState>(context).userDisplayName;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(context, 'Username: ${displayName!}', ImageConstant.imgUserImage),
            SizedBox(height: 24.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: GradientBreadcrumb(
                breadcrumbs: const ['ΕΜΠ', 'ΗΜΜΥ', '4οΕτος', 'Χειμερινό'],
                onTapBreadcrumb: (index) {},
              ),
            ),
            SizedBox(height: 21.v),
            coursesHeader(context, horizontalMargin),
            SizedBox(height: 31.v),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                child: FoldersListView(folderNames: folderNames),
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
