import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TreeNoteManager {
  late final DocumentReference _userRoot;
  DocumentReference? _currentFolderRef;

  TreeNoteManager(String userId) {
    _userRoot = _firestore.collection('users').doc(userId);
    _currentFolderRef = _userRoot; // Start at the user's root
  }

  DocumentReference? get currentFolderRef => _currentFolderRef; // Reference to the current folder

  // Create a new folder
  Future<void> createFolder(String name) async {
    CollectionReference targetCollection = _currentFolderRef != null
        ? _currentFolderRef!.collection('subfolders')
        : _userRoot.collection('folders');

    final docRef = targetCollection.doc();
    final folder = {
      'id': docRef.id,
      'name': name,
      'parentId': _currentFolderRef?.id,
    };

    await docRef.set(folder);

    // Optionally, update the parent folder's subfolders array
    if (_currentFolderRef != null) {
      await _currentFolderRef!.update({
        'subfolders': FieldValue.arrayUnion([docRef.id])
      });
    }
  }

  // Create a new note in the current folder
  Future<void> createNote(String title, String content) async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected to create a note');
    }

    final noteDocRef = _currentFolderRef!.collection('notes').doc();
    final note = {'id': noteDocRef.id, 'title': title, 'content': content};

    await noteDocRef.set(note);
  }

  // Navigate to a subfolder
  Future<void> navigateToSubfolder(String folderId) async {
    if (_currentFolderRef == null) {
      _currentFolderRef = _userRoot.collection('folders').doc(folderId);
    } else {
      _currentFolderRef = _currentFolderRef!.collection('subfolders').doc(folderId);
    }
  }

  // Move up to the parent folder
  Future<void> moveToParentFolder() async {
    if (_currentFolderRef == null || _currentFolderRef!.path == _userRoot.path) {
      throw Exception('Already at the user root level');
    }

    String path = _currentFolderRef!.path;
    List<String> pathSegments = path.split('/');
    if (pathSegments.length > 3) { // Considering 'users/{userId}/folders/...'
      pathSegments.removeRange(pathSegments.length - 2, pathSegments.length);
      String parentPath = pathSegments.join('/');
      _currentFolderRef = _firestore.doc(parentPath);
    } else {
      _currentFolderRef = _userRoot; // Move back to user root
    }
  }

  // Retrieve contents of the current folder
  Future<Map<String, dynamic>> getCurrentFolderContent() async {
    if (_currentFolderRef == null) {
      throw Exception('No current folder selected');
    }

    final folderDocRef = _currentFolderRef!;

    // Fetch subfolders
    final subfoldersSnapshot = await folderDocRef.collection('subfolders').get();
    final subfolders = subfoldersSnapshot.docs.map((doc) => doc.id).toList();

    // Fetch notes
    final notesSnapshot = await folderDocRef.collection('notes').get();
    final notes = notesSnapshot.docs.map((doc) => doc.data()).toList();

    return {
      'subfolders': subfolders,
      'notes': notes,
    };
  }
}
