import 'package:flutter/animation.dart';

/// Merge Tween Protocol
abstract class MergeTweenable<T> {
  T get empty;

  Tween<T> tweenTo(T other);

  bool operator <(T other);
}

/// Merge Tween
class MergeTween<T extends MergeTweenable<T>> extends Tween<List<T>> {
  // Merge two Tween List
  MergeTween(List<T> begin, List<T> end) : super(begin: begin, end: end) {
    final beginMax = begin.length;
    final endMax = end.length;
    var bIndex = 0;
    var eIndex = 0;
    while (bIndex + eIndex < beginMax + endMax) {
      if (bIndex < beginMax &&
          (eIndex == endMax || begin[bIndex] < end[eIndex])) {
        _tweens.add(begin[bIndex].tweenTo(begin[bIndex].empty));
        bIndex++;
      } else if (eIndex < endMax &&
          (bIndex == beginMax || end[eIndex] < begin[bIndex])) {
        _tweens.add(end[eIndex].empty.tweenTo(end[eIndex]));
        eIndex++;
      } else {
        _tweens.add(begin[bIndex].tweenTo(end[eIndex]));
        bIndex++;
        eIndex++;
      }
    }
  }

  final _tweens = <Tween<T>>[];

  @override
  List<T> lerp(double t) => List.generate(
        _tweens.length,
        (i) => _tweens[i].lerp(t),
      );
}
