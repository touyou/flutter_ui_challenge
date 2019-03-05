import 'package:flutter/material.dart';

import 'juken7_card_gridview/juken7_card_gridview.dart';
import 'juken7_text_label/juken7_text_label.dart';
import 'juken7_pie_chart/juken7_pie_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        left: true,
        right: true,
        top: false,
        bottom: false,
        child: CardGridView(
          titleWidget: UnderlineTextLabel(
            texts: ['Hello', 'World'],
            textStyle: TextStyle(fontSize: 30.0, color: Colors.black),
            color: Color.fromARGB(100, 25, 200, 20),
            size: Size(windowSize.width, 80),
          ),
          lineColorList: List.generate(20, (index) {
            return Color.fromARGB(20, 100, 20, 80);
          }),
          childDataList: List.generate(20, (index) {
            return CardData(
                cardTitle: "SDCard",
                imageTag: "image",
                score: 50.0,
                image: Icon(Icons.sd_card),
                initialPieData: [
                  PieStackEntry([
                    PieSegmentEntry(20.0, Colors.red[200]),
                    PieSegmentEntry(50.0, Colors.blue[200]),
                    PieSegmentEntry(30.0, Colors.yellow[200]),
                    PieSegmentEntry(0.0, Colors.white),
                  ])
                ]);
          }),
        ),
      ),
    );
  }
}
