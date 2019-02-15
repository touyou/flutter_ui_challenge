import 'package:flutter/material.dart';
import 'painter.dart';

class UnderlineTextLabel extends StatefulWidget {
  UnderlineTextLabel({
    @required this.texts,
    @required this.color,
    @required this.textStyle,
    @required this.size,
    this.lineGap = 5.0,
  }) : super();

  final List<String> texts;
  final Color color;
  final TextStyle textStyle;
  final Size size;
  final double lineGap;

  @override
  UnderlineTextLabelState createState() => UnderlineTextLabelState();
}

class UnderlineTextLabelState extends State<UnderlineTextLabel> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: UnderlineTextPainter(
        widget.texts,
        widget.textStyle,
        widget.color,
        widget.lineGap,
        context,
      ),
    );
  }
}
