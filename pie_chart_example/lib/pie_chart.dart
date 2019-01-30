import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart_example/entry.dart';
import 'package:pie_chart_example/stack.dart';
import 'package:pie_chart_example/tween.dart';

class PieChart {
  static const double _kStackWidthFraction = 0.75;

  PieChart(this.stacks);

  final List<PieChartStack> stacks;

  factory PieChart.empty() {
    return PieChart([]);
  }

  factory PieChart.fromData({
    @required Size size,
    @required List<PieStackEntry> data,
    @required bool isPercentageValues,
    @required double startAngle,
    Map<String, int> stackRanks,
    Map<String, int> entryRanks,
    double holeRadius,
  }) {
    final double _holeRadius = holeRadius ?? size.width / (2 + data.length);
    final double stackDistance =
        (size.width / 2 - _holeRadius) / (2 + data.length);
    final double stackWidth = stackDistance * _kStackWidthFraction;
    final double startRadius = stackDistance + _holeRadius;

    List<PieChartStack> stacks = List<PieChartStack>.generate(
      data.length,
      (i) => PieChartStack.fromData(
          stackRanks[data[i].rankKey] ?? i,
          data[i].entries,
          entryRanks,
          isPercentageValues,
          startRadius + i * stackDistance,
          stackWidth,
          startAngle),
    );

    return PieChart(stacks);
  }
}

class PieChartTween extends Tween<PieChart> {
  PieChartTween(PieChart begin, PieChart end)
      : _stacksTween = MergeTween(begin.stacks, end.stacks),
        super(begin: begin, end: end);

  final MergeTween<PieChartStack> _stacksTween;

  @override
  PieChart lerp(double t) => PieChart(_stacksTween.lerp(t));
}
