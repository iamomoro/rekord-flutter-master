import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/providers/AlbumProvider.dart';
import 'package:flutter_rekord_app/widgtes/Album/AlbumTile.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseConnectivity.dart';
import 'package:flutter_rekord_app/widgtes/Common/BasePagination.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseScaffold.dart';
import 'package:provider/provider.dart';

class AlbumsScreen extends StatelessWidget with BaseMixins {
  final ScrollController scrollController = new ScrollController();

  _buildGridItem(BuildContext context, Album album) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.albumDetail,
            arguments: album,
          );
        },
        child: AlbumTile(album: album),
      );

  @override
  Widget build(BuildContext context) {
    AlbumProvider p = Provider.of<AlbumProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BaseConnectivity(
          child: BaseScaffold(
              isLoaded: p.isLoaded,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: BasePagination(
                  scrollController: scrollController,
                  method: p.fetchAlbums,
                  loading: p.isLoadingMoreInProgress,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: p.albums.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: responsive(context,
                            isSmallPhone: 2, isPhone: 2, isTablet: 4),
                        childAspectRatio: responsive(context,
                            isPhone: 0.8, isSmallPhone: 0.8, isTablet: 0.6)),
                    itemBuilder: (context, index) {
                      return _buildGridItem(context, p.albums[index]);
                    },
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
