import 'package:flutter/material.dart';

import 'problem.dart';
import 'swipe_action_cardview.dart';

class CardStack extends StatefulWidget {
  final ProblemEngine problemEngine;

  CardStack({Key key, this.problemEngine}) : super(key: key);

  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  Key _frontCard;
  Problem _currentProblem;
  double _nextCardScale = 0.9;

  void _onProblemEngineChange() {
    _frontCard = Key(_currentProblem.problem);

    setState(() {
      _currentProblem = widget.problemEngine.currentProblem;
      _nextCardScale = 0.9;
    });
  }

  void _onSlideUpdate(double distance) {
    setState(() {
      _nextCardScale = 0.9 + (0.1 * (distance / 100.0)).clamp(0.0, 0.1);
    });
  }

  void _onSlideOutComplete() {
    widget.problemEngine.cycleProblem();
  }

  @override
  void initState() {
    super.initState();

    widget.problemEngine.addListener(_onProblemEngineChange);

    _currentProblem = widget.problemEngine.currentProblem;

    _frontCard = Key(_currentProblem.problem);
  }

  @override
  void didUpdateWidget(CardStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.problemEngine != oldWidget.problemEngine) {
      oldWidget.problemEngine.removeListener(_onProblemEngineChange);
      widget.problemEngine.addListener(_onProblemEngineChange);
    }
  }

  @override
  void dispose() {
    widget.problemEngine.removeListener(_onProblemEngineChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackCard(),
        _buildFrontCard(),
      ],
    );
  }

  Widget _buildBackCard() {
    return Transform(
      transform: Matrix4.identity()..scale(_nextCardScale, _nextCardScale),
      alignment: Alignment.center,
      child: SwipeActionCardView(
        problem: widget.problemEngine.nextProblem,
      ),
    );
  }

  Widget _buildFrontCard() {
    return SwipeActionCardView(
      key: _frontCard,
      problem: widget.problemEngine.currentProblem,
      onSlideUpdate: _onSlideUpdate,
      onSlideOutComplete: _onSlideOutComplete,
    );
  }
}
