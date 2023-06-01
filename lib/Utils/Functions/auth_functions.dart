import 'package:sheetsense/Authentication/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
Future<bool> createUser(String email, String password) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> loginUser(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}
