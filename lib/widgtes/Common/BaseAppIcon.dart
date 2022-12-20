import 'package:flutter/material.dart';

class BaseAppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Image.asset(
        'assets/images/logo.png',
        width: 40,
      ),
    );
  }
}
