import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: PColors.pDarkBlue,
          ),
        ),
      ),
    );
  }
}
