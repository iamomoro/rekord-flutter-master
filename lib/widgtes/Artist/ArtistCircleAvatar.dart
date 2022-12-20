import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Artist.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';

class ArtistCircleAvatar extends StatelessWidget {
  final double height;
  final double width;
  const ArtistCircleAvatar(
      {Key key, @required this.artist, this.height, this.width})
      : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CircleAvatar(
        child: ClipOval(
            child: BaseImage(
          imageUrl: artist.media.thumbnail,
        )),
      ),
    );
  }
}
