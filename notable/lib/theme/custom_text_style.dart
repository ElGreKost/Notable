import 'package:flutter/material.dart';
import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';

// todo why are they not in theme so that they are picked by default?
/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyLargeWhiteA700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 17.fSize,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
  static get titleLargeKarlaWhiteA700 =>
      theme.textTheme.titleLarge!.karla.copyWith(
        color: appTheme.whiteA700,
        fontSize: 22.fSize,
      );
  static get titleLargeRegular => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallGray800 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray800,
      );
  static get titleSmallGray800_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray800,
      );
  static get titleSmallRobotoWhiteA700 =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.whiteA700,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
      );
}

extension on TextStyle {
  TextStyle get karla {
    return copyWith(
      fontFamily: 'Karla',
    );
  }

  TextStyle get jimNightshade {
    return copyWith(
      fontFamily: 'Jim Nightshade',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
}
