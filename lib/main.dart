import 'package:flutter/material.dart';
import 'package:sheetsense/Authentication/login_page.dart';
import 'package:sheetsense/Authentication/signup_page.dart';
import 'package:sheetsense/Pages/ChatPages/chat.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sheetsense/Pages/HomePages/home.dart';
import 'package:sheetsense/Provider/auth_provider.dart';
import 'package:sheetsense/Provider/chat_provider.dart';
import 'package:sheetsense/Utils/Constants/colors.dart';
import 'package:sheetsense/Utils/auth_middleware.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBWI2Jy8O5pQqBMalcVO6OPFt5JHEQpCm4",
    appId: "1:579078714050:web:7dd56f4b9267dd164e815b",
    messagingSenderId: "579078714050",
    projectId: "sheetsense-995c1",
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider())
      ],
      child: GetMaterialApp(
        getPages: [
          GetPage(name: '/login', page: (() => const LoginPage())),
          GetPage(name: '/signup', page: (() => const SignUpPage())),
          GetPage(
              name: '/chat',
              page: (() => const ChatPage()),
              middlewares: [AuthMiddleware()]),
        ],
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        title: "sheetsense",
        home: const LandingPage(),
      ),
    );
  }
}
