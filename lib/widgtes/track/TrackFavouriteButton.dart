import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';

class TrackFavouriteButton extends StatelessWidget with BaseMixins {
  final Album album;
  final Track track;
  final double iconSize;
  TrackFavouriteButton({this.track, this.album, iconSize})
      : iconSize = iconSize ?? 20;

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favouriteProvider = Provider.of(context);
    return IconButton(
        icon: Icon(
          favouriteProvider.isFavouitedTrack(track)
              ? AntDesign.heart
              : AntDesign.hearto,
        ),
        iconSize: iconSize,
        color: activeColor(context, favouriteProvider.isFavouitedTrack(track)),
        onPressed: () {
          favouriteProvider.addToFavouritesTrack(track);
        });
  }
}
