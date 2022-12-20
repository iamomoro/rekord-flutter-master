import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/providers/PlayerProvider.dart';
import 'package:provider/provider.dart';

class TrackPlayButton extends StatelessWidget {
  final Function onPressed;

  final Track track;
  final Album album;
  final int index;

  TrackPlayButton({this.onPressed, this.track, this.album, this.index});

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<PlayerProvider>(context, listen: false);

    return PlayerBuilder.isPlaying(
        player: p.player,
        builder: (context, isPlaying) {
          return SizedBox(
            height: 40,
            width: 40,
            child: !p.isTrackLoaded && p.tIndex == index
                ? Padding(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                    padding: EdgeInsets.all(10))
                : IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: p.isTrackInProgress(track) ||
                            p.isLocalTrackInProgress(track.localPath)
                        ? Icon(AntDesign.pausecircleo)
                        : Icon(
                            SimpleLineIcons.control_play,
                          ),
                    onPressed: () => onPressed != null
                        ? onPressed()
                        : p.handlePlayButton(
                            album: album,
                            track: track,
                            index: index,
                            //search results list
                          )),
          );
        });
  }
}
