import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';

class WidgetHeader extends StatelessWidget with BaseMixins {
  final String title;
  final String route;
  WidgetHeader({this.title, this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .primaryTextTheme
                .headline3
                .copyWith(fontSize: 12),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 3),
              child: Text(
                $t(context, 'show_more'),
                style: Theme.of(context).primaryTextTheme.headline3.copyWith(
                    fontSize: 10, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
