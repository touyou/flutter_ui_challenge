import 'package:flutter/material.dart';
import '../juken7_text_label/juken7_text_label.dart';

const Size _kSize = Size(200, 50);
const Size _kTextSize = Size(140, 30);
const TextStyle _kTextStyle = TextStyle(fontSize: 20.0, color: Colors.black);

class RoundedButton extends StatefulWidget {
  RoundedButton({
    @required this.title,
    @required this.lineColor,
    @required this.onTap,
    this.size = _kSize,
    this.textSize = _kTextSize,
    this.textStyle = _kTextStyle,
  }) : super();

  final String title;
  final Color lineColor;
  final Function onTap;
  final Size size;
  final Size textSize;
  final TextStyle textStyle;

  @override
  RoundedButtonState createState() => RoundedButtonState();
}

class RoundedButtonState extends State<RoundedButton> {
  bool _tapInProgress;

  RoundedButtonState() {
    _tapInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: SizedBox(
        height: widget.size.height,
        width: widget.size.width,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _tapInProgress ? Colors.white12 : Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(widget.size.height)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: UnderlineTextLabel(
            texts: [widget.title],
            color: widget.lineColor,
            size: widget.textSize,
            textStyle: widget.textStyle,
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _tapInProgress = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _tapInProgress = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _tapInProgress = false;
    });
  }
}
