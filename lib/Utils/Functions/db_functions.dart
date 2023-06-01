import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheetsense/Authentication/signup_page.dart';
import 'package:sheetsense/Utils/Functions/auth_functions.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';

void updatUserInFirestore(String signedinUserEmail, String csvUrl) async {
  String userUID = auth.currentUser!.uid;
  try {
    await firestore.collection('Users').doc(userUID).set({
      'uid': userUID,
      'email': signedinUserEmail,
      'isPremium': false,
      'chat_count': 0,
      'csvUrl': csvUrl,
    });
  } catch (e) {
    print(e);
  }
}

void updatePromptResponseInFirestore(String prompt, String response) async {
  int count = await getChatCount();
  String userUID = auth.currentUser!.uid;
  try {
    final docRef = firestore.collection("Users").doc(userUID);
    docRef.update({
      'Prompt&Response$count': {prompt, response}
    });
  } catch (e) {
    print(e);
  }
}

Future<String> fetchUserCSVurl() async {
  String userUIDd = auth.currentUser!.uid;
  String errortext = "Error";
  try {
    final docRef = firestore.collection("Users").doc(userUIDd);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    String url = data['csvUrl'];
    return url;
  } catch (e) {
    return errortext;
  }
}

Future<bool> updateNewCsvLink(String link) async {
  String url = parseUri(link);
  String userUIDd = auth.currentUser!.uid;
  try {
    final docRef = firestore.collection("Users").doc(userUIDd);
    docRef.update({'csvUrl': url});
    return true;
  } catch (e) {
    return false;
  }
}

void updateChatCount() async {
  String userUIDd = auth.currentUser!.uid;
  int count = await getChatCount();
  try {
    final docRef = firestore.collection("Users").doc(userUIDd);
    docRef.update({'chat_count': count + 1});
  } catch (e) {
    print("error updating chat count");
  }
}

Future<bool> checkIsPremium() async {
  String userUIDd = auth.currentUser!.uid;
  try {
    final docRef = firestore.collection("Users").doc(userUIDd);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    bool isPremium = data['isPremium'];
    return isPremium;
  } catch (e) {
    throw Exception();
  }
}

Future<int> getChatCount() async {
  String userUIDd = auth.currentUser!.uid;
  try {
    final docRef = firestore.collection("Users").doc(userUIDd);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    int count = data['chat_count'];
    return count;
  } catch (e) {
    throw Exception();
  }
}
