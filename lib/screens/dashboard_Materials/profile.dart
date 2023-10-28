import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../customs/textformField.dart';
import '../SignIN&SignUp/SignIn_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: Center(
          child: Column(
        children: [
          currentUserProfilePicUrl.isNotEmpty
              ? CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(currentUserProfilePicUrl),
                )
              : CircleAvatar(
                  radius: 100,
                  child: Icon(
                    Icons.person,
                    size: 100,
                  )),
          shight(
            size: size,
          ),
          Text('HI  ' + name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Divider(),
          Text(
            currt.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Divider(),
          ElevatedButton(
              onPressed: () async {
                await auth.signOut().then((value) {
                  Get.to(SignInPage());
                });
              },
              child: Text('Logout'))
        ],
      )),
    );
  }
}
