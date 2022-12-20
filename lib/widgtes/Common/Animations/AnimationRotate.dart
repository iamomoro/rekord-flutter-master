import 'package:flutter/material.dart';
import 'dart:math';

class AnimationRotate extends StatefulWidget {
  final Widget child;
  final bool stop;
  AnimationRotate({Key key, this.child, this.stop}) : super(key: key);

  @override
  _AnimationRotateState createState() => _AnimationRotateState();
}

class _AnimationRotateState extends State<AnimationRotate>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        double _angle = _controller.value * 2 * pi;
        if (widget.stop) {
          _angle = 0.0;
        }

        return Transform.rotate(angle: _angle, child: widget.child);
      },
    );
  }
}
