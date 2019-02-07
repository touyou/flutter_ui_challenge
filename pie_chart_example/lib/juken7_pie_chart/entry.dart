import 'dart:ui';

/// One element
class PieSegmentEntry {
  const PieSegmentEntry(this.value, this.color, {this.rankKey});

  /// Value of this entry
  final double value;

  /// Color of this entry chart
  final Color color;

  /// Order of this entry?
  final String rankKey;

  String toString() {
    return '$rankKey: $value $color';
  }
}

/// Some elements
class PieStackEntry {
  const PieStackEntry(this.entries, {this.rankKey});

  final List<PieSegmentEntry> entries;

  final String rankKey;
}
