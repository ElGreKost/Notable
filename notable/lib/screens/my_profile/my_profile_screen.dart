import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';

// ignore_for_file: must_be_immutable
class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('30');

  TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: theme.colorScheme.primary,
                leading: IconButton(
                    icon: icons.backIcon, onPressed: () => Navigator.pushNamed(context, AppRoutes.homepageScreen))),
            backgroundColor: appTheme.whiteA700,
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: SizedBox(
                    width: 428.h,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      _buildImageEditShare(context, ImageConstant.imgUserImage),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 14.v),
                                  child: Text("Your Information", style: theme.textTheme.titleLarge)))),
                      SizedBox(height: 23.v),
                      _buildName(context),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.v),
                          child: Divider(indent: 30.h, endIndent: 26.h, color: appTheme.black900, thickness: 1)),
                      _buildEmail(context),
                      SizedBox(height: 19.v),
                      buildPointsWidget(points: 47),
                      SizedBox(height: 49.v)
                    ]))))));
  }

  Widget _buildImageEditShare(BuildContext context, String imagePath) => Container(
        decoration: AppDecoration.gradientPrimaryToSecondaryContainer,
        child: Stack(children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.all(16.h),
                  child: CircleAvatar(backgroundImage: AssetImage(imagePath), radius: 113.adaptSize))),
          Positioned(
              bottom: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildEditProfile(context), _buildShareProfile(context)]))
        ]),
      );

  /// Section Widget
  Widget _buildShareProfile(BuildContext context) {
    return CustomElevatedButton(
        height: 51.v,
        width: 181.h,
        text: "Share Profile",
        margin: EdgeInsets.only(right: 12.h),
        buttonStyle: CustomButtonStyles.fillLime,
        buttonTextStyle: theme.textTheme.titleLarge!,
        alignment: Alignment.bottomRight);
  }

  /// Section Widget
  Widget _buildEditProfile(BuildContext context) {
    return CustomElevatedButton(
        height: 51.v,
        width: 181.h,
        text: "Edit Profile",
        margin: EdgeInsets.only(left: 16.h),
        buttonStyle: CustomButtonStyles.fillLime,
        buttonTextStyle: theme.textTheme.titleLarge!,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfileScreen),
        alignment: Alignment.bottomLeft);
  }
}

Widget _buildName(BuildContext context) {
  String? displayName = Provider.of<AppState>(context).userDisplayName;
  // todo make it more beautiful
  return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 12.h), child: Text(displayName!, style: theme.textTheme.titleMedium));
}

Widget _buildEmail(BuildContext context) {
  String? email = Provider.of<AppState>(context).userEmail;
  return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 12.h), child: Text(email!, style: theme.textTheme.titleMedium));
}

Widget buildPointsWidget({num points = 0}) {
  return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 12.h),
      child: Text(points.toString(), style: theme.textTheme.titleMedium));
}
