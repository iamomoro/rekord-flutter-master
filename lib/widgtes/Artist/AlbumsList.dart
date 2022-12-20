import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/widgtes/Album/AlbumFavouriteButton.dart';
import 'package:flutter_rekord_app/widgtes/Album/AlbumTileActions.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';
import 'package:flutter_rekord_app/widgtes/Search/BaseMessageScreen.dart';

class AlbumsList extends StatelessWidget with BaseMixins {
  final List<Album> albums;
  const AlbumsList({
    Key key,
    @required this.albums,
  }) : super(key: key);

  _buildTile(BuildContext context, Album album) => Column(children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.albumDetail,
              arguments: album,
            );
          },
          title: Text(
            album.title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          subtitle: Text(
            ' ${album.tracks.length}  ${$t(context, 'tracks')} ',
            style:
                TextStyle(color: Theme.of(context).colorScheme.primaryVariant),
          ),
          leading: BaseImage(
            heroId: album.id,
            imageUrl: album.media.thumbnail,
            height: 40,
            width: 40,
            radius: 5.0,
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AlbumFavouriteButton(
                album: album,
              ),
              AlbumTileActions(
                album: album,
                // route: () {
                //   Navigator.of(context).pushNamed(
                //     AppRoutes.albumDetail,
                //     arguments: album,
                //   );
                // },
                title: 'View tracks',
                child: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor,
                ),
              )
              // IconButton(
              //     icon: Icon(
              //       Icons.more_vert,
              //       color: Theme.of(context).primaryColor,
              //     ),
              //     onPressed: () => {}),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).cardColor,
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: albums.length > 0
                ? ListView.builder(
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return _buildTile(context, albums[index]);
                    },
                  )
                : BaseMessageScreen(
                    title: $t(context, 'no_albums'),
                    icon: Icons.data_usage,
                    subtitle: $t(context, 'msg_no_albums'),
                  ),
          ),
        ),
      ],
    );
  }
}
