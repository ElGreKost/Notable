import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TreeNoteManager extends ChangeNotifier {
  late final DocumentReference _userRoot;
  String? _userUid;

  List<String> _breadcrumb = ['Your notes'];

  List<String> get breadcrumb => _breadcrumb;
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
    final folder = {'id': docRef.id, 'name': name, 'pid': _currentFolderRef?.id, 'type': 'folder'};

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
    final note = {'id': noteDocRef.id, 'title': title, 'content': content, 'type': 'note'};

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
    if (_breadcrumb.isNotEmpty) {
      _breadcrumb.removeLast();

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

  void appendToBreadcrumb(currentFolderName) {
    _breadcrumb.add(currentFolderName);
    notifyListeners();
  }

  // Fetch all the data in cwd
  Future<Map<String, dynamic>> getCurrentFolderContent() async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected');
    }

    final folderDocRef = _currentFolderRef!;

    // Fetch subfolders
    final subfoldersSnapshot = await folderDocRef.collection('folders').get();
    final subfolders = subfoldersSnapshot.docs
        .map((doc) => {'id': doc.id, 'name': doc.data()['name'], 'pid': doc.data()['pid']})
        .toList();

    // Fetch notes
    final notesSnapshot = await folderDocRef.collection('notes').get();
    final notes = notesSnapshot.docs.map((doc) => {'id': doc.id, 'title': doc.data()['title']}).toList();

    return {
      'folders': subfolders,
      'notes': notes,
    };
  }

  // Method to rename a folder or a note
  Future<void> renameItem(String itemId, String newName, String itemType) async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected');
    }

    CollectionReference collectionRef;
    if (itemType == 'folder') {
      collectionRef = _currentFolderRef!.collection('folders');
    } else if (itemType == 'note') {
      collectionRef = _currentFolderRef!.collection('notes');
    } else {
      throw Exception('Invalid item type');
    }

    DocumentReference itemRef = collectionRef.doc(itemId);
    await itemRef.update(itemType == 'folder' ? {'name': newName} : {'title': newName});

    // Update local data
    if (itemType == 'folder') {
      int idx = _currSubfolders.indexWhere((folder) => folder['id'] == itemId);
      if (idx != -1) {
        _currSubfolders[idx]['name'] = newName;
      }
    } else if (itemType == 'note') {
      int idx = _currNotes.indexWhere((note) => note['id'] == itemId);
      if (idx != -1) {
        _currNotes[idx]['title'] = newName;
      }
    }

    notifyListeners();
  }

  Future<void> deleteItem(String itemId, String itemType) async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected');
    }

    CollectionReference collectionRef;
    if (itemType == 'folder') {
      collectionRef = _currentFolderRef!.collection('folders');
    } else if (itemType == 'note') {
      collectionRef = _currentFolderRef!.collection('notes');
    } else {
      throw Exception('Invalid item type');
    }

    DocumentReference itemRef = collectionRef.doc(itemId);
    await itemRef.delete();

    // Update local data
    if (itemType == 'folder') {
      _currSubfolders.removeWhere((folder) => folder['id'] == itemId);
    } else if (itemType == 'note') {
      _currNotes.removeWhere((note) => note['id'] == itemId);
    }

    notifyListeners();
  }

  // Current Note
  Map<String, dynamic> _currNote = {};

  Map<String, dynamic> get currNote => _currNote;

  // Set the current note based on its title
  void setCurrNote(String title) {
    try {
      _currNote = _currNotes.firstWhere((note) => note['title'] == title);
    } catch (e) {
      // Handle the case where no note matches the title
      _currNote = {}; // Reset to an empty map or handle appropriately
    }
    notifyListeners();
  }

  // Getters for text and title of the current note
  String get text => _currNote['content'] ?? '';
  String get title => _currNote['title'] ?? '';

  // Update the text of the current note
  void setText(String newText) async {
    if (_currentFolderRef == null || _currNote.isEmpty) {
      throw Exception('No current folder or note selected');
    }

    String noteId = _currNote['id'];
    DocumentReference noteRef = _currentFolderRef!.collection('notes').doc(noteId);

    await noteRef.update({'content': newText});

    // Update the current note and the note list
    _currNote['content'] = newText;
    int noteIdx = _currNotes.indexWhere((note) => note['id'] == noteId);
    if (noteIdx != -1) {
      _currNotes[noteIdx]['content'] = newText;
    }

    notifyListeners();
  }

}
