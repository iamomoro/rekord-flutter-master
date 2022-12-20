import 'package:flutter/material.dart';

class BaseSliverContainer extends StatelessWidget {
  final Widget child;
  const BaseSliverContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return child;
        },
        childCount: 1,
      ),
    );
  }
}
