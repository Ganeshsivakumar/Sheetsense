import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:mixpanel_flutter/web/mixpanel_js_bindings.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Provider/chat_provider.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';
import 'package:sheetsense/Utils/mixpanel.dart';
import 'package:sheetsense/Widgets/common_widgets.dart';
import 'package:sheetsense/Widgets/chat_widgets.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LoginButton(padding: 20)],
          ),
          const SheetsImage(height: 200, width: 200),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: PageTitlee(fontsize: 20, title: PageTitles.homeTitle),
          ),
          MobileChatForm(
              onPressed: () async {
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
                  Get.snackbar("Error", ErrorMessage.sheetsIsNotPublic);
                  trackEvent("ChatButtonPressed");
                } else if (isGoogleSheets == false) {
                  Get.snackbar("Error", ErrorMessage.notGoogleSheets);
                  trackEvent("ChatButtonPressed");
                }
              },
              controller: urlController,
              buttonWidth: 150,
              textFieldWidth: 300,
              hintText: TextFieldHintText.sheetsLink,
              buttonName: "Chat")
        ],
      )),
    );
  }
}
/*
Provider.of<ChatProvider>(context, listen: false)
                      .parseUrl(link);
                  trackEvent("LinkUpdated");
                  Get.toNamed('/signup');
                  */