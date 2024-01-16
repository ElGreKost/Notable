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

  // used in camera. don't use provider do argument pass Drill Down
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
    await FirebaseFirestore.instance.collection('users').doc(userUid).collection('folders').add({
      'folderName': folderName, // Use the text from the controller
      'content': '',
      'userUid': userUid
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

        // Update the display name in the local state
        _user = FirebaseAuth.instance.currentUser;
        notifyListeners();

        print('After update - Updated display name: ${_user!.displayName}');
      }
    } catch (error) {
      print('Error updating display name: $error');
    }
  }

}
