import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Authentication/signup_page.dart';
import 'package:sheetsense/Provider/chat_provider.dart';
import 'package:sheetsense/Utils/Functions/db_functions.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';
import 'package:sheetsense/Utils/mixpanel.dart';
import 'package:sheetsense/Widgets/common_widgets.dart';
import 'package:sheetsense/Widgets/chat_widgets.dart';

class MobileChatPage extends StatefulWidget {
  const MobileChatPage({super.key});

  @override
  State<MobileChatPage> createState() => _MobileChatPageState();
}

class _MobileChatPageState extends State<MobileChatPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController questionController = TextEditingController();
    TextEditingController newCsvLink = TextEditingController();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: lightColorScheme.secondaryContainer,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarActions(contactUsButtonOnPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return MobileBottomSheetWidget(
                      height: 200,
                      sheetWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              ConstText.contactInfo,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ));
                });
          }, editLinkButtonOnPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return MobileBottomSheetWidget(
                      sheetWidget: MobileChatForm(
                          onPressed: () async {
                            String url = newCsvLink.text;
                            bool isGoogleSheets = isGoogleSheetsLink(url);
                            bool isPublic = await isGoogleSheetsLinkPublic(url);
                            if (isGoogleSheets & isPublic) {
                              String parsedUrl = parseUri(url);
                              bool isUpdated =
                                  await updateNewCsvLink(parsedUrl);
                              if (isUpdated) {
                                trackEvent("NewLinkUpdated");

                                Navigator.pop(context);
                                Get.snackbar("Sucess", "New link Updated");
                                newCsvLink.clear();
                              }
                            } else if (isPublic == false) {
                              Get.snackbar(
                                  "Error", ErrorMessage.sheetsIsNotPublic);
                            } else if (isGoogleSheets == false) {
                              Get.snackbar(
                                  "Error", ErrorMessage.notGoogleSheets);
                            }
                          },
                          controller: newCsvLink,
                          buttonWidth: 80,
                          textFieldWidth: 300,
                          hintText: TextFieldHintText.updateLink,
                          buttonName: "Update"),
                      height: 500);
                });
          }),
          PageTitlee(fontsize: 23, title: PageTitles.chatTitle),
          Padding(
            padding: const EdgeInsets.all(30),
            //width: 350,
            child: StreamBuilder(
                stream: chatProvider.chatStream.stream,
                initialData: ChatProviderText.initialData,
                builder: (context, snapshot) {
                  if (snapshot.data.toString() ==
                      ChatProviderText.premiumPlan) {
                    return UpgradeToPremiumWidget(
                        snapshot: snapshot.data.toString());
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: const TextStyle(fontSize: 17),
                    );
                  } else {
                    return const Text(
                      "Loadding...",
                      style: TextStyle(fontSize: 17),
                    );
                  }
                }),
          ),
          MobileChatForm(
              onPressed: () async {
                final String question = questionController.text;
                if (auth.currentUser!.uid.isEmpty) {
                  Get.toNamed('/login');
                } else if (question.isEmpty) {
                  Get.snackbar(ErrorMessage.error, ErrorMessage.questionEmpty);
                } else {
                  int count = await getChatCount();
                  bool isPremium = await checkIsPremium();
                  if (count < 10) {
                    chatProvider.asksheetsense(question);

                    trackChatEvent("QuestionAsked", "false");

                    questionController.clear();
                  } else if (count == 10 && isPremium == false) {
                    chatProvider.upgradeToPremium();
                  } else if (isPremium) {
                    chatProvider.asksheetsense(question);

                    trackChatEvent("QuestionAsked", "true");

                    questionController.clear();
                  }
                }
              },
              controller: questionController,
              buttonWidth: 80,
              textFieldWidth: 300,
              hintText: TextFieldHintText.askQuestion,
              buttonName: "Ask")
        ],
      )),
    );
  }
}
