import 'package:flutter/material.dart';
import 'juken7_foldable_cardview/juken7_foldable_cardview.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Align(
          alignment: Alignment.topCenter,
          child: CardStack(
            problemEngine: ProblemEngine(problems: [
              Problem(
                  problem: 'problem tex \$\\frac{x}{y}\\\\hello\$',
                  hint1: 'hint1 tex \$\\frac{x}{y}\\\\hello\$',
                  hint2: 'hint2 tex \$\\frac{x}{y}\\\\hello\$',
                  hint3: 'hint3 tex \$\\frac{x}{y}\\\\hello\$',
                  answer: 'answer tex \$\\frac{x}{y}\\\\hello\$'),
              Problem(
                  problem: 'problem2 tex \$\\frac{x^2}{y}=20\\\\hello\$',
                  hint1: 'hint1 tex \$\\frac{x^2}{y}=20\\\\hello\$',
                  hint2: 'hint2 tex \$\\frac{x^2}{y}=20\\\\hello\$',
                  hint3: 'hint3 tex \$\\frac{x^2}{y}=20\\\\hello\$',
                  answer: 'answer tex \$\\frac{x^2}{y}=20\\\\hello\$')
            ]),
          ),
        ),
      ),
    );
  }
}
