import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'entry.dart';
import 'segment.dart';
import 'tween.dart';

const double _kMaxAngle = 360.0;

class PieChartStack implements MergeTweenable<PieChartStack> {
  PieChartStack(
      this.rank, this.radius, this.width, this.startAngle, this.segments);

  final int rank;
  final double radius;
  final double width;
  final double startAngle;
  final List<PieChartSegment> segments;

  /// Create PieChartStack from Data
  factory PieChartStack.fromData(
    int stackRank,
    List<PieSegmentEntry> entries,
    Map<String, int> entryRanks,
    bool isPercentageValues,
    double startRadius,
    double stackWidth,
    double startAngle,
  ) {
    final double valueSum = isPercentageValues
        ? 100.0
        : entries.fold(0.0,
            (double prev, PieSegmentEntry element) => prev + element.value);

    double previousSweepAngle = 0.0;
    List<PieChartSegment> segments =
        List<PieChartSegment>.generate(entries.length, (i) {
      double sweepAngle =
          (entries[i].value / valueSum * _kMaxAngle) + previousSweepAngle;
      previousSweepAngle = sweepAngle;
      int rank = entryRanks[entries[i].rankKey] ?? i;
      return PieChartSegment(rank, sweepAngle, entries[i].color);
    });

    return PieChartStack(
      stackRank,
      startRadius,
      stackWidth,
      startAngle,
      segments.reversed.toList(),
    );
  }

  @override
  PieChartStack get empty => PieChartStack(rank, radius, 0.0, startAngle, []);

  @override
  bool operator <(PieChartStack other) => rank < other.rank;

  @override
  Tween<PieChartStack> tweenTo(PieChartStack other) =>
      PieChartStackTween(this, other);
}

class PieChartStackTween extends Tween<PieChartStack> {
  PieChartStackTween(PieChartStack begin, PieChartStack end)
      : _circularSegmentsTween =
            MergeTween<PieChartSegment>(begin.segments, end.segments),
        super(begin: begin, end: end) {
    assert(begin.rank == end.rank);
  }

  final MergeTween<PieChartSegment> _circularSegmentsTween;

  @override
  PieChartStack lerp(double t) => PieChartStack(
        begin.rank,
        lerpDouble(begin.radius, end.radius, t),
        lerpDouble(begin.width, end.width, t),
        lerpDouble(begin.startAngle, end.startAngle, t),
        _circularSegmentsTween.lerp(t),
      );
}
