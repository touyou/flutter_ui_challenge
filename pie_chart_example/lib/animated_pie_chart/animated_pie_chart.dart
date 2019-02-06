import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart_example/animated_pie_chart/pie_chart.dart';
import 'package:pie_chart_example/animated_pie_chart/entry.dart';
import 'package:pie_chart_example/animated_pie_chart/painter.dart';

const Duration _kDuration = const Duration(milliseconds: 300);
const double _kStartAngle = -90.0;
const TextStyle _kTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0);

class AnimatedPieChart extends StatefulWidget {
  AnimatedPieChart({
    Key key,
    @required this.size,
    @required this.initialPieData,
    @required this.centerText,
    this.duration = _kDuration,
    this.isPercentageValues = false,
    this.holeRadius,
    this.startAngle = _kStartAngle,
    this.centerTextStyle = _kTextStyle,
  })  : assert(size != null),
        super(key: key);

  final Size size;
  final List<PieStackEntry> initialPieData;
  final Duration duration;
  final bool isPercentageValues;
  final double holeRadius;
  final double startAngle;
  final String centerText;
  final TextStyle centerTextStyle;

  static AnimatedPieChartState of(BuildContext context, {bool nullOk: false}) {
    assert(context != null);
    assert(nullOk != null);

    final AnimatedPieChartState result =
        context.ancestorStateOfType(const TypeMatcher<AnimatedPieChartState>());

    if (nullOk || result != null) return result;

    throw FlutterError(
        'AnimatedCircularChart.of() called with a context that does not contain a AnimatedCircularChart.\n'
        'No AnimatedCircularChart ancestor could be found starting from the context that was passed to AnimatedCircularChart.of(). '
        'This can happen when the context provided is from the same StatefulWidget that '
        'built the AnimatedCircularChart.\n'
        'The context used was:\n'
        '  $context');
  }

  @override
  AnimatedPieChartState createState() => AnimatedPieChartState();
}

class AnimatedPieChartState extends State<AnimatedPieChart>
    with TickerProviderStateMixin {
  PieChartTween _tween;
  AnimationController _animation;
  bool isText = false;
  final Map<String, int> _stackRanks = {};
  final Map<String, int> _entryRanks = {};

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _assignRanks(widget.initialPieData);

    _tween = PieChartTween(
      PieChart.empty(),
      PieChart.fromData(
        size: widget.size,
        data: widget.initialPieData,
        stackRanks: _stackRanks,
        entryRanks: _entryRanks,
        isPercentageValues: widget.isPercentageValues,
        holeRadius: widget.holeRadius,
        startAngle: widget.startAngle,
      ),
    );
    _animation.forward();
  }

  @override
  void didUpdateWidget(AnimatedPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  void _assignRanks(List<PieStackEntry> data) {
    for (PieStackEntry stackEntry in data) {
      _stackRanks.putIfAbsent(stackEntry.rankKey, () => _stackRanks.length);
      for (PieSegmentEntry entry in stackEntry.entries) {
        _entryRanks.putIfAbsent(entry.rankKey, () => _entryRanks.length);
      }
    }
  }

  void updateData(List<PieStackEntry> data) {
    _assignRanks(data);

    setState(() {
      _tween = PieChartTween(
        _tween.evaluate(_animation),
        PieChart.fromData(
          size: widget.size,
          data: data,
          stackRanks: _stackRanks,
          entryRanks: _entryRanks,
          isPercentageValues: widget.isPercentageValues,
          holeRadius: widget.holeRadius,
          startAngle: widget.startAngle,
        ),
      );
      _animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: widget.size,
          painter: AnimatedPieChartPainter(
            _tween.animate(_animation),
          ),
        ),
        isText
            ? Text(
                widget.centerText,
                style: widget.centerTextStyle,
              )
            : Hero(
                tag: 'hello',
                child: Icon(
                  Icons.airport_shuttle,
                  color: Colors.black45,
                  size: 100.0,
                ),
              ),
        GestureDetector(
          onTap: () {
            setState(() {
              isText = !isText;
            });
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            alignment: Alignment.center,
            width: widget.size.width,
            height: widget.size.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.circular(widget.size.width / 2),
              shape: BoxShape.circle,
            ),
            child: Text(''),
          ),
        )
      ],
    );
  }
}
