import 'package:flutter/material.dart';
import 'package:mathjax_view/mathjax_view.dart';
import '../juken7_text_label/juken7_text_label.dart';

class FoldableCardView extends StatefulWidget {
  final Size widgetSize;

  FoldableCardView({
    @required this.widgetSize,
  });

  @override
  FoldableCardViewState createState() => new FoldableCardViewState();
}

class FoldableCardViewState extends State<FoldableCardView> {
  FoldableState _foldableState = FoldableState.problem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widgetSize.width - 64,
      height: _cardSize(_foldableState),
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
            // TODO: set answer latex text
            controller.setLatexText('answer tex \$x^2=y\$');
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
            // TODO: set answer latex text
            controller.setLatexText('problem tex \$\\frac{x}{y}\$');
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
            // TODO: set answer latex text
            controller.setLatexText('hint1 tex \$\\frac{x}{y}\$');
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
            // TODO: set answer latex text
            controller.setLatexText('hint2 tex \$\\frac{x}{y}\\\\hello\$');
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
            // TODO: set answer latex text
            controller.setLatexText('hint2 tex \$\\frac{x}{y}\\\\hello\$');
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

    switch (_foldableState) {
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
      default:
        switch (_foldableState) {
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
          _foldableState = _next(_foldableState);
        });
      },
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

  FoldableState _next(FoldableState state) {
    switch (state) {
      case FoldableState.problem:
        return FoldableState.hint1;
        break;
      case FoldableState.hint1:
        return FoldableState.hint2;
        break;
      case FoldableState.hint2:
        return FoldableState.hint3;
        break;
      case FoldableState.hint3:
        return FoldableState.answer;
        break;
      case FoldableState.answer:
        return FoldableState.problem;
        break;
    }
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
    }
  }
}

enum FoldableState { problem, hint1, hint2, hint3, answer }
