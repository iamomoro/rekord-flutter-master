import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';

class AlbumTileActions extends StatelessWidget with BaseMixins {
  final Album album;
  final String title;

  final Widget child;
  AlbumTileActions({Key key, this.child, this.title, this.album});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: child,
      onSelected: (String value) {
        if (value == 'details') {
          Navigator.of(context).pushNamed(
            AppRoutes.albumDetail,
            arguments: album,
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'details',
          child: Text('$title'),
        ),
      ],
    );
  }
}
