import 'package:flutter/widgets.dart';

class ProblemEngine extends ChangeNotifier {
  final List<Problem> _problems;
  int _currentIndex;
  int _nextIndex;

  ProblemEngine({
    List<Problem> problems,
  }) : _problems = problems {
    _currentIndex = 0;
    _nextIndex = 1;
  }

  Problem get currentProblem => _problems[_currentIndex];
  Problem get nextProblem => _problems[_nextIndex];

  void cycleProblem() {
    _currentIndex = _nextIndex;
    _nextIndex = _nextIndex < _problems.length - 1 ? _nextIndex + 1 : 0;

    notifyListeners();
  }
}

class Problem {
  final String problem;
  final String hint1;
  final String hint2;
  final String hint3;
  final String answer;

  Problem({this.problem, this.hint1, this.hint2, this.hint3, this.answer});
}
