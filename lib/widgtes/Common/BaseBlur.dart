import 'dart:ui';

import 'package:flutter/material.dart';

class BaseBlur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
