import 'package:http/http.dart' as http;
import 'package:sheetsense/Authentication/signup_page.dart';

String parseUri(String url) {
  if (url.contains("/edit?usp=sharing")) {
    final modifiedUrl =
        url.replaceAll('/edit?usp=sharing', '/export?format=csv');

    String parsedUrl = Uri.encodeComponent(modifiedUrl);
    return parsedUrl;
  } else if (url.contains('/edit?usp=drivesdk')) {
    final modifiedUrl =
        url.replaceAll('/edit?usp=drivesdk', '/export?format=csv');

    String parsedUrl = Uri.encodeComponent(modifiedUrl);
    return parsedUrl;
  } else {
    const String error = "wrong format";
    return error;
  }
}

Future<bool> isGoogleSheetsLinkPublic(String link) async {
  try {
    var response = await http.get(Uri.parse(link));
    var html = response.body;
    if (html.contains("Only people with the link can view")) {
      return false;
    } else if (html.contains("Sign in to continue to Google Sheets")) {
      return false;
    } else {
      return true;
    }
  } catch (e) {
    return false;
  }
}

bool isGoogleSheetsLink(String link) {
  if (link.contains("docs.google.com/spreadsheets")) {
    return true;
  } else {
    return false;
  }
}

bool isLoggedIn() {
  String? userUIDd = auth.currentUser?.uid;
  if (userUIDd == null) {
    return false;
  } else {
    return true;
  }
}
