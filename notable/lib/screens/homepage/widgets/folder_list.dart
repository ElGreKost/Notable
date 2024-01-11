import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class FoldersListView extends StatelessWidget {
  final List<String> folderNames;

  const FoldersListView({
    Key? key,
    required this.folderNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.h),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 31.v),
            itemCount: folderNames.length,
            itemBuilder: (context, index) {
              return _FoldersItemWidget(folderNames[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _FoldersItemWidget(folderName) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              folderName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Text overflow with ellipsis
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: 10.h), // You can adjust the spacing as needed
          Icon(Icons.file_download_outlined, color: appTheme.black900),
        ],
      ),
    );
  }

}
