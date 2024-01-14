import 'package:flutter/material.dart';
import 'package:notable/core/app_export.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../services/auth_service.dart';
import '../../../widgets/alerts.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'homepage_logo.dart';


Row header(BuildContext context, String name, String imagePath) {
  var userInfo = ListTile(
      title: Text(name, maxLines: 2, overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleMediumWhiteA700),
      trailing:
      CustomImageView(imagePath: imagePath, height: 51.v, width: 54.h, radius: BorderRadius.circular(27.h)));

  return Row(children: [
    Container(width: 120.h, decoration: AppDecoration.fillPrimary, child: homePageLogo(context)),
    Expanded(
      child: Column(children: [
        Container(
            padding: EdgeInsets.fromLTRB(8.h, 8.v, 32.h, 8.v),
            decoration: AppDecoration.fillPrimary,
            child: userInfo),
        SizedBox(height: 5.v),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Align(
              alignment: Alignment.centerRight, child: myprofileSingoutButtons(context: context, maxWidth: 220.h)),
        ),
      ]),
    )
  ]);
}



Widget myprofileSingoutButtons({context, maxWidth}) {
  final AuthService authService = AuthService();


  var myprofiileButton = CustomElevatedButton(
      height: 27.0.h,
      width: 80.0.v,
      text: "Profile",
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