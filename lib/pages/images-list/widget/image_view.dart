import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';

Widget imageView(path) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: PColors.pDarkBlue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12)),
      child: Image.asset(
        '$path',
        height: 320.0,
        fit: BoxFit.contain,
      ));
}
