import 'package:flutter/material.dart';
import 'dart:math';

import 'foldable_cardview.dart';
import 'problem.dart';

class SwipeActionCardView extends StatefulWidget {
  SwipeActionCardView({Key key}) : super(key: key);

  _SwipeActionCardViewState createState() => _SwipeActionCardViewState();
}

class _SwipeActionCardViewState extends State<SwipeActionCardView>
    with TickerProviderStateMixin {
  GlobalKey problemCardKey = GlobalKey(debugLabel: 'problem_card_key');
  Offset cardOffset = const Offset(0.0, 0.0);
  Offset dragStart;
  Offset dragPosition;
  Offset slideBackStart;
  AnimationController slideBackAnimation;
  Tween<Offset> slideOutTween;
  AnimationController slideOutAnimation;

  void _onPanStart(DragStartDetails details) {
    dragStart = details.globalPosition;

    if (slideBackAnimation.isAnimating) {
      slideBackAnimation.stop(canceled: true);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragPosition = details.globalPosition;
      cardOffset = dragPosition - dragStart;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final dragVector = cardOffset / cardOffset.distance;
    final isInWrongRegion = (cardOffset.dx / context.size.width) < -0.4;
    final isInCorrectRegion = (cardOffset.dx / context.size.width) > 0.4;

    setState(() {
      if (isInWrongRegion || isInCorrectRegion) {
        slideOutTween = Tween(
            begin: cardOffset, end: dragVector * (2 * context.size.width));
        slideOutAnimation.forward(from: 0.0);
      } else {
        slideBackStart = cardOffset;
        slideBackAnimation.forward(from: 0.0);
      }
    });
  }

  double _rotation(Rect cardBounds) {
    if (dragStart != null) {
      // final rotationCornerMultiplier =
      // dragStart.dy >= cardBounds.top + (cardBounds.height / 2) ? -1 : 1;
      return (pi / 8) * (cardOffset.dx / cardBounds.width);
      // * rotationCornerMultiplier;
    } else {
      return 0.0;
    }
  }

  Offset _rotationOrigin(Rect cardBounds) {
    if (dragStart != null) {
      return dragStart - cardBounds.topLeft;
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  void _slideLeft() {
    final screenWidth = context.size.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween = Tween(
        begin: const Offset(0.0, 0.0), end: Offset(-2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  void _slideRight() {
    final screenWidth = context.size.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween =
        Tween(begin: const Offset(0.0, 0.0), end: Offset(2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  Offset _chooseRandomDragStart() {
    final cardContext = problemCardKey.currentContext;
    final cardTopLeft = (cardContext.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0));
    final dragStartY =
        cardContext.size.height * (Random().nextDouble() < 0.5 ? 0.25 : 0.75) +
            cardTopLeft.dy;
    return Offset(cardContext.size.width / 2 + cardTopLeft.dx, dragStartY);
  }

  @override
  void initState() {
    super.initState();
    slideBackAnimation = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addListener(
        () => setState(
              () {
                cardOffset = Offset.lerp(
                  slideBackStart,
                  const Offset(0.0, 0.0),
                  Curves.elasticOut.transform(slideBackAnimation.value),
                );
              },
            ),
      )
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStart = null;
            slideBackStart = null;
            dragPosition = null;
          });
        }
      });

    slideOutAnimation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          cardOffset = slideOutTween.evaluate(slideOutAnimation);
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStart = null;
            dragPosition = null;
            slideOutTween = null;
            cardOffset = const Offset(0.0, 0.0);
          });
        }
      });
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Rect bounds = Rect.fromLTWH(32, 80, size.width - 64, size.height - 160);

    return Transform(
      transform: Matrix4.translationValues(cardOffset.dx, cardOffset.dy, 0.0)
        ..rotateZ(_rotation(bounds)),
      origin: _rotationOrigin(bounds),
      child: Container(
        key: problemCardKey,
        child: FoldableCardView(
          widgetSize: size,
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          problem: Problem(
              problem: 'problem tex \$\\frac{x}{y}\\\\hello\$',
              hint1: 'hint1 tex \$\\frac{x}{y}\\\\hello\$',
              hint2: 'hint2 tex \$\\frac{x}{y}\\\\hello\$',
              hint3: 'hint3 tex \$\\frac{x}{y}\\\\hello\$',
              answer: 'answer tex \$\\frac{x}{y}\\\\hello\$'),
        ),
      ),
    );
  }
}
