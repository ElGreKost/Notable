import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if email is already in use
  Future<bool> isEmailInUse(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty; // Email is in use if sign-in methods exist
    } catch (e) {
      print('Error checking email existence: $e');
      throw ('An error occurred while checking email existence.');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      // Check if the email is already in use
      bool emailExists = await isEmailInUse(email);

      if (emailExists) {
        throw ('The email address is already in use.');
      }

      // Continue with the sign-up process if the email is not in use
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          throw ('Password is too weak. It should contain at least 6 characters.');
        } else {
          throw ('An error occurred during signup.');
        }
      } else {
        throw ('An unexpected error occurred during signup.');
      }
    }
  }

  // Sign in with an existing account
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          throw ('Invalid email/password');
        } else {
          throw ('An error occurred during sign-in.');
        }
      } else if (e is FirebaseException && e.code == 'network-request-failed') {
        throw ('Network error. Please check your internet connection.');
      } else {
        throw ('An unexpected error occurred during sign-in.');
      }
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error: $e');
      throw ('An error occurred during sign-out.');
    }
  }
}

