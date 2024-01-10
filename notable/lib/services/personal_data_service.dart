import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalDataService {
  final CollectionReference _personalDataCollection =
  FirebaseFirestore.instance.collection('personal_data');

  // Store personal data in Firestore
  Future<void> storePersonalData(String name, String surname, String phoneNumber) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _personalDataCollection.doc(user.uid).set({
          'name': name,
          'surname': surname,
          'phone_number': phoneNumber,
        });
      } else {
        throw ('User not signed in.');
      }
    } catch (e) {
      print('Error storing personal data: $e');
      throw ('An error occurred while storing personal data.');
    }
  }

  // Retrieve personal data from Firestore
  Future<Map<String, dynamic>> getPersonalData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final DocumentSnapshot snapshot = await _personalDataCollection.doc(user.uid).get();
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw ('User not signed in.');
      }
    } catch (e) {
      print('Error retrieving personal data: $e');
      throw ('An error occurred while retrieving personal data.');
    }
  }

  // Update personal data in Firestore
  Future<void> updatePersonalData(String name, String surname, String phoneNumber) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _personalDataCollection.doc(user.uid).update({
          'name': name,
          'surname': surname,
          'phone_number': phoneNumber,
        });
      } else {
        throw ('User not signed in.');
      }
    } catch (e) {
      print('Error updating personal data: $e');
      throw ('An error occurred while updating personal data.');
    }
  }
}
