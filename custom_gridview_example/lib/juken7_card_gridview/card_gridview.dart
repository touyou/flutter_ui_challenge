import 'package:flutter/material.dart';

class CardGridView extends StatefulWidget {
  CardGridView({
    @required this.titleWidget,
  }) : super();

  final Widget titleWidget;

  @override
  CardGridViewState createState() => CardGridViewState();
}

class CardGridViewState extends State<CardGridView> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

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
                _createChildList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _createChildList() {
    return [Text('Sample')];
  }
}
