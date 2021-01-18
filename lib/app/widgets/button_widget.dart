import 'package:flutter/material.dart';

Widget customButton(Function ontap, String text, Color color, Size size) {
  return Container(
    width: size.width / 4,
    height: size.width / 4,
    child: MaterialButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      ),
      onPressed: ontap,
      child: Text(
        "$text",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
