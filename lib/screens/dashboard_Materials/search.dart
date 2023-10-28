import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../customs/textformField.dart';
import 'about.dart';

class searchfire extends StatefulWidget {
  const searchfire({super.key});

  @override
  State<searchfire> createState() => _searchfireState();
}

class _searchfireState extends State<searchfire> {
  TextEditingController seachtf = TextEditingController();
  final database = FirebaseDatabase.instance.ref('Donors');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Donors')
        .where(
          'blood Group',
          isEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: size.height * 0.056,
          padding: EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            controller: seachtf,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              hintText: 'Search Blood',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: size.height * 0.30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.to(
                            about(
                              name: snapshot.data!.docs[index]['name'],
                              email: snapshot.data!.docs[index]['email'],
                              contact: snapshot.data!.docs[index]['phone'],
                              image: snapshot.data!.docs[index]['image'],
                              location: snapshot.data!.docs[index]['Location'],
                            ),
                          );
                        },
                        title: Stack(children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  snapshot.data!.docs[index]['image'] != null
                                      ? CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                            snapshot.data!.docs[index]['image'],
                                          ),
                                        )
                                      : Icon(Icons.person),
                                  SizedBox(
                                    width: size.width * 0.1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.docs[index]['name'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.003,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]['Location'],
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                        // subtitle:
                        trailing: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data!.docs[index]['blood Group'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Text(
                      //   'Contact: ${document['phone']}',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // shight(size: size),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     final phoneNumber = document['phone'] as String?;

                      //     final url = 'tel://$phoneNumber';

                      //     // ignore: deprecated_member_use
                      //     launch(url);
                      //   },
                      //   child: Text('Call'),
                      // ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
