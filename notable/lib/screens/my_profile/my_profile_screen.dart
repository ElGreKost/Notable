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
            backgroundColor: appTheme.whiteA700,
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: SizedBox(
                    width: 428.h,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      _buildImageEditShare(context, ImageConstant.imgEllipse1),
                      SizedBox(height: 23.v),
                      _buildName(context),
                      SizedBox(height: 36.v),
                      _buildSurname(context),
                      SizedBox(height: 35.v),
                      Padding(padding: EdgeInsets.only(left: 15.h, right: 12.h), child: _buildPhoneNumber(context)),
                      Divider(indent: 30.h, endIndent: 26.h),
                      SizedBox(height: 36.v),
                      _buildEmail(context, "aabraimakis@gmailcom"),
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
        onPressed: () {
          onTapEditProfile(context);
        },
        alignment: Alignment.bottomLeft);
  }

  /// Section Widget
  Widget _buildImageEditShare(BuildContext context, String imagePath) {
    return SizedBox(
        height: 379.v,
        width: 428.h,
        child: Stack(alignment: Alignment.topCenter, children: [
          CustomImageView(
              imagePath: ImageConstant.imgMaterialSymbol,
              height: 20.adaptSize,
              width: 20.adaptSize,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 19.v)),
          Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  height: 354.v,
                  width: 428.h,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 19.v),
                            decoration: AppDecoration.gradientPrimaryToSecondaryContainer,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      icon: icons.backIcon,
                                      onPressed: () {
                                        onTapImgArrowLeft(context);
                                      }),
                                  CustomImageView(
                                      imagePath: imagePath,
                                      height: 227.adaptSize,
                                      width: 227.adaptSize,
                                      radius: BorderRadius.circular(113.h),
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.only(right: 74.h)),
                                  SizedBox(height: 12.v)
                                ]))),
                    _buildShareProfile(context),
                    _buildEditProfile(context),
                  ]))),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text("Your Information", style: theme.textTheme.titleLarge)))
        ]));
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 12.h),
        child: CustomFloatingTextField(
            controller: nameController,
            labelText: " Name",
            labelStyle: theme.textTheme.titleMedium!,
            hintText: " Name"));
  }

  /// Section Widget
  Widget _buildSurname(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 12.h),
        child: CustomFloatingTextField(
            controller: surnameController,
            labelText: "Surname",
            labelStyle: theme.textTheme.titleMedium!,
            hintText: "Surname"));
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 12.h),
        child: CustomPhoneNumber(
            country: selectedCountry,
            controller: phoneNumberController,
            onTap: (Country value) {
              selectedCountry = value;
            }));
  }

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

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }

  /// Navigates to the createAccountScreen when the action is triggered.
  onTapEditProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.createAccountScreen);
  }
}
