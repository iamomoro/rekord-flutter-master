import 'package:flutter/material.dart';

class BaseOverlay extends StatelessWidget {
  final Widget child;
  BaseOverlay({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        child: child,
      ),
      Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Color(0xff0C101B).withOpacity(.1),
              Theme.of(context).scaffoldBackgroundColor
            ],
            stops: [0.3, 0.93],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
          ),
        ),
      )
    ]);
  }
}
