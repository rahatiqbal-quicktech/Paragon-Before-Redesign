import 'package:flutter/material.dart';

Widget customTextFormField({
  String hintText,
  TextEditingController controller,
  String validatorText,
}) {
  return TextFormField(
    controller: controller,
    // ignore: missing_return
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'The $validatorText field is required';
      }
    },
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black54,
        fontSize: 13,
      ),
    ),
  );
}
