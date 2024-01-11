import 'package:flutter/material.dart';
import 'package:notable/core/app_export.dart';

class UserInfoHeader extends StatelessWidget {
  final String name;
  final String imagePath;

  const UserInfoHeader({Key? key, required this.name, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 107.h,
          margin: EdgeInsets.only(top: 4.v),
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.titleMediumWhiteA700, // Ensure this style exists
          ),
        ),
        CustomImageView(
          imagePath: imagePath,
          height: 51.v,
          width: 54.h,
          radius: BorderRadius.circular(27.h),
          margin: EdgeInsets.only(left: 41.h),
        ),
      ],
    );
  }
}

class UserInfoSideMenu extends StatelessWidget {
  final List<String> texts; // Constructor parameter for list of texts

  const UserInfoSideMenu({Key? key, required this.texts}) : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: texts
          .map((text) => _UserInfoMolecule(text))
          .expand((widget) => [widget, SizedBox(height: 15.6.v)]) // Adds spacing between each widget
          .toList()
          .sublist(0, texts.length * 2 - 1), // Removes the last SizedBox to prevent extra space at the bottom
    );
  }

  Widget _UserInfoMolecule(String text) {
    return Container(
      width: 120.h,
      height: 47.v,
      padding: EdgeInsets.only(top: 2.v, left: 6.h, bottom: 2.v),
      decoration: BoxDecoration(color: appTheme.whiteA700),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 31.h,
            height: 31.v,
            decoration: BoxDecoration(color: appTheme.green900),
          ),
          SizedBox(width: 8.h),
          Text(
            text,
            style: TextStyle(
              color: appTheme.blueGray700,
              fontSize: 12.fSize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}