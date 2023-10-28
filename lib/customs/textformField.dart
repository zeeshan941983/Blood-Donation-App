import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custextformfield extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData icon;

  Custextformfield({
    Key? key, // Add the Key parameter here
    this.controller,
    required this.hint,
    required this.icon,
  }) : super(key: key);

  @override
  State<Custextformfield> createState() => _CustextformfieldState();
}

class _CustextformfieldState extends State<Custextformfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.icon,
          color: Colors.red,
        ),
        suffixStyle: TextStyle(color: Colors.green),
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
