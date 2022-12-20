import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/providers/PlayerProvider.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'TrackPlayButton.dart';

class TrackBottomBar extends StatefulWidget {
  TrackBottomBar({Key key}) : super(key: key);

  @override
  _TrackBottomBarState createState() => _TrackBottomBarState();
}

class _TrackBottomBarState extends State<TrackBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlayerProvider playerProvider =
        Provider.of<PlayerProvider>(context, listen: false);
    Track track;
    return PlayerBuilder.realtimePlayingInfos(
      player: playerProvider.player,
      builder: (context, infos) {
        track = playerProvider.currentTrack;

        return track != null
            ? GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.player),
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                                animation: _controller,
                                builder: (_, child) {
                                  double _angle = _controller.value * 2 * pi;
                                  if (!playerProvider.isPlaying()) {
                                    _angle = 0.0;
                                  }

                                  return Transform.rotate(
                                    angle: _angle,
                                    child:
                                        playerProvider.getTrackThumbnail != null
                                            ? BaseImage(
                                                imageUrl: playerProvider
                                                    .getTrackThumbnail(),
                                                width: 30,
                                                height: 30,
                                                radius: 100,
                                              )
                                            : Icon(
                                                Icons.disc_full,
                                                size: 30,
                                              ),
                                  );
                                }),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(track.title,
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(height: 5),
                                Text(
                                  track.artist[0].name,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(SimpleLineIcons.control_rewind),
                                  iconSize: 20,
                                  color: playerProvider.isFirstTrack()
                                      ? Theme.of(context).iconTheme.color
                                      : Theme.of(context).primaryColor,
                                  onPressed: () {
                                    playerProvider.prev();
                                  },
                                ),
                                TrackPlayButton(
                                  track: track,
                                  onPressed: () => playerProvider.playOrPause(),
                                ),
                                IconButton(
                                  icon: Icon(SimpleLineIcons.control_forward),
                                  color: playerProvider.isLastTrack(
                                          playerProvider.currentIndex + 1)
                                      ? Theme.of(context).iconTheme.color
                                      : Theme.of(context).primaryColor,
                                  iconSize: 20,
                                  onPressed: () {
                                    if (playerProvider.isLastTrack(
                                        playerProvider.currentIndex + 1))
                                      return;
                                    playerProvider.next();
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (infos != null)
                        LinearProgressIndicator(
                          minHeight: 1,
                          value: !playerProvider.isPlaying()
                              ? 0.0
                              : infos.currentPosition.inMilliseconds /
                                  infos.duration.inMilliseconds,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                    ], // ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
