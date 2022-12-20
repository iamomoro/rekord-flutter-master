import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/screens/album/SearchScreen.dart';
import 'package:flutter_rekord_app/screens/post/PostsScreen.dart';

class BaseAppBar extends StatelessWidget {
  final title;
  const BaseAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Feather.rss, color: Theme.of(context).primaryColor),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PostsScreen(),
                fullscreenDialog: true,
              ));
        },
      ),
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 8,
                  fontSize: 14),
            )
          : Container(),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SearchScreen(),
                  fullscreenDialog: true,
                ));
          },
        ),
      ],
    );
  }
}
