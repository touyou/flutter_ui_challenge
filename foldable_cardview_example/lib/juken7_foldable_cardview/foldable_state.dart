import 'package:flutter/widgets.dart';

class FoldableStateListener extends ChangeNotifier {
  FoldableState state = FoldableState.problem;

  void nextState() {
    switch (state) {
      case FoldableState.problem:
        state = FoldableState.hint1;
        notifyListeners();
        break;
      case FoldableState.hint1:
        state = FoldableState.hint2;
        notifyListeners();
        break;
      case FoldableState.hint2:
        state = FoldableState.hint3;
        notifyListeners();
        break;
      case FoldableState.hint3:
        state = FoldableState.answerBefore;
        notifyListeners();
        break;
      case FoldableState.answerBefore:
        state = FoldableState.answer;
        notifyListeners();
        break;
      case FoldableState.nextProblem:
        state = FoldableState.problem;
        notifyListeners();
        break;
      default:
        break;
    }
  }

  void reset() {
    state = FoldableState.nextProblem;
    notifyListeners();
  }
}

enum FoldableState {
  nextProblem,
  problem,
  hint1,
  hint2,
  hint3,
  answer,
  answerBefore
}
