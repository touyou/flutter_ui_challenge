import 'package:flutter/material.dart';

class UnderlineTextPainter extends CustomPainter {
  UnderlineTextPainter(
      this.texts, this.textStyle, this.color, this.lineGap, this.context)
      : super();

  final List<String> texts;
  final TextStyle textStyle;
  final Color color;
  final BuildContext context;
  final double lineGap;

  @override
  void paint(Canvas canvas, Size size) {
    var originList = _textPaint(canvas, size, this.texts, this.textStyle);

    final Paint underlinePaint = new Paint()
      ..style = PaintingStyle.fill
      ..color = this.color;
    var underlineHeight = originList[0].height / 2;

    for (final origin in originList) {
      canvas.drawRect(
          Rect.fromLTRB(0, origin.height - underlineHeight, origin.width + 5,
              origin.height),
          underlinePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  List<TextSize> _textPaint(
      Canvas canvas, Size size, List<String> _texts, TextStyle _textStyle) {
    var lines = _texts.length;
    var _initialLinePainter = TextPainter();
    _initialLinePainter
      ..text = TextSpan(style: _textStyle, text: _texts[0])
      ..textDirection = Directionality.of(context)
      ..textScaleFactor = MediaQuery.of(context).textScaleFactor
      ..layout();
    var lineHeight = _initialLinePainter.height;

    _initialLinePainter.paint(canvas, Offset(0, 0));

    if (lines == 1) {
      return [TextSize(_initialLinePainter.width, lineHeight)];
    }
    _texts.removeAt(0);
    var originList = [TextSize(_initialLinePainter.width, lineHeight)];

    for (final text in _texts) {
      var _labelPainter = TextPainter();
      _labelPainter
        ..text = TextSpan(style: _textStyle, text: text)
        ..textDirection = Directionality.of(context)
        ..textScaleFactor = MediaQuery.of(context).textScaleFactor
        ..layout();

      _labelPainter.paint(canvas, Offset(0, lineHeight + lineGap));
      lineHeight += lineGap + _labelPainter.height;
      originList.add(TextSize(_labelPainter.width, lineHeight));
    }

    return originList;
  }
}

class TextSize {
  TextSize(this.width, this.height);

  final double width;
  final double height;
}
