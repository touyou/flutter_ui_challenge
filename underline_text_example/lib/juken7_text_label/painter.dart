import 'package:flutter/material.dart';

class UnderlineTextPainter extends CustomPainter {
  UnderlineTextPainter(this.texts, this.textStyle, this.color) : super();

  final List<String> texts;
  final TextStyle textStyle;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var originList = _textPaint(canvas, size, this.texts, this.textStyle);

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

  List<double> _textPaint(
      Canvas canvas, Size size, List<String> _texts, TextStyle _textStyle) {
    var lines = _texts.length;
    var _initialLinePainter = TextPainter();
    _initialLinePainter
      ..text = TextSpan(style: _textStyle, text: _texts[0])
      ..layout();
    var lineHeight = _initialLinePainter.height;

    _initialLinePainter.paint(canvas, Offset(0, 0));

    if (lines == 1) {
      return [lineHeight];
    }
    _texts.removeAt(0);
    var originList = [lineHeight];

    for (final text in _texts) {
      var _labelPainter = TextPainter();
      _labelPainter
        ..text = TextSpan(style: _textStyle, text: text)
        ..layout();

      _labelPainter.paint(canvas, Offset(0, lineHeight + 5));
      lineHeight += 5 + _labelPainter.height;
      originList.add(lineHeight);
    }

    return originList;
  }
}
