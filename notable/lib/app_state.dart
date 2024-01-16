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

  List<Map<String, dynamic>> _folders = []; // todo make it synchronous??

  List<Map<String, dynamic>> get folders => _folders;

  void setFolders(List<Map<String, dynamic>> newFolders) {
    _folders = newFolders;
    notifyListeners();
  }

  List<String> get folderNames {
  var names = _folders.map((folder) => folder['folderName'] as String).toList();
  names.sort((a, b) => a.compareTo(b));
  return names;
}

  void addFolder(String folderName) async {
    // todo Giannis make sure folderName is unique in the database
    await FirebaseFirestore.instance.collection('Users').doc(userUid).collection('folders').add({
      'folderName': folderName, // Use the text from the controller
      'content': '',
      'userUid': userUid
    });
    _folders.add({'folderName': folderName, 'content': '', 'userUid': userUid});
    notifyListeners();
  }

  void deleteFolder(String folderName) async {
    try {
      // Reference to the user's 'folders' subcollection
      var folders = FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders');

      // Query to find the specific folder by name
      var querySnapshot = await folders.get();

      // kostiskak132002@gmail.com
      // {folderName: course 2, content: , userUid: X591i6Ga0tZZEHfOksKKz8nKK5C2}

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var folderContents = doc.data();
          if (folderContents['folderName'] == folderName) {
            await doc.reference.delete();
            _folders.removeWhere((folder) => folder['folderName'] == folderName);
            notifyListeners();
          }
        }
        print('Folder deleted successfully.');
      } else {
        print('No folder found with the specified name.');
      }
    } catch (e) {
      print('Error deleting folder: $e');
    }
  }
}
