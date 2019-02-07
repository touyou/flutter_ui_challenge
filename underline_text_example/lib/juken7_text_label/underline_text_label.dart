import 'package:flutter/material.dart';

class UnderlineTextLabel extends StatefulWidget {
  UnderlineTextLabel({
    @required this.text,
    @required this.color,
  }) : super();

  final String text;
  final Color color;

  @override
  UnderlineTextLabelState createState() => UnderlineTextLabelState();
}

class UnderlineTextLabelState extends State<UnderlineTextLabel> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint();
  }
}
