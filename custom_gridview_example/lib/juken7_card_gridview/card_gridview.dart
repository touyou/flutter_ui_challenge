import 'package:flutter/material.dart';
import 'card_view.dart';

class CardGridView extends StatefulWidget {
  CardGridView({
    @required this.titleWidget,
    @required this.childDataList,
    @required this.lineColorList,
  }) : super();

  final Widget titleWidget;
  final List<CardData> childDataList;
  final List<Color> lineColorList;

  @override
  CardGridViewState createState() => CardGridViewState();
}

class CardGridViewState extends State<CardGridView> {
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
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([widget.titleWidget]),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(32.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait ? 2 : 3),
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 24.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildListDelegate(
                  this._createChildList(widget.childDataList, cardWidth)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _createChildList(List<CardData> cardDataList, double cardWidth) {
    return List.generate(cardDataList.length, (index) {
      return CardView(
        cardData: cardDataList[index],
        lineColor: widget.lineColorList[index],
        textStyle: TextStyle(fontSize: 20.0, color: Colors.black),
        size: Size(cardWidth, cardWidth / 0.7),
      );
    });
  }
}
