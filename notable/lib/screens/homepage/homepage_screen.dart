import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import 'widgets/breadcrumb.dart';
import 'widgets/folder_list.dart';
import 'widgets/user_info_menu.dart';
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
    // List<String> UserInfo = ['ΕΜΠ', 'ΗΜΜΥ', 'ΑΧΙΛΛΕΑΣ', '90 ΠΟΝΤΟΙ'];

    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Container(
                            width: 120.h,
                            // padding: EdgeInsets.symmetric(horizontal: 4.h),
                            decoration: AppDecoration.fillPrimary,
                            child: const HomePageLogo()),
                        // Container(
                        //     padding: EdgeInsets.symmetric(vertical: 12.v),
                        //     decoration: AppDecoration.fillPrimary,
                        //     child: UserInfoSideMenu(texts: UserInfo))
                      ]),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 8.v),
                              child: Column(children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(8.h, 8.v, 32.h, 8.v),
                                    decoration: AppDecoration.fillPrimary,
                                    child: UserInfoHeader(
                                      name: "Αχιλλέας\nΜπραϊμάκης",
                                      imagePath: ImageConstant.imgUserImage, // Replace with your image path
                                    )),
                                SizedBox(height: 5.v),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 9.h),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                          CustomElevatedButton(
                                              height: 27.v,
                                              width: 80.h,
                                              text: "My profile",
                                              buttonStyle: CustomButtonStyles.fillDeepOrange,
                                              buttonTextStyle: CustomTextStyles.titleSmallRobotoWhiteA700,
                                              onPressed: () {
                                                onTapMyProfile(context);
                                              }),
                                          CustomElevatedButton(
                                            height: 27.v,
                                            width: 79.h,
                                            text: "Sign out",
                                            margin: EdgeInsets.only(left: 11.h),
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
                                              },
                                            ),
                                          ),
                                        ]))),
                                SizedBox(height: 21.v),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: GradientBreadcrumb(
                                    breadcrumbs: const ['ΕΜΠ', 'ΗΜΜΥ', '4οΕτος', 'Χειμερίνο'],
                                    onTapBreadcrumb: (index) {},
                                  ),
                                ),
                                SizedBox(height: 21.v),
                                Container(
                                    width: 234.h,
                                    margin: EdgeInsets.symmetric(horizontal: 19.h),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline),
                                        color: appTheme.black900,
                                          onPressed: () async {

                                          //add a new folder under the user that has logged in
                                            await FirebaseFirestore.instance
                                                .collection('users') // Reference to 'users' collection
                                                .doc(currUid) // Reference to the specific user's document
                                                .collection('folders') // Reference to 'folders' subcollection
                                                .add({
                                              'title': 'Example Document',
                                              'content': 'This is an example document',
                                              'userUid': currUid // Storing the user's UID for reference
                                            });
                                            // ----------------------------------------------------------------------------------------------------------
                                            //delete a specific folder
                                            onPressed: () async {
                                              String folderNameToDelete = 'Folder Name'; // Replace with the name of the folder you want to delete

                                              try {
                                                // Reference to the user's 'folders' subcollection
                                                var folders = FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(currUid)
                                                    .collection('folders');

                                                // Query to find the specific folder by name
                                                var querySnapshot = await folders
                                                    .where('title', isEqualTo: folderNameToDelete)
                                                    .get();

                                                // Loop through the query results and delete each folder
                                                for (var doc in querySnapshot.docs) {
                                                  await doc.reference.delete();
                                                }

                                                print('Folder deleted successfully.');
                                              } catch (e) {
                                                print('Error deleting folder: $e');
                                              }
                                            };
                                            // ----------------------------------------------------------------------------------------------------
                                            //rename the folder
                                            onPressed: () async {
                                            String oldFolderName = 'Old Folder Name'; // Replace with the current name of the folder
                                            String newFolderName = 'New Folder Name'; // Replace with the new name for the folder

                                            try {
                                            // Reference to the user's 'folders' subcollection
                                            var folders = FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(currUid)
                                                .collection('folders');

                                            // Query to find the specific folder by the old name
                                            var querySnapshot = await folders
                                                .where('title', isEqualTo: oldFolderName)
                                                .get();

                                            // Loop through the query results and update each folder's name
                                            for (var doc in querySnapshot.docs) {
                                            await doc.reference.update({'title': newFolderName});
                                            }

                                            print('Folder renamed successfully.');
                                            } catch (e) {
                                            print('Error renaming folder: $e');
                                            }
                                            };
                                            // -----------------------------------------------------------------------------------------------------------




                                          }
                                      ),
                                      // CreateFolderAlert(),
                                      Text("ΜΑΘΗΜΑΤΑ", style: CustomTextStyles.titleLargeBlack900),
                                      Icon(Icons.search_outlined, color: appTheme.black900)
                                    ])),
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
                                              onTap: () {
                                                onTapImgUser(context);
                                              })
                                        ])))
                              ])))
                    ])),
            bottomNavigationBar: _buildFooter(context)));
  }

  /// Section Widget
  Widget _buildFooter(BuildContext context) {
    return Container(
        height: 40.v,
        // margin: EdgeInsets.only(left: 61.h, right: 61.h, bottom: 27.v),
        decoration: AppDecoration.fillPrimary,
        child: Center(
          child: Text("Contact us:    theTeam@mail.com", style: CustomTextStyles.bodyLargeWhiteA700),
        ));
  }

  /// Navigates to the myProfileScreen when the action is triggered.
  onTapMyProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.myProfileScreen);
  }

  /// Navigates to the cameraUiIossixteenScreen when the action is triggered.
  onTapImgUser(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cameraScreen);
  }
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
