import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../customs/textformField.dart';

class about extends StatefulWidget {
  String name;
  String email;
  String contact;
  String image;
  String location;

  about(
      {super.key,
      required this.name,
      required this.location,
      required this.contact,
      required this.email,
      required this.image});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name + ' Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: unnecessary_null_comparison
            widget.image != null
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      widget.image,
                    ),
                  )
                : Icon(Icons.abc),
            Text(
              'Name: ' + widget.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Email:  ' + widget.email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Contact: ${widget.contact}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 40, right: 20),
              width: double.infinity,
              child: Center(
                child: Text(
                  'Location: ' + widget.location,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            shight(size: size),
            ElevatedButton(
              onPressed: () async {
                final phoneNumber = widget.contact as String?;

                final url = 'tel://$phoneNumber';

                // ignore: deprecated_member_use
                launch(url);
              },
              child: Text('Call Now'),
            ),
          ],
        ),
      ),
    );
  }
}
