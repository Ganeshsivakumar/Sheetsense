import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Provider/chat_provider.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';
import 'package:sheetsense/Utils/mixpanel.dart';
import 'package:sheetsense/Widgets/common_widgets.dart';
import 'package:sheetsense/Widgets/chat_widgets.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [LoginButton(padding: 100)],
            ),
            const SheetsImage(height: 300, width: 300),
            PageTitlee(fontsize: 25, title: PageTitles.homeTitle),
            WebChatForm(
                onPressed: () async {
                  //mixpanel.track("onTapChat_false");
                  String link = urlController.text;
                  bool isGoogleSheets = isGoogleSheetsLink(link);
                  bool isPublic = await isGoogleSheetsLinkPublic(link);
                  if (isGoogleSheets & isPublic) {
                    bool isRightlink =
                        await Provider.of<ChatProvider>(context, listen: false)
                            .parseUrl(link);
                    if (isRightlink) {
                      trackEvent("LinkUpdated");
                      Get.toNamed('/signup');
                    } else {
                      Get.snackbar("Error", ErrorMessage.wrongLinkFormat);
                    }
                  } else if (isPublic == false) {
                    trackEvent("ChatButtonPressed");
                    Get.snackbar("Error", ErrorMessage.sheetsIsNotPublic);
                  } else if (isGoogleSheets == false) {
                    trackEvent("ChatButtonPressed");
                    Get.snackbar("Error", ErrorMessage.notGoogleSheets);
                  }
                },
                controller: urlController,
                buttonWidth: 150,
                textFieldWidth: 300,
                hintText: TextFieldHintText.sheetsLink,
                buttonName: "Chat")
          ],
        ),
      ),
    );
  }
}
