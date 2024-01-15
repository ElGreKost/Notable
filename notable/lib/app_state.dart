import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
}
