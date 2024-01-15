import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../../core/app_export.dart';
import '../../widgets/edge_navigators.dart';

class TextPreviewPage extends StatelessWidget {
  const TextPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String ocrText = Provider.of<AppState>(context).text ?? 'You have beautiful notes!';
    final GlobalKey _tooltipKey = GlobalKey();

    void showCopiedTooltip() {
      final dynamic tooltip = _tooltipKey.currentState;
      tooltip?.ensureTooltipVisible();
      Future.delayed(const Duration(seconds: 1), () {
        tooltip?.deactivate();
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: headerNavigator(context, 'Text Preview'),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16.v, horizontal: 24.h),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: SelectableText(ocrText, style: theme.textTheme.bodyMedium),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Tooltip(
                    key: _tooltipKey,
                    message: 'Copied',
                    child: IconButton(
                      icon: const Icon(Icons.content_copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: ocrText));
                        showCopiedTooltip();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.opennoteScreen),
            tooltip: 'Go to Text Screen',
            child: const Icon(Icons.arrow_forward)),
      ),
    );
  }
}
