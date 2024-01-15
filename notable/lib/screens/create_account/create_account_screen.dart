import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_floating_text_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

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
                    icon: icons.backIcon, onPressed: () => Navigator.pushNamed(context, AppRoutes.myProfileScreen)),
                title: Text('Edit Profile', style: CustomTextStyles.titleMediumWhiteA700),
                centerTitle: true,
                actions: [
                  IconButton(
                      icon: Icon(Icons.check_circle_rounded, color: appTheme.whiteA700),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.myProfileScreen))
                ]),
            backgroundColor: appTheme.whiteA700,
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: SizedBox(
                    width: 428.h,
                    child: Column(children: [
                      _buildPageHeadNavigation(context, ImageConstant.imgUserImage),
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
                                    _buildEmail(context)
                                  ]))))
                    ])))));
  }

  Widget _buildPageHeadNavigation(BuildContext context, String imagePath) {
    var R = 113.adaptSize;
    return Container(
      decoration: AppDecoration.gradientPrimaryToSecondaryContainer,
      child: Stack(alignment: Alignment.center, children: [
        Center(
          child: Padding(
              padding: EdgeInsets.all(16.h), child: CircleAvatar(backgroundImage: AssetImage(imagePath), radius: R)),
        ),
        Positioned(
            bottom: 0.3 * R, // Half outside the bottom of the avatar
            right: 0.7 * R, // Half outside the right of the avatar
            child: Container(
              decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  shape: BoxShape.circle,
                  border: Border.all(color: appTheme.whiteA700, width: 1.h)),
              child: IconButton(
                  icon: Icon(Icons.add_circle, color: theme.colorScheme.primary, size: 53.h), onPressed: () {}),
            )),
      ]),
    );
  }

  Widget _buildName(BuildContext context) {
    return CustomFloatingTextField(
        controller: nameController, labelText: " Name", labelStyle: theme.textTheme.titleMedium!, hintText: " Name");
  }

  Widget _buildEmail(BuildContext context) {
    String? email = Provider.of<AppState>(context).userEmail;
    return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 12.h),
        child: CustomFloatingTextField(
            controller: TextEditingController(text: email),
            labelText: "E-mail",
            labelStyle: theme.textTheme.titleMedium!,
            hintText: "mail@gmail.com"));
  }
}
