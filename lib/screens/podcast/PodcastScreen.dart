import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/providers/PodcastProvider.dart';
import 'package:flutter_rekord_app/screens/album/SearchScreen.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseConnectivity.dart';
import 'package:flutter_rekord_app/widgtes/Common/BasePagination.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseScaffold.dart';
import 'package:flutter_rekord_app/widgtes/track/TrackTile.dart';
import 'package:provider/provider.dart';

class PodcastScreen extends StatelessWidget with BaseMixins {
  final ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    PodcastProvider p = Provider.of<PodcastProvider>(context);
    Album album =
        new Album(null, $t(context, 'podcasts'), null, null, p.podcasts);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Podcasts',
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen(),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BaseConnectivity(
          child: BaseScaffold(
            isLoaded: p.isLoaded,
            child: BasePagination(
              scrollController: scrollController,
              method: p.fetchPodcasts,
              loading: p.isLoadingMoreInProgress,
              child: ListView.builder(
                controller: scrollController,
                itemCount: p.podcasts.length,
                itemBuilder: (context, index) {
                  return TrackTile(
                    track: p.podcasts[index],
                    index: index,
                    album: album,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
