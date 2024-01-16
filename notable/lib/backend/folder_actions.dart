import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteFolder(String currUid, String folderNameToDelete) async {
  try {
    var folders = FirebaseFirestore.instance.collection('users').doc(currUid).collection('folders');

    var querySnapshot = await folders.where('title', isEqualTo: folderNameToDelete).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    print('Folder deleted successfully.');
  } catch (e) {
    print('Error deleting folder: $e');
  }
}

Future<void> renameFolder(String currUid, String oldFolderName, String newFolderName) async {
  try {
    var folders = FirebaseFirestore.instance.collection('users').doc(currUid).collection('folders');

    var querySnapshot = await folders.where('title', isEqualTo: oldFolderName).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({'title': newFolderName});
    }
    print('Folder renamed successfully.');
  } catch (e) {
    print('Error renaming folder: $e');
  }
}
