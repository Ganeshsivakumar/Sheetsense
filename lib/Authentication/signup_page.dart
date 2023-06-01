import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Provider/auth_provider.dart';
import 'package:sheetsense/Provider/chat_provider.dart';
import 'package:sheetsense/Utils/Functions/auth_functions.dart';
import 'package:sheetsense/Utils/Functions/db_functions.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/mixpanel.dart';
import 'package:sheetsense/Widgets/auth_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final auth = FirebaseAuth.instance;

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AuthWidget(
          titletext: PageTitles.signUpTitle,
          buttonText: "Sign Up",
          onPressed: () async {
            String email = authProvider.email;
            String password = authProvider.password;
            String csvUrl = chatProvider.csvurl;
            if (email.isEmail) {
              if (password.length >= 6) {
                bool isSignedIn = await createUser(email, password);
                if (isSignedIn) {
                  trackEvent("SignedIn");
                  updatUserInFirestore(email, csvUrl);
                  Get.toNamed('/chat');
                } else {
                  Get.snackbar("Error", ErrorMessage.exception);
                }
              } else {
                Get.snackbar("Error", ErrorMessage.invalidPassword);
              }
            } else {
              Get.snackbar("Error", ErrorMessage.invalidEmail);
            }
          },
        ),
      ),
    );
  }
}
