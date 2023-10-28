import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uuid/uuid.dart';
import '../../customs/bloodOption.dart';
import '../../customs/textformField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDonorData extends StatefulWidget {
  const AddDonorData({super.key});

  @override
  State<AddDonorData> createState() => _AddDonorDataState();
}

class _AddDonorDataState extends State<AddDonorData> {
  TextEditingController location = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String selected = '';
  var uuid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.addListener(() {
      onchange();
    });
  }

  void onchange() {
    // ignore: unnecessary_null_comparison
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggesion(location.text);
  }

  void getSuggesion(String input) async {
    String kPLACES_API_KEY = "AIzaSyANdwN9vrHH409NPc77UPG7xIz20bXHsiQ";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('faild');
    }
  }

  final Firebase = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  String? selectedBloodGroup;
  String name = '';

  String phonenumber = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your information'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10),
        child: Form(
          key: _key,
          child: Column(
            children: [
              shight(size: size),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              if (currentUser != null) {
                                // Retrieve the current user's email
                                String userEmail = currentUser!.email ?? '';

                                // Get the user document from the 'Users' collection
                                DocumentSnapshot userSnapshot =
                                    await Firebase.collection('Users')
                                        .doc(currentUser!.uid)
                                        .get();
                                print(userSnapshot);
                                String image = userSnapshot.get('image');

                                // Retrieve the current user's name
                                String userName =
                                    userSnapshot.get('name') ?? '';

                                Map<String, dynamic> data = {
                                  'email': userEmail,
                                  'name': userName,
                                  'phone': phonenumber,
                                  'blood Group': selectedBloodGroup,
                                  'Location': selected,
                                  'image': image,
                                };

                                // Save the data in the 'Donors' collection
                                await Firebase.collection('Donors')
                                    .doc(DateTime.now().toString())
                                    .set(data);

                                Get.back();
                              }
                            } catch (e) {
                              SnackBar(
                                content: Text(e.toString()),
                              );
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              shight(size: size),
              SizedBox(
                width: size.width * 0.9,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter phone',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  onChanged: (value) {
                    phonenumber = value;
                  },
                  validator: validatephone,
                ),
              ),
              shight(size: size),
              bloodtypeButton(
                isselect: selectedBloodGroup,
                onBloodGroupSelected: (value) {
                  setState(() {
                    selectedBloodGroup = value;
                  });
                },
              ),
              shight(size: size),

              ////saerch loaction code
              SizedBox(
                width: size.width * 0.9,
                child: TextFormField(
                    controller: location,
                    decoration: InputDecoration(
                        hintText: 'Search place',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    onFieldSubmitted: (value) {
                      setState(() {
                        selected = location.text;
                      });
                    },
                    validator: validateLocation),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          selected = _placesList[index]['description'];
                          if (selected == _placesList[index]['description']) {
                            location.text = selected;
                            _placesList.clear();
                          }
                        });
                      },
                      title: Text(_placesList[index]['description']),
                    );
                  },
                ),
              ),

              ///search location;
            ],
          ),
        ),
      )),
    );
  }
}

String? validatephone(String? phone) {
  if (phone == null || phone.isEmpty) return 'Please Enter Phone number';

  return null;
}

String? validateLocation(String? location) {
  if (location == null || location.isEmpty) return 'Please Enter Location';

  return null;
}
