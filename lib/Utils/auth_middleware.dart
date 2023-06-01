import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheetsense/Utils/Functions/common_functions.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isUserLoggedIn = isLoggedIn();
    if (isUserLoggedIn == false) {
      return const RouteSettings(name: '/login');
    } else {
      return null;
    }
  }
}
