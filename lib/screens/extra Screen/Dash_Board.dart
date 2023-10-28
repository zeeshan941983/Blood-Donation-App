// import 'package:blood_donor1/screens/SignIN&SignUp/SIgnUp.dart';
// import 'package:blood_donor1/screens/dashboard_Materials/AddDonorData.dart';
// import 'package:blood_donor1/screens/dashboard_Materials/search.dart';

// import 'package:blood_donor1/screens/dashboard_Materials/profile.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// import '../../backend/firebase/add_data.dart';
// import 'showData.dart';

// class dashboard extends StatefulWidget {
//   @override
//   _dashboardState createState() => _dashboardState();
// }

// class _dashboardState extends State<dashboard> {
//   TextEditingController search = TextEditingController();
//   bool isselected = true;
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     show(),
//     ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 10.0),
//               child: IconButton(
//                   onPressed: () {
//                     Get.to(searchfire());
//                   },
//                   icon: Icon(Icons.search_rounded)),
//             )
//           ],
//           title: Text('home screen'),
//         ),
//         body: _pages[_currentIndex],
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.red,
//           elevation: 20.0,
//           onPressed: () {
//             Get.to(AddDonorData());
//           },
//           child: const Icon(
//             Icons.bloodtype,
//             color: Colors.white,
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           height: size.height * 0.08,
//           shape: CircularNotchedRectangle(),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.home,
//                   color: _currentIndex == 0 ? Colors.red : Colors.grey,
//                 ),
//                 onPressed: () {
//                   show();
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                 },
//               ),
//               SizedBox(
//                 width: size.width * 0.3,
//               ), // Adjust the spacing between the buttons
//               IconButton(
//                 icon: Icon(
//                   Icons.person_2,
//                   color: _currentIndex == 1 ? Colors.red : Colors.grey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
