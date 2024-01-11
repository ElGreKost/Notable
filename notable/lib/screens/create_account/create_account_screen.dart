import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_phone_number.dart';

// ignore_for_file: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  // TODO WHAT IS KEY?
  CreateAccountScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('30');

  TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //concerning all controllers: they are used to manage the text entered into text fields.
  //concerning the (super)key: we need to identify uniquely multiple widget instances
  //which is keys are calles identifiers for widgets.
  //about GlobalKey: GlobalKey is a specific type of key that can be used to uniquely
  //identify a widget across different parts of the widget tree
  //about superkey: super: Calls the constructor of the superclass, ensuring proper initialization
  //in widget constructors
  //in the specific code above the key is supposed to help identify different instances of
  //text that is the data of every user (?)

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
                    child: Column(children: [
                      _buildPageHeadNavigation(context),
                      SizedBox(height: 12.v),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 12.h, right: 12.h, bottom: 5.v),
                                  child: Column(children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 8.h),
                                            child: Padding(
                                                padding: EdgeInsets.only(top: 14.v),
                                                child: Text("Your Information", style: theme.textTheme.titleLarge)))),
                                    SizedBox(height: 23.v),
                                    _buildName(context),
                                    SizedBox(height: 36.v),
                                    _buildSurname(context),
                                    SizedBox(height: 35.v),
                                    _buildPhoneNumber(context),
                                    Divider(indent: 17.h, endIndent: 15.h),
                                    SizedBox(height: 36.v),
                                    _buildEmail(context, 'aabraimakis@gmail.com'),
                                    SizedBox(height: 62.v),
                                    _buildCreateAccount1(context)
                                  ]))))
                    ])))));
  }

  Widget _buildPageHeadNavigation(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.v),
        decoration: AppDecoration.gradientPrimaryToSecondaryContainer,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomAppBar(
              height: 38.v,
              leadingWidth: 35.h,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    icon: icons.backIcon,
                    onPressed: () {
                      onTapClose(context);
                    }),
              ),
              title: Text('Edit Profile',
                  style: TextStyle(
                    color: appTheme.whiteA700,
                    fontSize: 20.fSize,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  )),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: Icon(Icons.check_circle_rounded, color: appTheme.whiteA700),
                    onPressed: () {
                      onTapIconButton(context);
                    })
              ]),
          SizedBox(height: 21.v),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  height: 227.adaptSize,
                  width: 227.adaptSize,
                  margin: EdgeInsets.only(right: 89.h),
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgEllipse1,
                        height: 227.adaptSize,
                        width: 227.adaptSize,
                        radius: BorderRadius.circular(113.h),
                        alignment: Alignment.center),
                    Padding(
                        padding: EdgeInsets.only(right: 11.h),
                        child: IconButton(
                            icon: Icon(Icons.add_circle, color: theme.colorScheme.primary, size: 53.h,),
                            // alignment: Alignment.bottomRight,
                            onPressed: () { /* add function to add picture from gallery or camera */ },
                        ))
                  ]))),
          SizedBox(height: 21.v)
        ]));
  }
// todo make the countries change
  Widget _buildName(BuildContext context) {
    return CustomFloatingTextField(
        controller: nameController, labelText: " Name", labelStyle: theme.textTheme.titleMedium!, hintText: " Name");
  }

  Widget _buildSurname(BuildContext context) {
    return CustomFloatingTextField(
        controller: surnameController,
        labelText: "Surname",
        labelStyle: theme.textTheme.titleMedium!,
        hintText: "Surname");
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return CustomPhoneNumber(
        country: selectedCountry,
        controller: phoneNumberController,
        onTap: (Country value) {
          selectedCountry = value;
        });
  }

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

  Widget _buildCreateAccount1(BuildContext context) {
    return CustomElevatedButton(
        width: 256.h,
        text: "Create  account",
        margin: EdgeInsets.only(left: 17.h),
        onPressed: () {
          onTapCreateAccount(context);
        },
        alignment: Alignment.centerLeft);
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the myProfileScreen when the action is triggered.
  onTapIconButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.myProfileScreen);
  }

  /// Navigates to the myProfileScreen when the action is triggered.
  onTapCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.myProfileScreen);
  }
}
