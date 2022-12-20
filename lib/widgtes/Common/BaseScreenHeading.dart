import 'package:flutter/material.dart';

class BaseScreenHeading extends StatelessWidget {
  final String title;
  const BaseScreenHeading({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
      ),
    );
  }
}
