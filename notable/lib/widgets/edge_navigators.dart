import 'package:flutter/material.dart';
import '../core/utils/size_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../routes/app_routes.dart';
import '../theme/theme_helper.dart';
import 'alerts.dart';
import 'custom_app_bar.dart';

/// Section Widget
PreferredSizeWidget headerNavigator(BuildContext context, String title) {
  var whiteText = TextStyle(
    color: appTheme.whiteA700,
    fontSize: 20.fSize,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );
  return CustomAppBar(
    centerTitle: true,
    leadingWidth: 33.h,
    leading: IconButton(
        icon: icons.backIcon,
        onPressed: () {
          Navigator.pop(context);
        }),
    title: Text(title, style: whiteText),
    actions: [icons.logoWidget(context: context)],
    backgroundColor: theme.colorScheme.primary,
  );
}

Widget footerNavigator(BuildContext context) {
  return Container(
    color: theme.colorScheme.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete_outline, size: 32),
          onPressed: () => onPressedCreateAlert(
              context: context,
              title: "DELETE TEXT",
              desc: "Are you sure?",
              type: AlertType.warning,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.homepageScreen)),
        ),
        IconButton(
          icon: const Icon(Icons.file_download_outlined, size: 32),
          onPressed: () => onPressedCreateAlert(
              context: context,
              title: "SAVE & EDIT",
              desc: "",
              type: AlertType.success,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.opennoteScreen)),
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_outline, size: 32),
          onPressed: () => onPressedCreateAlert(
              context: context,
              title: "BookMark",
              desc: "",
              type: AlertType.none,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.homepageScreen)),
        ),
      ],
    ),
  );
}

