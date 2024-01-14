import 'package:flutter/material.dart';
import 'package:notable/core/app_export.dart';

Widget userInfoHeader({required String name, required String imagePath}) => ListTile(
    title: Text(name, maxLines: 2, overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleMediumWhiteA700),
    trailing: CustomImageView(imagePath: imagePath, height: 51.v, width: 54.h, radius: BorderRadius.circular(27.h)));

