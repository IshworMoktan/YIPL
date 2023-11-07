import 'package:yipl/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String text;
  final int index;
  final TabController tabController;

  CustomTab(
      {required this.text, required this.index, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        tabController.animateTo(index);
      },
      child: Container(
        width: 120.0, // Adjust the width as needed
        decoration: BoxDecoration(
          color: tabController.index == index ? mainColor : Colors.grey,
          borderRadius: BorderRadius.circular(20.0), // Pill shape
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
