import 'package:flutter/material.dart';

Widget inputTextWidget(
    {TextEditingController productName,
    String labelText,
    String hintText,
    int maxLength,
    int maxLines,
    Function(String) validator,
    TextInputType keyboardType}) {
  return TextFormField(
    controller: productName,
    keyboardType: keyboardType,
    validator: validator,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    maxLength: maxLength,
    maxLines: maxLines,
  );
}
