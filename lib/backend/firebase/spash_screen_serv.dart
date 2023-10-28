// import 'dart:async';
import 'dart:async';

import 'package:blood_donor1/screens/SignIN&SignUp/SignIn_page.dart';
import 'package:blood_donor1/screens/dashboard_Materials/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

class Splash_services {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () => Get.to(() => homeScreen()));
    } else {
      Timer(const Duration(seconds: 3), () => Get.to(() => SignInPage()));
    }
  }
}
