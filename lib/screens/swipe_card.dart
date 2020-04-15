import 'package:flutter/material.dart';

class SwipeCard extends StatefulWidget {
  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  var _rotateTween;
  var _rightTween;
  var _bottomTween;

  var _screenSize;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: new Duration(seconds: 1),
      vsync: this,
    );

    //_screenSize = MediaQuery.of(context).size;

    _rotateTween = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _rotateTween.addListener(() {});

    _rightTween = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _bottomTween = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }

  _dismissImage() async {
    try {
      await _animationController.repeat();
    } on TickerCanceled {
      // Can do something if the animation is cancelled
    }
  }

  _buildImage() {
    return Container(
      color: Colors.transparent,
      child: Column(children: <Widget>[
        ClipRRect(
          child: Image.asset("images/mawra.jpg"),
        ),
        RaisedButton(
          child: Text("PRESS ME"),
          color: Colors.yellow,
          onPressed: () => _dismissImage(),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey("MY_UID"),
      crossAxisEndOffset: -0.3,
      onDismissed: (_) { 
        _dismissImage();
      },
      child: RotationTransition(
        turns: _animationController, 
        child: _buildImage()
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
