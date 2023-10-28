import 'package:blood_donor1/screens/dashboard_Materials/homescreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'SIgnUp.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool eyetru = true;

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool loading = false;
  String ErrorMAssage = '';

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void login() async {
    if (_key.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: emailcontroller.text.trim(),
                password: passwordcontroller.text.trim())
            .then((value) {
          ////go to home page navigation
          Get.to(() => homeScreen());
        });
        ErrorMAssage = '';
      } on FirebaseAuthException catch (error) {
        ErrorMAssage = error.message!;
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.red[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: const BoxDecoration(),
              ),
              Form(
                key: _key,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.9,
                        //////Login textField email&password
                        child: TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.red,
                              ),
                              suffixStyle: TextStyle(color: Colors.green)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          },
                        ),
                      ),
                      shight(size: size),
                      SizedBox(
                        width: size.width * 0.9,
                        //////Login textField email&password
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: eyetru,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Enter Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.red,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (eyetru) {
                                      eyetru = false;
                                    } else {
                                      eyetru = true;
                                    }
                                  });
                                },
                                icon: eyetru
                                    ? Icon(CupertinoIcons.eye_slash)
                                    : Icon(CupertinoIcons.eye),
                              ),
                              suffixStyle: TextStyle(color: Colors.green)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                        ErrorMAssage,
                        style: TextStyle(color: Colors.red),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (() {
                                /////forget Password page
                              }),
                              child: Text("Forget password?")),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          login();
                        },
                        child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: loading
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Doesn't have account?"),
                          TextButton(
                              onPressed: () {
                                /////signup page
                                Get.to(() => SignUp());
                              },
                              child: Text("SignUp")),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
