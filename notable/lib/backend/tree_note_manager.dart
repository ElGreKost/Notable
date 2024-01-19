import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TreeNoteManager extends ChangeNotifier {

  late final DocumentReference _userRoot;
  String? _userUid;

  DocumentReference? _currentFolderRef;

  DocumentReference? get currentFolderRef => _currentFolderRef; // Reference to the current folder

  // Create a new folder
  List<Map<String, dynamic>> _currSubfolders = [];

  List<Map<String, dynamic>> get currSubfolders => _currSubfolders;
  List<Map<String, dynamic>> _currNotes = [];

  List<Map<String, dynamic>> get currNotes => _currNotes;

  void setUserUid(String? userUid) async {
    if (_userUid == null) {
      _userUid = userUid;
      _userRoot = _firestore.collection('users').doc(userUid);
      _currentFolderRef = _userRoot; // Start at the user's root
      Map<String, dynamic> content = await getCurrentFolderContent();
      _currSubfolders = content['folders'];
      _currNotes = content['notes'];
      print('Preexisting user\'s documents: $content \n $_currSubfolders, ||| $_currNotes');
      notifyListeners();
    }
  }

  Future<void> createFolder(String name) async {
    CollectionReference targetCollection =
        _currentFolderRef != null ? _currentFolderRef!.collection('folders') : _userRoot.collection('folders');
    final docRef = targetCollection.doc();
    final folder = {
      'id': docRef.id,
      'name': name,
      'pid': _currentFolderRef?.id,
    };

    await docRef.set(folder);
    _currSubfolders.add(folder);

    // Optionally, update the parent folder's subfolders array
    if (_currentFolderRef != _userRoot) {
      await _currentFolderRef!.update({
        'folders': FieldValue.arrayUnion([docRef.id])
      });
    }
    notifyListeners();
  }

  // Create a new note in the current folder
  Future<void> createNote(String title, String content) async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected to create a note');
    }

    final noteDocRef = _currentFolderRef!.collection('notes').doc();
    final note = {'id': noteDocRef.id, 'title': title, 'content': content};

    await noteDocRef.set(note);
    _currNotes.add(note);
    notifyListeners();
  }

  // Navigate to a subfolder
  Future<void> navigateToSubfolder(String folderId) async {
    _currentFolderRef = _currentFolderRef!.collection('folders').doc(folderId);
    Map<String, dynamic> content = await getCurrentFolderContent();
    _currSubfolders = content['folders'];
    _currNotes = content['notes'];
    notifyListeners();
  }

  // Move up to the parent folder
  Future<void> moveToParentFolder() async {
    if (_currentFolderRef == null || _currentFolderRef!.path == _userRoot.path) {
      throw Exception('Already at the user root level');
    }

    String path = _currentFolderRef!.path;
    List<String> pathSegments = path.split('/');
    if (pathSegments.length > 3) {
      // Considering 'users/{userId}/folders/...'
      pathSegments.removeRange(pathSegments.length - 2, pathSegments.length);
      String parentPath = pathSegments.join('/');
      _currentFolderRef = _firestore.doc(parentPath);
    } else {
      _currentFolderRef = _userRoot; // Move back to user root
    }
    Map<String, dynamic> content = await getCurrentFolderContent();
    _currSubfolders = content['folders'];
    _currNotes = content['notes'];
    notifyListeners();
  }

  // Retrieve contents of the current folder
  Future<Map<String, dynamic>> getCurrentFolderContentNames() async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected');
    }

    final folderDocRef = _currentFolderRef!;

    // Fetch subfolders
    final subfoldersSnapshot = await folderDocRef.collection('folders').get();
    final subfolders = subfoldersSnapshot.docs.map((doc) => doc.id).toList();

    // Fetch notes
    final notesSnapshot = await folderDocRef.collection('notes').get();
    final notes = notesSnapshot.docs.map((doc) => doc.data()).toList();

    return {
      'folders': subfolders,
      'notes': notes,
    };
  }
  // Fetch all the data in cwd
  Future<Map<String, dynamic>> getCurrentFolderContent() async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected');
    }

    final folderDocRef = _currentFolderRef!;

    // Fetch subfolders
    final subfoldersSnapshot = await folderDocRef.collection('folders').get();
    final subfolders = subfoldersSnapshot.docs.map((doc) => {'id': doc.id, 'name': doc.data()['name'], 'pid': doc.data()['pid']}).toList();

    // Fetch notes
    final notesSnapshot = await folderDocRef.collection('notes').get();
    final notes = notesSnapshot.docs.map((doc) => {'id': doc.id, 'title': doc.data()['title']}).toList();

    return {
      'folders': subfolders,
      'notes': notes,
    };
  }
}
