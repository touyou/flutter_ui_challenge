import 'package:flutter/material.dart';
import '../juken7_pie_chart/juken7_pie_chart.dart';
import '../juken7_text_label/juken7_text_label.dart';

import 'dart:math';

class CardData {
  CardData({
    @required this.cardTitle,
    @required this.score,
    @required this.image,
    @required this.imageTag,
    @required this.initialPieData,
  }) : super();

  final double score;
  final Widget image;
  final String imageTag;
  final List<PieStackEntry> initialPieData;
  final String cardTitle;
}

class CardView extends StatefulWidget {
  CardView({
    @required this.cardData,
    @required this.lineColor,
    @required this.textStyle,
    // @required this.size,
    @required this.onTap,
  }) : super();

  final CardData cardData;
  final Color lineColor;
  final TextStyle textStyle;
  final Function onTap;
  // final Size size;

  @override
  CardViewState createState() => CardViewState();
}

class CardViewState extends State<CardView> {
  bool _tapInProgress;

  CardViewState() {
    _tapInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    double cardWidth;
    if (orientation == Orientation.portrait) {
      cardWidth = (MediaQuery.of(context).size.width - 24.0 * 3) / 2;
    } else {
      cardWidth = (MediaQuery.of(context).size.height - 24.0 * 4) / 3;
    }

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _tapInProgress ? Colors.white12 : Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(10, 0, 0, 0),
              blurRadius: 5.0,
              spreadRadius: 2.0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedPieChart(
            // Sizeを決める
            size: (orientation == Orientation.portrait
                ? Size(cardWidth - 32.0, cardWidth - 32.0)
                : Size(cardWidth + 32.0, cardWidth + 32.0)),
            initialPieData: widget.cardData.initialPieData,
            centerText: "習得率\n${widget.cardData.score}%",
            centerImage: widget.cardData.image,
            centerImageTag: widget.cardData.imageTag,
            centerTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (orientation == Orientation.portrait
                    ? cardWidth * 0.1
                    : cardWidth * 0.2)),
          ),
          Text(widget.cardData.cardTitle),
          Spacer(),
          GestureDetector(
            onTapDown: _tapDown,
            onTapUp: _tapUp,
            onTapCancel: _tapCancel,
            onTap: widget.onTap,
            child: UnderlineTextLabel(
              texts: ['スタート'],
              color: _tapInProgress
                  ? complement(widget.lineColor)
                  : widget.lineColor,
              textStyle: widget.textStyle,
              size: (orientation == Orientation.portrait
                  ? Size(cardWidth - 88.0, (cardWidth - 32.0) * 0.3)
                  : Size(cardWidth - 24.0, (cardWidth - 32.0) * 0.6)),
            ),
          )
        ],
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    setState(() {
      _tapInProgress = true;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      _tapInProgress = false;
    });
  }

  void _tapCancel() {
    setState(() {
      _tapInProgress = false;
    });
  }

  Color complement(Color baseColor) {
    final int opacity = baseColor.value >> 24 & 0xff;
    final int r = baseColor.value >> 16 & 0xff;
    final int g = baseColor.value >> 8 & 0xff;
    final int b = baseColor.value & 0xff;
    final int sum = [r, g, b].reduce(max) + [r, g, b].reduce(min);
    return Color(
        (opacity << 24) | ((sum - r) << 16) | ((sum - g) << 8) | (sum - b));
  }
}
