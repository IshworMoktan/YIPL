import 'package:flutter/material.dart';

class LongText extends StatefulWidget {
  final String longText;
  final int characterLimit;

  LongText({required this.longText, this.characterLimit = 111});

  @override
  _LongTextState createState() => _LongTextState();
}

class _LongTextState extends State<LongText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpanded
              ? widget.longText
              : widget.longText.substring(0, widget.characterLimit),
          textAlign: TextAlign.justify,
        ),
        if (widget.longText.length > widget.characterLimit)
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(isExpanded ? "Less" : "More"),
          ),
      ],
    );
  }
}
