import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import 'widgets/breadcrumb.dart';
import 'widgets/folder_list.dart';
import 'widgets/header.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/alerts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:notable/services/auth_service.dart';

final AuthService authService = AuthService();

class HomepageScreen extends StatelessWidget {
  HomepageScreen({super.key});

  TextEditingController folderNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    // The string below can be used to initialize the user's info in firebase
    String? currUid = Provider.of<AppState>(context).userUid;
    String? currEmail = Provider.of<AppState>(context).userEmail;
    String? currDisplayName = Provider.of<AppState>(context).userDisplayName;

    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(context),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.v, horizontal: 40),
                              child: Column(children: [
                                GradientBreadcrumb(
                                  breadcrumbs: const ['ΕΜΠ', 'ΗΜΜΥ', '4οΕτος', 'Χειμερίνο'],
                                  onTapBreadcrumb: (index) {},
                                ),
                                SizedBox(height: 21.v),
                                ListTile(
                                  leading: IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      color: appTheme.black900,
                                      onPressed: () => onTapInputTextAlert(
                                          context: context,
                                          title: 'Create Folder',
                                          icon: const Icon(Icons.folder),
                                          labelText: 'Name the new folder',
                                          buttonText: 'Create',
                                          userUid: currUid ?? 'was null')),
                                  title: Center(child: Text("ΜΑΘΗΜΑΤΑ", style: CustomTextStyles.titleLargeBlack900)),
                                  trailing: Icon(Icons.search_outlined, color: appTheme.black900),
                                ),
                                SizedBox(height: 31.v),
                                const FoldersListView(
                                  folderNames: [
                                    'ΑΛΛΗΛΕΠΊΔΡΑΣΗ',
                                    'ΗΛΕΚΤΡΟΛΟΓΙΚΟ ΣΧΕΔΙΟ',
                                    'ΡΟΜΠΟΤΙΚΗ 1',
                                    'ΝΕΥΡΟΑΣΑΦΉΣ ΈΛΕΓΧΟΣ',
                                    'ΑΛΓΟΡΙΘΜΟΙ',
                                    "ΤΕΧΝΟΛΟΓΙΑ ΛΟΓΙΣΜΙΚΟΎ",
                                    'ΜΗΧΑΝΙΚΗ ΜΑΘΗΣΗ'
                                  ],
                                ),
                                SizedBox(height: 24.v),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 9.h),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                          Icon(Icons.file_upload_outlined, color: appTheme.black900),
                                          CustomImageView(
                                              imagePath: ImageConstant.imgCam,
                                              height: 65.adaptSize,
                                              width: 65.adaptSize,
                                              margin: EdgeInsets.only(left: 21.h),
                                              onTap: () => Navigator.pushNamed(context, AppRoutes.cameraScreen))
                                        ])))
                              ])))
                    ])),
            bottomNavigationBar: _buildFooter(context)));
  }

  Row Header(BuildContext context) {
    return Row(children: [
      Container(width: 120.h, decoration: AppDecoration.fillPrimary, child: const HomePageLogo()),
      Expanded(
        child: Column(children: [
          Container(
              padding: EdgeInsets.fromLTRB(8.h, 8.v, 32.h, 8.v),
              decoration: AppDecoration.fillPrimary,
              child: userInfoHeader(name: "Αχιλλέας\nΜπραϊμάκης", imagePath: ImageConstant.imgUserImage)),
          SizedBox(height: 5.v),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Align(
                alignment: Alignment.centerRight, child: myprofileSingoutButtons(context: context, maxWidth: 200.h)),
          ),
        ]),
      )
    ]);
  }

  Widget myprofileSingoutButtons({context, maxWidth}) {
    var myprofiileButton = CustomElevatedButton(
        height: 27.0.h,
        width: 80.0.v,
        text: "My profile",
        buttonStyle: CustomButtonStyles.fillDeepOrange,
        buttonTextStyle: CustomTextStyles.titleSmallRobotoWhiteA700,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.myProfileScreen));
    var singoutButton = CustomElevatedButton(
      height: 27.0.h,
      width: 79.0.v,
      text: "Sign out",
      margin: EdgeInsets.only(left: 8.0.h),
      buttonStyle: CustomButtonStyles.fillDeepOrange,
      buttonTextStyle: CustomTextStyles.titleSmallRobotoWhiteA700,
      onPressed: () => onPressedCreateAlert(
          context: context,
          title: "Sign Out",
          desc: "Are you sure?",
          type: AlertType.none,
          onPressed: () async {
            // Perform logout
            await authService.signOut();
            Navigator.pushNamed(context, AppRoutes.loginsignupScreen);
          }),
    );
    return SizedBox(
      width: maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: myprofiileButton,
          ),
          Expanded(
            child: singoutButton,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFooter(BuildContext context) => Container(
      height: 40.v,
      decoration: AppDecoration.fillPrimary,
      child: Center(child: Text("Contact us:    theTeam@mail.com", style: CustomTextStyles.bodyLargeWhiteA700)));
}

class HomePageLogo extends StatelessWidget {
  const HomePageLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: 3, // Rotate 90 degrees clockwise
          child: Text(
            "Notable",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall, // todo Jim Nightshade on displayMedium
          ),
        ),
        // SizedBox(width: 2.h), // Controlled spacing
        const LogoWidget(),
      ],
    );
  }
}
