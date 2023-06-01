import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Provider/auth_provider.dart';
import 'package:sheetsense/Utils/Functions/auth_functions.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Utils/mixpanel.dart';
import 'package:sheetsense/Widgets/auth_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: AuthWidget(
        titletext: PageTitles.loginTitle,
        buttonText: "Log In",
        onPressed: () async {
          String email = authProvider.email;
          String password = authProvider.password;
          if (email.isEmail) {
            if (password.length >= 6) {
              bool isLoggedIn = await loginUser(email, password);
              if (isLoggedIn) {
                trackEvent("LoggedIn");
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
      )),
    );
  }
}
