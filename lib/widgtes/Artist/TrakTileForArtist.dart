import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Artist.dart';
import 'package:flutter_rekord_app/widgtes/Track/TrackTile.dart';

class TrakTileForArtist extends StatelessWidget {
  const TrakTileForArtist({
    Key key,
    @required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: artist.tracks.length,
              itemBuilder: (context, index) {
                Album album = new Album(
                    null, '${artist.name}', null, null, artist.tracks);
                return TrackTile(
                  index: index,
                  track: artist.tracks[index],
                  tracks: artist.tracks,
                  album: album,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
