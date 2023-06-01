import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Provider/chat_provider.dart';
import 'package:sheetsense/Utils/Functions/db_functions.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';
import 'package:sheetsense/Utils/mixpanel.dart';
import 'package:sheetsense/Widgets/common_widgets.dart';
import 'package:sheetsense/Widgets/chat_widgets.dart';

class WebChatPage extends StatefulWidget {
  const WebChatPage({super.key});

  @override
  State<WebChatPage> createState() => _WebChatPageState();
}

class _WebChatPageState extends State<WebChatPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController questionController = TextEditingController();
    TextEditingController newCsvLink = TextEditingController();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: lightColorScheme.secondaryContainer,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavBarActions(contactUsButtonOnPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DialogBoxx(
                        boxheight: 150,
                        boxwidth: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Closebutton(
                              padding: 200,
                            ),
                            Text(
                              ConstText.contactInfo,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ));
                  });
            }, editLinkButtonOnPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return WebDialogBox(
                        onPressed: () async {
                          String url = newCsvLink.text;
                          bool isGoogleSheets = isGoogleSheetsLink(url);
                          bool isPublic = await isGoogleSheetsLinkPublic(url);
                          if (isGoogleSheets & isPublic) {
                            String parsedUrl = parseUri(url);
                            bool isUpdated = await updateNewCsvLink(parsedUrl);
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
                            Get.snackbar("Error", ErrorMessage.notGoogleSheets);
                          }
                        },
                        link: newCsvLink);
                  });
            }),
            Center(
                child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(28),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    width: 650,
                    height: 450,
                    color: AppColors.primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PageTitlee(fontsize: 25, title: PageTitles.chatTitle),
                        Consumer<ChatProvider>(
                          builder: (context, chatProvider, child) {
                            return SizedBox(
                              width: 400,
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
                            );
                          },
                        ),
                        WebChatForm(
                            onPressed: () async {
                              final String question = questionController.text;
                              if (question.isEmpty) {
                                Get.snackbar(ErrorMessage.error,
                                    ErrorMessage.questionEmpty);
                              } else {
                                int count = await getChatCount();
                                bool isPremium = await checkIsPremium();
                                if (count < 10) {
                                  chatProvider.asksheetsense(question);

                                  trackChatEvent("QuestionAsked", "false");

                                  questionController.clear();
                                  //mixpanel.track("QuestionAsked");
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
                    ),
                  )),
            )),
          ],
        ));
  }
}
