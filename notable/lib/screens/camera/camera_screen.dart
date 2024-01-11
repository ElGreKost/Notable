import '../../widgets/custom_app_bar.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../textpreview/textpreview_page.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
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

  // Fetch images from the gallery
  Future<void> fetchGalleryImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      galleryImages = pickedFiles;
    });
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
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container(); // or a loader
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Focus your Note'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CameraPreview(cameraController!),
          galleryImages != null ? buildGalleryView() : SizedBox(height: 100),
        ],
      ), // Display the camera preview
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement your camera shot function
          onTapCamera(context);
        },
        child: Icon(Icons.camera),
      ),
    );
  }

  // Build the gallery view
  Widget buildGalleryView() {
    return Container(
      height: 100, // Adjust as needed
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
      final ocrText = await processImageForOCR(image.path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TextPreviewPage(ocrText: ocrText)
        )
      );

    } catch (e) {
      print(e); // Handle error
    }
  }

  Future<String> processImageForOCR(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String fullText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        print(line.text);
      }
    }
    textRecognizer.close();
    return fullText;
  }
}
