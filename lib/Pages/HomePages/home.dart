import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sheetsense/Pages/HomePages/mobile_homepage.dart';
import 'package:sheetsense/Pages/HomePages/web_homepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) {
        return const WebHomePage();
      },
      mobile: (context) {
        return const MobileHomePage();
      },
    );
  }
}

/*
Scaffold(
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
            const HomeTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChatTextField(
                    textFieldWidth: 300,
                    controller: urlController,
                    hintText: TextFieldHintText.sheetsLink),
                const SizedBox(
                  width: 13,
                ),
                FabButton(
                    onPressed: () async {
                      String link = urlController.text;
                      bool isGoogleSheets = isGoogleSheetsLink(link);
                      bool isPublic = await isGoogleSheetsLinkPublic(link);
                      if (isGoogleSheets & isPublic) {
                        Provider.of<ChatProvider>(context, listen: false)
                            .parseUrl(link);
                        Get.toNamed('/signup');
                      } else if (isPublic == false) {
                        Get.snackbar("Error", ErrorMessage.sheetsIsNotPublic);
                      } else if (isGoogleSheets == false) {
                        Get.snackbar("Error", ErrorMessage.notGoogleSheets);
                      }
                    },
                    buttonName: "Chat",
                    buttonWidth: 150)
              ],
            ),
          ],
        ),
      ),
    );
    */