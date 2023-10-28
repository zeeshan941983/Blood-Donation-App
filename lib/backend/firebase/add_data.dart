// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../customs/textformField.dart';
// import '../../../customs/bloodOption.dart';

// void add_data(BuildContext context) {
//   var size = MediaQuery.of(context).size;
//   final Firebase = FirebaseFirestore.instance;
//   final currentUser = FirebaseAuth.instance.currentUser;

//   String? selectedBloodGroup;
//   String name = '';
//   String location = '';
//   String phonenumber = '';
//   bool isLoading = false;
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         return SingleChildScrollView(
//           child: AlertDialog(
//             title: const Text('Submit Information'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 shight(size: size),
//                 TextField(
//                   decoration: const InputDecoration(
//                     labelText: 'Enter location',
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                   onChanged: (value) {
//                     location = value;
//                   },
//                 ),
//                 shight(size: size),
//                 TextField(
//                   decoration: const InputDecoration(
//                     labelText: 'Enter phone',
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                   onChanged: (value) {
//                     phonenumber = value;
//                   },
//                 ),
//                 shight(size: size),
//                 bloodtypeButton(
//                   isselect: selectedBloodGroup,
//                   onBloodGroupSelected: (value) {
//                     setState(() {
//                       selectedBloodGroup = value;
//                     });
//                   },
//                 ),
//                 shight(size: size),
//                 InkWell(
//                   onTap: isLoading
//                       ? null
//                       : () async {
//                           setState(() {
//                             isLoading = true;
//                           });
//                           print('error');
//                           try {
//                             if (currentUser != null) {
//                               // Retrieve the current user's email
//                               String userEmail = currentUser.email ?? '';

//                               // Get the user document from the 'Users' collection
//                               DocumentSnapshot userSnapshot =
//                                   await Firebase.collection('Users')
//                                       .doc(currentUser.uid)
//                                       .get();
//                               print(userSnapshot);
//                               String image = userSnapshot.get('image');

//                               // Retrieve the current user's name
//                               String userName = userSnapshot.get('name') ?? '';

//                               Map<String, dynamic> data = {
//                                 'email': userEmail,
//                                 'name': userName,
//                                 'phone': phonenumber,
//                                 'blood Group': selectedBloodGroup,
//                                 'Location': location,
//                                 'image': image,
//                               };

//                               // Save the data in the 'Donors' collection
//                               await Firebase.collection('Donors')
//                                   .doc(DateTime.now().toString())
//                                   .set(data);

//                               print('Data sent successfully');
//                               Get.back();
//                             }
//                           } catch (e) {
//                             print('Error sending data: $e');
//                           } finally {
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         },
//                   child: Container(
//                     height: size.height * 0.06,
//                     width: size.width * 0.9,
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Center(
//                       child: isLoading
//                           ? CircularProgressIndicator()
//                           : const Text(
//                               "Submit",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
