import 'dart:io';

import 'package:blood_donor1/screens/dashboard_Materials/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../customs/textformField.dart';

import 'SignIn_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signUpnameController = TextEditingController();
  final signUpemailController = TextEditingController();
  final singUppassController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;
  bool eyetru = true;
  String ErrorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  File? _image;

  final store = FirebaseFirestore.instance;
  final picker = ImagePicker();
  Future getimageGellary() async {
    final PickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('Picture didt get');
      }
    });
  }

  Future getimageCamera() async {
    final PickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('Picture didt get');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    signUpemailController.dispose();
    signUpnameController.dispose();
    singUppassController.dispose();
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
        body: Center(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(_image!.absolute),
                        )
                      : CircleAvatar(
                          radius: 100,
                          child: Icon(
                            Icons.person,
                            size: 100,
                          )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            getimageGellary();
                          },
                          icon: Icon(
                            Icons.image,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            getimageCamera();
                          },
                          icon: Icon(
                            Icons.camera,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  shight(size: size),
                  shight(size: size),
                  SizedBox(
                      width: size.width * 0.9,
                      child: Custextformfield(
                        hint: 'Enter Name',
                        icon: Icons.person_2,
                        controller: signUpnameController,
                      )),
                  shight(size: size),
                  SizedBox(
                      width: size.width * 0.9,
                      child: Custextformfield(
                        controller: signUpemailController,
                        hint: 'Enter Email',
                        icon: Icons.email,
                      )),
                  shight(size: size),
                  SizedBox(
                      width: size.width * 0.9,
                      child: TextFormField(
                        controller: singUppassController,
                        obscureText: eyetru,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                            hintText: 'Enter Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            suffixIcon: IconButton(
                                onPressed: (() {
                                  setState(() {
                                    if (eyetru) {
                                      eyetru = false;
                                    } else {
                                      eyetru = true;
                                    }
                                  });
                                }),
                                icon: Icon(eyetru == true
                                    ? CupertinoIcons.eye_slash
                                    : Icons.remove_red_eye)),
                            suffixStyle: const TextStyle(color: Colors.green)),
                        validator: validatepass,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        ErrorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have account?"),
                      TextButton(
                          onPressed: (() {
                            /////loginpage
                            Get.to(() => SignInPage());
                          }),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        try {
                          await _auth
                              .createUserWithEmailAndPassword(
                                  email: signUpemailController.text,
                                  password: singUppassController.text)
                              .then((value) async {
                            /////send to firestore
                            final ref = storage.ref('/images/' +
                                DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString());
                            final UploadTask = ref.putFile(_image!.absolute);
                            await Future.value(UploadTask);
                            var newurl = await ref.getDownloadURL();
                            Map<String, dynamic> data = {
                              'name': signUpnameController.text,
                              'email': signUpemailController.text,
                              'image': newurl.toString()
                            };

                            firestore
                                .collection('Users')
                                .doc(_auth.currentUser!.uid)
                                .set(data);
                            print('Data sent successfully');
                            Get.back();

                            ///navigator
                            Get.to(() => homeScreen());
                          });
                          ErrorMessage = '';
                        } on FirebaseAuthException catch (error) {
                          ErrorMessage = error.message!;
                        }
                        setState(() {
                          loading = false;
                        });
                      }
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
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class shight extends StatelessWidget {
  const shight({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.02,
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regexp = RegExp(pattern);
  if (!regexp.hasMatch(formEmail)) return 'invalid Email format ';
  return null;
}

String? validatepass(String? formpass) {
  if (formpass == null || formpass.isEmpty) return 'Password is required';
  // String pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  // RegExp regexp = RegExp(pattern);
  // if (!regexp.hasMatch(formpass))
  //   return '''Please must be at least 8 charactors,
  // include an uppercase letter,number and symbol.''';
  return null;
}
