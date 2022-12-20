import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/widgtes/track/TrackBottomBar.dart';

import 'CustomCircularProgressIndicator.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;
  final bool isLoaded;
  BaseScaffold({this.child, this.isLoaded});
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          !widget.isLoaded ? CustomCircularProgressIndicator() : widget.child,
          Positioned(
            bottom: 0.0,
            left: 0.0,
            height: 50,
            right: 0.0,
            child: TrackBottomBar(),
          ),
        ],
      ),
    );
  }
}
