import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:svg_flutter/svg.dart';

Container pilllogo(String imgAdd, String brandname, String hexColor) {
  return Container(
    decoration: BoxDecoration(
      color: HexColor(hexColor), // Background color
      borderRadius: BorderRadius.circular(
          20.0), // Adjust the value for the desired pill shape
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: SvgPicture.asset(
            imgAdd,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          brandname,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white, // Text color
          ),
        ),
      ],
    ),
  );
}
