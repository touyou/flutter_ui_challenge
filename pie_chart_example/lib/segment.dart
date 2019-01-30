import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pie_chart_example/tween.dart';

/// Segment
class PieChartSegment extends MergeTweenable<PieChartSegment> {
  PieChartSegment(this.rank, this.sweepAngle, this.color);

  final int rank;
  final double sweepAngle;
  final Color color;

  @override
  PieChartSegment get empty => PieChartSegment(rank, 0.0, color);

  @override
  bool operator <(PieChartSegment other) => rank < other.rank;

  @override
  Tween<PieChartSegment> tweenTo(PieChartSegment other) =>
      PieChartSegmentTween(this, other);

  static PieChartSegment lerp(
      PieChartSegment begin, PieChartSegment end, double t) {
    assert(begin.rank == end.rank);

    return PieChartSegment(
      begin.rank,
      lerpDouble(begin.sweepAngle, end.sweepAngle, t),
      Color.lerp(begin.color, end.color, t),
    );
  }
}

/// Segment Tween
class PieChartSegmentTween extends Tween<PieChartSegment> {
  PieChartSegmentTween(PieChartSegment begin, PieChartSegment end)
      : super(begin: begin, end: end) {
    assert(begin.rank == end.rank);
  }

  @override
  PieChartSegment lerp(double t) => PieChartSegment.lerp(begin, end, t);
}
