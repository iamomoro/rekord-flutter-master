import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Artist.dart';
import 'package:flutter_rekord_app/widgtes/Artist/AlbumsList.dart';
import 'package:flutter_rekord_app/widgtes/Artist/TrakTileForArtist.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';

class ArtistDetailScreen extends StatelessWidget with BaseMixins {
  final Artist artist;
  const ArtistDetailScreen({this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                BaseImage(
                  overlay: false,
                  heroId: artist.id,
                  imageUrl: artist.media.thumbnail,
                  height: 60,
                  width: 60,
                  radius: 50,
                ),
                SizedBox(height: 10),
                Text(
                  '${artist.name}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  '${artist.designation}',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 30),
                TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 2.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(fontSize: 12),
                  unselectedLabelColor: Colors.grey,
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
                        $t(context, 'about'),
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
                        TrakTileForArtist(artist: artist),
                        AlbumsList(albums: artist.albums),
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            artist.content,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
