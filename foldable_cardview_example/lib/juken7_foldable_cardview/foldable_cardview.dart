import 'package:flutter/material.dart';
import 'package:mathjax_view/mathjax_view.dart';

class FoldableCardView extends StatefulWidget {
  FoldableCardView({
    @required this.widgetSize,
  }) : super();

  final Size widgetSize;

  @override
  FoldableCardViewState createState() => new FoldableCardViewState();
}

class FoldableCardViewState extends State<FoldableCardView> {
  FoldableState _foldableState = FoldableState.problem;

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
              color: Color.fromARGB(10, 0, 0, 0),
              blurRadius: 5.0,
              spreadRadius: 2.0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _generateView(),
      ),
    );
  }

  List<Widget> _generateView() {
    List<Widget> viewList = [];

    switch (_foldableState) {
      case FoldableState.answer:
        viewList = [
          // TODO: 解答のLabel
          MathjaxView(
            onMathjaxViewCreated: (controller) {
              // TODO: set answer latex text
              controller.setLatexText('answer tex');
            },
            fontSize: 12,
          ),
          Divider(
            color: Color.fromARGB(255, 223, 223, 223),
          ),
          Text('解答時間: n分n秒'),
          _createOperator(),
        ];
        break;
      default:
        viewList = [
          MathjaxView(
            onMathjaxViewCreated: (controller) {
              // TODO: set answer latex text
              controller.setLatexText('answer tex');
            },
            fontSize: 12,
          ),
        ];
        break;
    }

    return viewList;
  }

  Widget _createOperator() {
    return SizedBox(
      width: widget.widgetSize.width / 3 - 16,
      height: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 216, 216, 216),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }
}

enum FoldableState { problem, hint1, hint2, hint3, answer }
