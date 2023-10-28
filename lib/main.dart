import 'package:blood_donor1/screens/dashboard_Materials/AddDonorData.dart';
import 'package:blood_donor1/screens/dashboard_Materials/homescreen.dart';
import 'package:blood_donor1/screens/dashboard_Materials/showData.dart';
import 'package:blood_donor1/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blood Donor',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Splash_screen());
  }
}
