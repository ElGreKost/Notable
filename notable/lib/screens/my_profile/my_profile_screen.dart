import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_phone_number.dart';

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
                          SizedBox(height: 23.v),
                          _buildName(context),
                          SizedBox(height: 36.v),
                          _buildSurname(context),
                          SizedBox(height: 35.v),
                          Padding(padding: EdgeInsets.only(left: 15.h, right: 12.h), child: _buildPhoneNumber(context)),
                          Divider(indent: 30.h, endIndent: 26.h),
                          SizedBox(height: 36.v),
                          _buildEmail(context, "mail@gmailcom"),
                          SizedBox(height: 19.v),
                          buildPointsWidget(points: 47),
                          SizedBox(height: 49.v)
                        ]))))));
  }

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
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createAccountScreen),
        alignment: Alignment.bottomLeft);
  }

  Widget _buildImageEditShare(BuildContext context, String imagePath) =>
      Container(
        decoration: AppDecoration.gradientPrimaryToSecondaryContainer,
        child: Stack(children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.all(16.h),
                  child: CircleAvatar(backgroundImage: AssetImage(imagePath), radius: 113.adaptSize))),
          Positioned(bottom: 0, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildShareProfile(context), _buildEditProfile(context)]))
        ]),
      );
}

// Align(
// alignment: Alignment.bottomLeft,
// child: Padding(
// padding: EdgeInsets.only(left: 21.h),
// child: Text("Your Information", style: theme.textTheme.titleLarge)))

/// Section Widget
Widget _buildName(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 12.h),
      child: CustomFloatingTextField(
        // controller: nameController,
          labelText: " Name",
          labelStyle: theme.textTheme.titleMedium!,
          hintText: " Name"));
}

/// Section Widget
Widget _buildSurname(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 12.h),
      child: CustomFloatingTextField(
        // controller: surnameController,
          labelText: "Surname",
          labelStyle: theme.textTheme.titleMedium!,
          hintText: "Surname"));
}

/// Section Widget
Widget _buildPhoneNumber(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 12.h),
      child: const Text('needs debug'));
}
// CustomPhoneNumber(
// country: selectedCountry,
// controller: phoneNumberController,
// onTap: (Country value) {
// selectedCountry = value;
// })
/// Section Widget
Widget _buildEmail(BuildContext context, String email) {
  return SizedBox(
      height: 69.v,
      width: 401.h,
      child: Stack(alignment: Alignment.topLeft, children: [
        Align(
            alignment: Alignment.center,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48.h, vertical: 8.v),
                decoration: AppDecoration.outlineLime.copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(height: 8.v), Text(email, style: theme.textTheme.titleMedium)]))),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 11.h), child: Text("E-mail", style: theme.textTheme.titleSmall)))
      ]));
}

Widget buildPointsWidget({num points = 0}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      height: 69.v,
      width: 113.h,
      margin: EdgeInsets.only(left: 23.h),
      child: Stack(alignment: Alignment.topLeft, children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
            decoration: AppDecoration.outlineLime.copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 9.v),
                Text(points.toString(), style: theme.textTheme.titleMedium), // Points displayed here
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: Text("Points", style: theme.textTheme.titleSmall),
          ),
        ),
      ]),
    ),
  );
}
