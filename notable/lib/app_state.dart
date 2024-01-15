import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppState extends ChangeNotifier {
  User? _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  String? get userUid => _user?.uid;
  String? get userEmail => _user?.email;
  String? get userDisplayName => _user!.email!.split('@').first;

  String? _text;
  String? get text => _text;

  void setText(String? newText) {
    _text = newText;
    notifyListeners();
  }

  void deleteFolder(String folderName) async {
    try {
      // Reference to the user's 'folders' subcollection
      var folders = FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders');

      // Query to find the specific folder by name
      var querySnapshot = await folders.where('title', isEqualTo: folderName).get();

      // Loop through the query results and delete each folder
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      notifyListeners();
      print('Folder deleted successfully.');
    } catch (e) {
      print('Error deleting folder: $e');
    }
  }
}
