import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'pie_chart.dart';
import 'stack.dart';

class AnimatedPieChartPainter extends CustomPainter {
  AnimatedPieChartPainter(this.animation) : super(repaint: animation);

  final Animation<PieChart> animation;

  @override
  void paint(Canvas canvas, Size size) {
    _paintChart(canvas, size, animation.value);
  }

  @override
  bool shouldRepaint(AnimatedPieChartPainter old) => false;
}

class PieChartPainter extends CustomPainter {
  PieChartPainter(this.chart);

  final PieChart chart;

  @override
  void paint(Canvas canvas, Size size) {
    _paintChart(canvas, size, chart);
  }

  @override
  bool shouldRepaint(PieChartPainter old) => false;
}

// MARK: - Paint Method
const double _kRadiansPerDegree = Math.pi / 180;

void _paintChart(Canvas canvas, Size size, PieChart chart) {
  final Paint segmentPaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  for (final PieChartStack stack in chart.stacks) {
    for (final segment in stack.segments) {
      segmentPaint.color = segment.color;
      segmentPaint.strokeWidth = stack.width;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: stack.radius,
        ),
        stack.startAngle * _kRadiansPerDegree,
        segment.sweepAngle * _kRadiansPerDegree,
        true,
        segmentPaint,
      );
    }
  }

  segmentPaint.color = Colors.white;
  canvas.drawCircle(Offset(size.width / 2, size.height / 2),
      size.width / 2 * 0.6, segmentPaint);
}
