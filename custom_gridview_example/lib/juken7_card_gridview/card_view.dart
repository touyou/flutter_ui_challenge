import 'package:flutter/material.dart';
import '../juken7_pie_chart/juken7_pie_chart.dart';
import '../juken7_text_label/juken7_text_label.dart';

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
    @required this.size,
  }) : super();

  final CardData cardData;
  final Color lineColor;
  final TextStyle textStyle;
  final Size size;

  @override
  CardViewState createState() => CardViewState();
}

class CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(15, 0, 0, 0),
              blurRadius: 4.0,
              spreadRadius: 2.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          AnimatedPieChart(
            // Sizeを決める
            size: Size(widget.size.width - 32.0, widget.size.width - 32.0),
            initialPieData: widget.cardData.initialPieData,
            centerText: "習得率\n${widget.cardData.score}%",
            centerImage: widget.cardData.image,
            centerImageTag: widget.cardData.imageTag,
          ),
          UnderlineTextLabel(
            texts: [widget.cardData.cardTitle],
            color: widget.lineColor,
            textStyle: widget.textStyle,
            size: Size(
                widget.size.width - 32.0, (widget.size.width - 32.0) * 3 / 7),
          )
        ],
      ),
    );
  }
}
