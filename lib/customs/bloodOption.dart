import 'package:flutter/material.dart';

class bloodtypeButton extends StatefulWidget {
  String? isselect;
  final ValueChanged<String?> onBloodGroupSelected;

  bloodtypeButton({
    Key? key,
    required this.isselect,
    required this.onBloodGroupSelected,
  }) : super(key: key);

  @override
  State<bloodtypeButton> createState() => _bloodtypeButtonState();
}

class _bloodtypeButtonState extends State<bloodtypeButton> {
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: DropdownButtonFormField<String>(
        value: widget.isselect,
        items: bloodGroups.map((bloodGroup) {
          return DropdownMenuItem<String>(
            value: bloodGroup,
            child: Text(bloodGroup),
          );
        }).toList(),
        validator: validateBgroup,
        onChanged: (String? value) {
          setState(() {
            widget.isselect = value;
          });
          widget.onBloodGroupSelected(value);
        },
        decoration: const InputDecoration(
          hintText: 'Select Blood',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

String? validateBgroup(String? blood) {
  if (blood == null || blood.isEmpty) return 'Please Enter Blood Group';

  return null;
}
