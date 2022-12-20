import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/providers/FavoriteProvider.dart';
import 'package:flutter_rekord_app/widgtes/Artist/AlbumsList.dart';
import 'package:flutter_rekord_app/widgtes/Common/CustomCircularProgressIndicator.dart';
import 'package:flutter_rekord_app/widgtes/Search/BaseMessageScreen.dart';
import 'package:flutter_rekord_app/widgtes/track/TrackTile.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget with BaseMixins {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text($t(context, 'fvrt')),
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              tabs: [
                Tab(
                  child: Text(
                    $t(context, 'tracks'),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Tab(
                  child: Text(
                    $t(context, 'albums'),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Tab(
                  child: Text(
                    $t(context, 'podcasts'),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TabBarView(
                children: [
                  TrackContainer(
                      favoriteProvider: favoriteProvider, type: 'track'),
                  AlbumsList(albums: favoriteProvider.favoriteAlbums),
                  TrackContainer(
                      favoriteProvider: favoriteProvider, type: 'podcast'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class TrackContainer extends StatelessWidget with BaseMixins {
  const TrackContainer({
    Key key,
    @required this.favoriteProvider,
    this.type,
  }) : super(key: key);

  final FavoriteProvider favoriteProvider;
  final String type;

  @override
  Widget build(BuildContext context) {
    return favoriteProvider.favoriteTracks.length > 0
        ? favoriteProvider.isLoaded
            ? ListView.builder(
                itemCount: favoriteProvider.favoriteTracks.length,
                itemBuilder: (context, index) {
                  Album album = new Album(null, $t(context, 'fvrt'), null, null,
                      favoriteProvider.favoriteTracks);
                  var postType = album.tracks[index].postType ?? 'track';
                  return postType == type
                      ? TrackTile(
                          track: album.tracks[index],
                          index: index,
                          album: album,
                        )
                      : Container();
                },
              )
            : CustomCircularProgressIndicator()
        : BaseMessageScreen(
            title: $t(context, 'no_tracks'),
            icon: Icons.data_usage,
            subtitle: $t(context, 'msg_no_tracks'),
          );
  }
}
