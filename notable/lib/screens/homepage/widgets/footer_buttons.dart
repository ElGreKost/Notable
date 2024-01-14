import 'package:flutter/material.dart';
import 'package:notable/core/app_export.dart';

Widget footerButtons(context) => Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Icon(Icons.file_upload_outlined, color: appTheme.black900),
      CustomImageView(
          imagePath: ImageConstant.imgCam,
          height: 65.adaptSize,
          width: 65.adaptSize,
          margin: EdgeInsets.only(left: 21.h),
          onTap: () => Navigator.pushNamed(context, AppRoutes.cameraScreen))
    ]);
