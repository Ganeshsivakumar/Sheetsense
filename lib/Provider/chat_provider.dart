import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/Functions/db_functions.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';

class ChatProvider extends ChangeNotifier {
  late String message = " ";
  late String csvurl = " ";

  StreamController<String> chatStream = StreamController.broadcast();

  void updateChatStream() {
    if (message.isEmpty) {
      chatStream.sink.add(ChatProviderText.exception);
    } else {
      chatStream.sink.add(message);
    }
  }

  Future<bool> parseUrl(String url) async {
    String parsedUrl = parseUri(url);
    if (parsedUrl == "wrong format") {
      return false;
    } else {
      csvurl = parsedUrl;
      return true;
    }
    //csvurl = parsedUrl;
  }

  void upgradeToPremium() {
    chatStream.sink.add(ChatProviderText.premiumPlan);
  }

  void updateMessage(String text) {
    message = text;
    notifyListeners();
    //print(message);
  }

  void asksheetsense(String question) async {
    chatStream.sink.add(ChatProviderText.loading);
    try {
      String sheetsenseUrl = Links.gptUrl;
      String url = await fetchUserCSVurl();
      if (url.isEmpty) {
        chatStream.sink.add(ChatProviderText.exception);
      } else {
        String ques = question;
        String finalUrl = "$sheetsenseUrl/$url/$ques";

        final result = await http.get(Uri.parse(finalUrl));
        String response = result.body.toString();
        updateMessage(response);
        updatePromptResponseInFirestore(ques, response);
        updateChatCount();
      }
    } catch (e) {
      chatStream.sink.add(ChatProviderText.exception);
    }
  }
}
