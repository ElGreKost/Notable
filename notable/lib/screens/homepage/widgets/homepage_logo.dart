import 'package:flutter/widgets.dart';

import '../../../theme/theme_helper.dart';

Widget homePageLogo(context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      RotatedBox(
        quarterTurns: 3, // Rotate 90 degrees clockwise
        child: Text(
          "Notable",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall, // todo Jim Nightshade on displayMedium
        ),
      ),
      // SizedBox(width: 2.h), // Controlled spacing
      icons.logoWidget(context: context),
    ],
  );
}