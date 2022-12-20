import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/providers/PlayerProvider.dart';
import 'package:flutter_rekord_app/widgtes/Album/AlbumFavouriteButton.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseConnectivity.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';

import 'package:flutter_rekord_app/widgtes/track/TrackTile.dart';
import 'package:provider/provider.dart';

class AlbumDetailScreen extends StatefulWidget {
  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> with BaseMixins {
  double heightScreen;
  double paddingBottom;
  double width;

  _buildContent(Album album, var playerProvider) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BaseImage(
            imageUrl: album.media.large,
            height: heightScreen,
            width: width,
            radius: 0,
            overlay: true,
            overlayOpacity: 0.1,
            overlayStops: [0.3, 0.8],
          ),
          Positioned(
            top: heightScreen / 4.5,
            width: width,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          album.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        AlbumFavouriteButton(
                          iconSize: 25.0,
                          album: album,
                        ),
                      ],
                    ),
                    // if (album.content != null)
                    //   Container(
                    //     width: width,
                    //     margin: EdgeInsets.only(top: 10, bottom: 20),
                    //     child: ExpandableText(album.content,
                    //         style: TextStyle(
                    //             color: Theme.of(context).colorScheme.primary,
                    //             height: 1.5,
                    //             fontSize: 12),
                    //         expandText: $t(context, 'show_more'),
                    //         collapseText: $t(
                    //           context,
                    //           'show_less',
                    //         ),
                    //         maxLines: 4,
                    //         linkColor: Theme.of(context).primaryColor),
                    //   ),
                    PlayerBuilder.isPlaying(
                      player: playerProvider.player,
                      builder: (context, isPlaying) {
                        return new FlatButton.icon(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          icon: Icon(
                            isPlaying &&
                                    album.id == playerProvider.currentAlbum.id
                                ? SimpleLineIcons.control_pause
                                : SimpleLineIcons.control_play,
                            size: 12,
                          ),
                          label: new Text(
                            $t(context, 'play_tracks'),
                          ),
                          onPressed: () {
                            playerProvider.handlePlayButton(
                                album: album, track: album.tracks[0], index: 0);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                )),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    heightScreen = mediaQueryData.size.height;
    paddingBottom = mediaQueryData.padding.bottom;
    width = mediaQueryData.size.width;

    Album album = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: BaseConnectivity(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: heightScreen / 2.0,
              pinned: true,
              floating: false,
              elevation: 1,
              snap: false,
              actions: <Widget>[],
              flexibleSpace: new FlexibleSpaceBar(
                background: _buildContent(album, playerProvider),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TrackTile(
                    track: album.tracks[index],
                    index: index,
                    album: album,
                  );
                },
                childCount: album.tracks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
