import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  CustomCircularProgressIndicator({this.size, this.color});
  @override
  Widget build(BuildContext context) {
    Color _color = color == null ? Theme.of(context).primaryColor : color;

    return Center(
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          height: size,
          width: size,
          padding: EdgeInsets.all(7),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_color),
          ),
        ),
      ),
    );
  }
}
