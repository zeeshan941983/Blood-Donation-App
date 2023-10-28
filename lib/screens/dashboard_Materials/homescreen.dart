import 'package:blood_donor1/screens/SignIN&SignUp/SIgnUp.dart';
import 'package:blood_donor1/screens/dashboard_Materials/AddDonorData.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'showData.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String currentUserProfilePicUrl = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    getCurrentUserProfilePicUrl();
  }

  Future<void> getCurrentUserProfilePicUrl() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();

    final profilePicUrl = userDoc.data()!['image'];
    final fname = userDoc.data()!['name'];
    setState(() {
      currentUserProfilePicUrl = profilePicUrl;
      name = fname;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    var size = MediaQuery.of(context).size;
    final currt = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[100],
          title: Center(child: Text("Home Screen")),
        ),
        drawer: Drawer(
          backgroundColor: Colors.teal[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height * 0.3,
                    color: Colors.red[100],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: currentUserProfilePicUrl.isNotEmpty
                        ? CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                NetworkImage(currentUserProfilePicUrl),
                          )
                        : CircleAvatar(
                            radius: 100,
                            child: Icon(
                              Icons.person,
                              size: 100,
                            )),
                  ),
                ],
              ),
              Column(
                children: [
                  Text('HI  ' + name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Divider(),
                  Text(
                    currt.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                    Get.to(SignUp());
                  },
                  child: Text("Logout"))
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red.shade100, Colors.green],
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Get.to(show());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(500)),
                        height: size.height * 0.17,
                        width: size.width * 0.4,
                        child: Center(
                            child: Text(
                          "Recipent",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  shight(size: size),
                  InkWell(
                    onTap: () {
                      Get.to(AddDonorData());
                    },
                    child: Container(
                      height: size.height * 0.17,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(500)),
                      child: const Center(
                          child: Text(
                        "Donate\nBlood",
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
