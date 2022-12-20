import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';
import '../TrackPlayButton.dart';

class TrackCarouselTile extends StatelessWidget {
  final Track track;
  final int index;
  final List<Track> tracks;
  final String title;
  const TrackCarouselTile({this.track, this.index, this.tracks, this.title});

  @override
  Widget build(BuildContext context) {
    String _title = this.title != null ? title : 'Featured';
    Album album = new Album(null, _title, null, null, tracks);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: ListTile(
                  leading: TrackPlayButton(
                    track: track,
                    index: index,
                    album: album,
                  ),
                  title: Transform(
                    transform: Matrix4.translationValues(-12, 0.0, 0.0),
                    child: Text(track.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ),
                  subtitle: Transform(
                    transform: Matrix4.translationValues(-12, 0.0, 0.0),
                    child:
                        Text(track.artist != null ? track.artist[0].name : '',
                            style: TextStyle(
                              fontSize: 12,
                            )),
                  ),
                  trailing: track.media != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: BaseImage(
                            imageUrl: track.media.thumbnail,
                            height: 30,
                            width: 30,
                          ),
                        )
                      : SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
