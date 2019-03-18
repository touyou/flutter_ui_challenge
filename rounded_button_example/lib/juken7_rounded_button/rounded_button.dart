import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton({
    @required this.title,
    @required this.lineColor,
    @required this.onTap,
  }) : super();

  final String title;
  final Color lineColor;
  final Function onTap;

  @override
  RoundedButtonState createState() => RoundedButtonState();
}

class RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
    );
  }
}
