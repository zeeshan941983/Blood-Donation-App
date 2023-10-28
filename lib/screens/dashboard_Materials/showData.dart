import 'package:blood_donor1/screens/dashboard_Materials/about.dart';
import 'package:blood_donor1/screens/dashboard_Materials/search.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class show extends StatefulWidget {
  const show({Key? key});

  @override
  State<show> createState() => _showState();
}

class _showState extends State<show> {
  final firebas = FirebaseFirestore.instance.collection('Donors').snapshots();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.to(searchfire());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: firebas,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError)
                return Center(
                  child: CircularProgressIndicator(),
                );

              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<DocumentSnapshot> filteredDocuments = documents
                  .where((doc) =>
                      doc['blood Group'] != null && doc['blood Group'] != '')
                  .toList();

              return Expanded(
                child: ListView.builder(
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final document = filteredDocuments[index];
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
                                  name: document['name'],
                                  email: document['email'],
                                  contact: document['phone'],
                                  image: document['image'],
                                  location: document['Location'],
                                ),
                              );
                            },
                            title: Stack(children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      document['image'] != null
                                          ? CircleAvatar(
                                              radius: 60,
                                              backgroundImage: NetworkImage(
                                                document['image'],
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 100,
                                              child: Icon(
                                                Icons.person,
                                                size: 100,
                                              )),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Expanded(
                                        child: Text(
                                          document['name'],
                                          style: TextStyle(
                                              fontSize: 16,
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            document['Location'],
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
                              height: size.height * 0.05,
                              width: size.width * 0.11,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  document['blood Group'],
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
        ],
      ),
    );
  }
}
