import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/edge_navigators.dart';

class TextPreviewPage extends StatelessWidget {
  final String? ocrText;
  const TextPreviewPage({Key? key, this.ocrText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    print(ocrText);

    return SafeArea(
        child: Scaffold(
      appBar: headerNavigator(context, 'Text Preview'),
      body: Container(
          height: 690.v,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 16.v, horizontal: 24.h),
          child: SingleChildScrollView(
            child: Text(ocrText?? 'beautiful notes', style: theme.textTheme.bodyMedium),
          )),
      bottomNavigationBar: footerNavigator(context),
    ));
  }
}
