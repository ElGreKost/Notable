import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

import '../../../theme/theme_helper.dart';

class CustomBreadcrumb extends StatelessWidget {
  final List<String> breadcrumbs;
  final Function(int) onTapBreadcrumb;

  CustomBreadcrumb({Key? key, required this.breadcrumbs, required this.onTapBreadcrumb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BreadCrumb(
      overflow: ScrollableOverflow(
        keepLastDivider: false,
        reverse: false,
        direction: Axis.horizontal,
      ),
      items: breadcrumbs
          .asMap()
          .entries
          .map(
            (entry) => BreadCrumbItem(
          content: Text(entry.value),
          onTap: () => onTapBreadcrumb(entry.key),
        ),
      )
          .toList(),
      divider: Icon(Icons.chevron_right),
    );
  }
}

class GradientBreadcrumb extends StatelessWidget {
  final List<String> breadcrumbs;
  final Function(int) onTapBreadcrumb;

  GradientBreadcrumb({
    Key? key,
    required this.breadcrumbs,
    required this.onTapBreadcrumb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0.5),
          end: Alignment(1, 0.5),
          colors: [
            theme.colorScheme.primary,
            appTheme.teal2007c,
            theme.colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CustomBreadcrumb(
        breadcrumbs: breadcrumbs,
        onTapBreadcrumb: onTapBreadcrumb,
      ),
    );
  }
}