// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:uuid/uuid.dart';

// class currentLcoantion extends StatefulWidget {
//   const currentLcoantion({super.key});

//   @override
//   State<currentLcoantion> createState() => _currentLcoantionState();
// }

// class _currentLcoantionState extends State<currentLcoantion> {
//   TextEditingController location = TextEditingController();
//   String selected = '';
//   var uuid = Uuid();
//   String _sessionToken = '12345';
//   List<dynamic> _placesList = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     location.addListener(() {
//       onchange();
//     });
//   }

//   void onchange() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggesion(location.text);
//   }

//   void getSuggesion(String input) async {
//     String kPLACES_API_KEY = "AIzaSyANdwN9vrHH409NPc77UPG7xIz20bXHsiQ";
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
//     var response = await http.get(Uri.parse(request));
//     print(response.body.toString());
//     if (response.statusCode == 200) {
//       setState(() {
//         _placesList = jsonDecode(response.body.toString())['predictions'];
//       });
//     } else {
//       throw Exception('faild');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Current location"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: location,
//               decoration: InputDecoration(hintText: 'Search place'),
//               onChanged: (value) {
//                 setState(() {
//                   selected = location.text;
//                 });
//               },
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _placesList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     onTap: () {
//                       setState(() {
//                         selected = _placesList[index]['description'];
//                         if (selected == _placesList[index]['description']) {
//                           _placesList.clear();
//                           location.text = selected;
//                         }
//                       });
//                     },
//                     title: Text(_placesList[index]['description']),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









// /////////////backup

// // class currentLcoantion extends StatefulWidget {
// //   const currentLcoantion({super.key});

// //   @override
// //   State<currentLcoantion> createState() => _currentLcoantionState();
// // }

// // class _currentLcoantionState extends State<currentLcoantion> {
// //   TextEditingController location = TextEditingController();
// //   String selected = '';
// //   var uuid = Uuid();
// //   String _sessionToken = '12345';
// //   List<dynamic> _placesList = [];
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     location.addListener(() {
// //       onchange();
// //     });
// //   }

// //   void onchange() {
// //     if (_sessionToken == null) {
// //       setState(() {
// //         _sessionToken = uuid.v4();
// //       });
// //     }
// //     getSuggesion(location.text);
// //   }

// //   void getSuggesion(String input) async {
// //     String kPLACES_API_KEY = "AIzaSyANdwN9vrHH409NPc77UPG7xIz20bXHsiQ";
// //     String baseURL =
// //         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
// //     String request =
// //         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
// //     var response = await http.get(Uri.parse(request));
// //     print(response.body.toString());
// //     if (response.statusCode == 200) {
// //       setState(() {
// //         _placesList = jsonDecode(response.body.toString())['predictions'];
// //       });
// //     } else {
// //       throw Exception('faild');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Current location"),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(20),
// //         child: Column(
// //           children: [
// //             TextFormField(
// //               controller: location,
// //               decoration: InputDecoration(hintText: 'Search place'),
// //               onChanged: (value) {
// //                 setState(() {
// //                   selected = location.text;
// //                 });
// //               },
// //             ),
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: _placesList.length,
// //                 itemBuilder: (BuildContext context, int index) {
// //                   return ListTile(
// //                     onTap: () {
// //                       setState(() {
// //                         selected = _placesList[index]['description'];
// //                         if (selected == _placesList[index]['description']) {
// //                           _placesList.clear();
// //                           location.text = selected;
// //                         }
// //                       });
// //                     },
// //                     title: Text(_placesList[index]['description']),
// //                   );
// //                 },
// //               ),
// //             ),
            
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
