import 'package:flutter/material.dart';
import 'package:mathjax_view/mathjax_view.dart';
import '../juken7_text_label/juken7_text_label.dart';
import 'problem.dart';
import 'foldable_state.dart';

class FoldableCardView extends StatefulWidget {
  final Size widgetSize;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;
  final Problem problem;

  FoldableCardView({
    @required this.widgetSize,
    @required this.onPanStart,
    @required this.onPanUpdate,
    @required this.onPanEnd,
    @required this.problem,
  });

  @override
  FoldableCardViewState createState() => new FoldableCardViewState();
}

class FoldableCardViewState extends State<FoldableCardView> {
  // FoldableState _foldableState = FoldableState.problem;
  FoldableStateListener _foldableStateListener = FoldableStateListener();
  MathjaxViewController answerController;
  MathjaxViewController problemController;
  MathjaxViewController hint1Controller;
  MathjaxViewController hint2Controller;
  MathjaxViewController hint3Controller;

  @override
  void initState() {
    super.initState();

    _foldableStateListener.addListener(() {
      Future.delayed(Duration(milliseconds: 10), () {
        if (_foldableStateListener.state == FoldableState.nextProblem ||
            _foldableStateListener.state == FoldableState.answerBefore) {
          setState(() {
            _foldableStateListener.nextState();
          });
        }
      });
    });
  }

  @override
  void didUpdateWidget(FoldableCardView oldWidget) {
    if (oldWidget.problem != widget.problem) {
      _foldableStateListener.reset();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widgetSize.width - 64,
      height: _cardSize(_foldableStateListener.state),
      child: Container(
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
          children: _buildContents(),
        ),
      ),
    );
  }

  List<Widget> _buildContents() {
    List<Widget> viewList = [];
    double texWidth = widget.widgetSize.width - 64;
    double texHeight = widget.widgetSize.height - 350;

    Widget divider = Divider(
      color: Color.fromARGB(255, 223, 223, 223),
    );

    Widget answer = Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: SizedBox(
        width: texWidth,
        height: texHeight,
        child: MathjaxView(
          onMathjaxViewCreated: (controller) {
            answerController = controller;
            // print(answerController);
            answerController.setLatexText(widget.problem.answer);
          },
          fontSize: 16,
        ),
      ),
    );
    Widget problem = Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: SizedBox(
        width: texWidth,
        height: texHeight / 4,
        child: MathjaxView(
          onMathjaxViewCreated: (controller) {
            problemController = controller;
            // print(problemController);
            problemController.setLatexText(widget.problem.problem);
          },
          fontSize: 20,
        ),
      ),
    );
    Widget hint1 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: texWidth,
        height: texHeight / 4,
        child: MathjaxView(
          onMathjaxViewCreated: (controller) {
            hint1Controller = controller;
            // print(hint1Controller);
            hint1Controller.setLatexText(widget.problem.hint1);
          },
          fontSize: 16,
        ),
      ),
    );
    Widget hint2 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: texWidth,
        height: texHeight / 4,
        child: MathjaxView(
          onMathjaxViewCreated: (controller) {
            hint2Controller = controller;
            // print(hint2Controller);
            hint2Controller.setLatexText(widget.problem.hint2);
          },
          fontSize: 16,
        ),
      ),
    );
    Widget hint3 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: texWidth,
        height: texHeight / 4,
        child: MathjaxView(
          onMathjaxViewCreated: (controller) {
            hint3Controller = controller;
            // print(hint3Controller);
            hint3Controller.setLatexText(widget.problem.hint3);
          },
          fontSize: 16,
        ),
      ),
    );

    Widget hint1Label = UnderlineTextLabel(
      color: Color.fromARGB(70, 226, 156, 74),
      size: Size(texWidth / 3 - 32, 20),
      texts: ['ヒント①'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 18,
      ),
    );
    Widget hint2Label = UnderlineTextLabel(
      color: Color.fromARGB(70, 155, 226, 74),
      size: Size(texWidth / 3 - 32, 20),
      texts: ['ヒント②'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 18,
      ),
    );
    Widget hint3Label = UnderlineTextLabel(
      color: Color.fromARGB(70, 74, 225, 226),
      size: Size(texWidth / 3 - 32, 20),
      texts: ['ヒント③'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 18,
      ),
    );
    Widget answerLabel = UnderlineTextLabel(
      color: Color.fromARGB(70, 226, 103, 74),
      size: Size(texWidth / 3 - 32, 20),
      texts: ['解答'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 18,
      ),
    );

    switch (_foldableStateListener.state) {
      case FoldableState.answer:
        viewList = [
          answerLabel,
          answer,
          Spacer(),
          divider,
          Text('解答時間: n分n秒'),
          _buildOperator(),
        ];
        break;
      case FoldableState.answerBefore:
        return [];
      case FoldableState.nextProblem:
        return [];
      default:
        switch (_foldableStateListener.state) {
          case FoldableState.hint1:
            viewList = [
              problem,
              divider,
              hint1Label,
              hint1,
              Spacer(),
              divider,
              Text('ヒント２を開く'),
            ];
            break;
          case FoldableState.hint2:
            viewList = [
              problem,
              divider,
              hint1Label,
              hint1,
              divider,
              hint2Label,
              hint2,
              Spacer(),
              divider,
              Text('ヒント３を開く'),
            ];
            break;
          case FoldableState.hint3:
            viewList = [
              problem,
              divider,
              hint1Label,
              hint1,
              divider,
              hint2Label,
              hint2,
              divider,
              hint3Label,
              hint3,
              Spacer(),
              divider,
              Text('解けたら解答を見てみよう！'),
            ];
            break;
          default:
            viewList = [
              problem,
              Spacer(),
              divider,
              Text('ヒント１を開く'),
            ];
            break;
        }

        viewList.add(_buildOperator());
        break;
    }

    return viewList;
  }

  Widget _buildOperator() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _foldableStateListener.nextState();
        });
      },
      onPanStart: _foldableStateListener.state == FoldableState.answer
          ? widget.onPanStart
          : null,
      onPanUpdate: _foldableStateListener.state == FoldableState.answer
          ? widget.onPanUpdate
          : null,
      onPanEnd: _foldableStateListener.state == FoldableState.answer
          ? widget.onPanEnd
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: widget.widgetSize.width / 3 - 32,
          height: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 216, 216, 216),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
      ),
    );
  }

  double _cardSize(FoldableState state) {
    double texHeight = widget.widgetSize.height - 350;
    switch (state) {
      case FoldableState.problem:
        return widget.widgetSize.height - 160 - texHeight / 4 * 3;
        break;
      case FoldableState.hint1:
        return widget.widgetSize.height - 160 - texHeight / 4 * 2;
        break;
      case FoldableState.hint2:
        return widget.widgetSize.height - 160 - texHeight / 4;
        break;
      case FoldableState.hint3:
        return widget.widgetSize.height - 160;
        break;
      case FoldableState.answer:
        return widget.widgetSize.height - 160;
        break;
      default:
        return 0.0;
    }
  }
}
