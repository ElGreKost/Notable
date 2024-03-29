import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../backend/app_state.dart';
import '../../backend/tree_note_manager.dart';
import '../../core/app_export.dart';

class OpennoteScreen extends StatelessWidget {
  OpennoteScreen({Key? key}) : super(key: key);

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String ocrText = Provider.of<TreeNoteManager>(context).text ?? 'no text';
    final String noteTitle = Provider.of<TreeNoteManager>(context).title ?? 'no title';
    textController.text = ocrText;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          elevation: 0,
          leading: icons.logoWidget(context: context),
          title: Text(noteTitle, style: CustomTextStyles.titleMediumWhiteA700),
          centerTitle: true,
          actions: _buildActionButtons(context),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_leaves.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.h),
              child: TextFormField(
                controller: textController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: CustomTextStyles.titleSmallGray800,
                decoration: InputDecoration(
                  hintText: "Write your notes here...",
                  fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(20.h),
                ),
                cursorColor: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<IconButton> _buildActionButtons(BuildContext context) => [
        IconButton(icon: Icon(Icons.published_with_changes, color: appTheme.whiteA700),
            onPressed: () {
                Provider.of<TreeNoteManager>(context, listen: false).setText(textController.text);
            }),
        IconButton(icon: Icon(Icons.share, color: appTheme.whiteA700), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.camera_alt_outlined, color: appTheme.whiteA700),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cameraScreen))
      ];
}
