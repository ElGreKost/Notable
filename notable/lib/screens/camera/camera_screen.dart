import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:notable/core/utils/size_utils.dart';

import '../../theme/theme_helper.dart';
import '../textpreview/textpreview_page.dart';

class CameraScreen extends StatefulWidget {
  @override
  _cameraScreenState createState() => _cameraScreenState();
}

class _cameraScreenState extends State<CameraScreen> {
  CameraController? cameraController;
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;
  List<XFile>? galleryImages;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    fetchGalleryImages();
  }

  Future<void> fetchGalleryImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        galleryImages = pickedFiles;
      });
    }
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
    cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    await cameraController!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Check if camera is initialized
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container(); // or a loader
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus your Note'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CameraPreview(cameraController!),
          galleryImages != null ? buildGalleryView() : const SizedBox(height: 100),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(16.h, 16.v, 16.h, 24.v),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Placeholder for alignment
            SizedBox(width: 48.h),
            FloatingActionButton(
              backgroundColor: theme.colorScheme.onPrimaryContainer,
              onPressed: () => onTapCamera(context), // Bigger camera icon
              elevation: 4.0,
              child: Icon(Icons.camera, size: 36.h),
            ),
            FloatingActionButton(
              backgroundColor: theme.colorScheme.onPrimaryContainer,
              onPressed: () => fetchGalleryImages(), // Standard size
              mini: true,
              child: const Icon(Icons.photo_library), // Makes the button a bit smaller
            ),
          ],
        ),
      ),
    );
  }

  // Build the gallery view
  Widget buildGalleryView() {
    return SizedBox(
      height: 100.h, // Adjust as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: galleryImages?.length ?? 0,
        itemBuilder: (context, index) {
          final image = galleryImages![index];
          return Image.file(File(image.path)); // Display the image
        },
      ),
    );
  }

  onTapCamera(BuildContext context) async {
    try {
      final image = await cameraController!.takePicture();
      String ocrText = await processImageForOCR(image.path);
      Navigator.push(context, MaterialPageRoute(builder: (context) => TextPreviewPage(ocrText: ocrText)));
    } catch (e) {
      print(e); // Handle error
    }
  }

  Future<String> processImageForOCR(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    String ocrText = '';
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        ocrText += line.text;
      }
    }
    textRecognizer.close();
    return ocrText;
  }
}
