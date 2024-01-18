// import 'dart:js_interop';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AppState extends ChangeNotifier {
  // User
  User? _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  String? get userUid => _user?.uid;

  String? get userEmail => _user?.email;

  String? get userDisplayName => _user!.email!.split('@').first;

  // Current Folder
  Map<String, dynamic> _currFolder = {};

  Map<String, dynamic> get currFolder => _currFolder;

  void setCurrFolder(String folderName) {
    _currFolder = _folders.firstWhere((folder) => folder['folderName'] == folderName);
    notifyListeners();
  }

  String get text => _currFolder['content'];

  String get title => _currFolder['folderName'];

  void setText(newText) async {
    // todo to make it read cheaper we could save somewhere the currFolderUid
    var querySnapshot = await FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders').get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        var folderContents = doc.data();
        if (folderContents['folderName'] == title) {
          await doc.reference.update({'content': newText});
          int currFolderIdx = _folders.indexWhere((folder) => folder['folderName'] == title);
          _folders[currFolderIdx]['content'] = newText;
          _currFolder['content'] = newText;
          notifyListeners();
        }
      }
    }
  }

  void renameDoc(newFolderName) async {
    // todo to make it read cheaper we could save somewhere the currFolderUid
    var querySnapshot = await FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders').get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        var folderContents = doc.data();
        if (folderContents['folderName'] == title) {
          await doc.reference.update({'folderName': newFolderName});
          int currFolderIdx = _folders.indexWhere((folder) => folder['folderName'] == title);
          _folders[currFolderIdx]['folderName'] = newFolderName;
          _currFolder['folderName'] = newFolderName;
          notifyListeners();
        }
      }
    }
  }

  // Folders
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

  void addNote(String folderName) async {
    // todo Giannis make sure folderName is unique in the database
    await FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders').add({
      'folderName': folderName, // Use the text from the controller
      'content': '',
      'userUid': userUid
    });
    _folders.add({'folderName': folderName, 'content': '', 'userUid': userUid});
    notifyListeners();
  }

  void addFolder(String folderName) async {
    // todo Achilleas
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'folderName': folderName, // Use the text from the controller
    });
    _folders.add({'folderName': folderName, 'content': '', 'userUid': userUid});
    notifyListeners();
  }

  void deleteFolder(String folderName) async {
    try {
      var folders = FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders');

      var querySnapshot = await folders.get();

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

  void updateDisplayName(String newDisplayName) async {
    try {
      // Ensure that the _user property is not null before proceeding
      if (_user != null) {
        print('Before update - Current display name: ${_user!.displayName}');

        // Update the display name
        await _user!.updateDisplayName(newDisplayName);
        _user = FirebaseAuth.instance.currentUser;
        notifyListeners();

        print('After update - Updated display name: ${_user!.displayName}');
      }
    } catch (error) {
      print('Error updating display name: $error');
    }
  }

  void updateImage() async {
    // Pick an image from the device using image_picker
    XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // Upload the image to Firebase Storage
    String? imageUrl;
    if (imageFile != null) {
      Reference storageReference = FirebaseStorage.instance.ref().child('images/${imageFile.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
      await uploadTask.whenComplete(() async {
        await uploadTask.snapshot.ref.getDownloadURL().then((downloadUrl) {
          imageUrl = downloadUrl;
        });
      });

      // Update the user profile data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(_user?.uid).update({'imageUrl': imageUrl});
      _user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    }
  }
}
