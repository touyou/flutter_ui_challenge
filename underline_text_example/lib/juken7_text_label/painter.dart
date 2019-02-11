import 'package:flutter/material.dart';

class UnderlineTextPainter extends CustomPainter {
  UnderlineTextPainter(this.texts, this.color) : super();

  final List<String> texts;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var originList = _textPaint(canvas, size, this.texts);

    // labelPainter.paint(canvas, Offset(0, 0));

    // var lineNumber = labelPainter.maxLines;

    // final Paint underlinePaint = new Paint()
    //   ..style = PaintingStyle.fill
    //   ..color = this.color;
    // canvas.drawRect(
    //     Rect.fromLTRB(0, labelPainter.height - 5.0, labelPainter.width,
    //         labelPainter.height),
    //     underlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  List<int> _textPaint(Canvas canvas, Size size, List<String> _texts) {
    var lines = _texts.length;

    return [];
  }
}
