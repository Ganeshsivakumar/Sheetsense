import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String email = "ganeshsivakumar85@gmail.com";
  String password = "1234567";
  void updateEmail(String emaill) {
    email = emaill;
    //password = passwordd;
    notifyListeners();
  }

  void updatePassword(String passwordd) {
    password = passwordd;
    notifyListeners();
  }
}
