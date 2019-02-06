/**
 * Pie Chart Example
 * ref: https://github.com/xqwzts/flutter_circular_chart
 */

import 'package:flutter/material.dart';
import 'animated_pie_chart/animated_pie_chart.dart';
import 'animated_pie_chart/pie_chart.dart';
import 'animated_pie_chart/entry.dart';

final GlobalKey<AnimatedPieChartState> _chartKey = new GlobalKey();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pie Chart Example'),
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
  List<PieStackEntry> initialData = [
    PieStackEntry([
      PieSegmentEntry(0.0, Colors.red[200]),
      PieSegmentEntry(0.0, Colors.blue[200]),
      PieSegmentEntry(0.0, Colors.yellow[200]),
      PieSegmentEntry(100.0, Colors.white),
    ])
  ];
  List<PieStackEntry> data = [
    PieStackEntry([
      PieSegmentEntry(20.0, Colors.red[200]),
      PieSegmentEntry(50.0, Colors.blue[200]),
      PieSegmentEntry(30.0, Colors.yellow[200]),
      PieSegmentEntry(0.0, Colors.white),
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedPieChart(
              key: _chartKey,
              size: const Size(300.0, 300.0),
              initialPieData: initialData,
              centerText: '習得度\n40.7%',
              centerTextStyle: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            FlatButton(
              child: Text('Animation'),
              onPressed: () {
                setState(() {
                  _chartKey.currentState.updateData(data);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
