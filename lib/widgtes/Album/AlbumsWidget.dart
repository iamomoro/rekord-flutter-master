import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/providers/PlayerProvider.dart';
import 'package:flutter_rekord_app/widgtes/Common/WidgetHeader.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';
import 'package:provider/provider.dart';

class AlbumsWidget extends StatelessWidget {
  final List<Album> albums;
  final String title;
  AlbumsWidget({this.title, this.albums});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetHeader(title: title, route: AppRoutes.albums),
        Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albums.length,
              itemBuilder: (context, index) {
                Album album = albums[index];

                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      var playerProvider =
                          Provider.of<PlayerProvider>(context, listen: false);

                      playerProvider.currentAlbum = album;

                      Navigator.of(context).pushNamed(
                        AppRoutes.albumDetail,
                        arguments: album,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseImage(
                          imageUrl: album.media.thumbnail,
                          height: 100,
                          width: 100,
                          radius: 5,
                        ),
                        //  albumCard(album.media.thumbnail, 100, 100),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${album.title}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }
}
