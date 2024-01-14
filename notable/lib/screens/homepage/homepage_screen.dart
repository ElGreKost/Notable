import 'package:flutter/material.dart';
import 'widgets/export_widgets.dart';
import '../../core/app_export.dart';

class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    double horizontalMargin = 40.h;
    List<String> folderNames = ['Course 1', 'Course 2', 'Course 3', 'Course 4', 'Course 5', 'Course 6', 'Course 7'];
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
              header(context, 'UserDisplayName', ImageConstant.imgUserImage),
              SizedBox(height: 24.v),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                  child: GradientBreadcrumb(
                      breadcrumbs: const ['ΕΜΠ', 'ΗΜΜΥ', '4οΕτος', 'Χειμερίνο'], onTapBreadcrumb: (index) {})),
              SizedBox(height: 21.v),
              coursesHeader(context, horizontalMargin),
              SizedBox(height: 31.v),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                      child: ListView.separated(
                          itemBuilder: (context, index) => folderListTile(folderNames[index]),
                          itemCount: folderNames.length,
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24.v)))),
              SizedBox(height: 24.v),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(padding: EdgeInsets.only(right: 9.h), child: footerButtons(context)))
            ]),
            bottomNavigationBar: _buildFooter(context)));
  }

  /// Section Widget
  Widget _buildFooter(BuildContext context) => Container(
      height: 40.v,
      decoration: AppDecoration.fillPrimary,
      child: Center(child: Text("Contact us:    theTeam@mail.com", style: CustomTextStyles.bodyLargeWhiteA700)));
}
