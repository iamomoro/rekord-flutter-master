import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rekord_app/models/RekordWidget.dart';
import 'package:flutter_rekord_app/providers/ExploreProvider.dart';
import 'package:flutter_rekord_app/widgtes/Album/AlbumsWidget.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseAppBar.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseConnectivity.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseScaffold.dart';
import 'package:flutter_rekord_app/widgtes/Artist/ArtistCarousel/ArtistWidget.dart';
import 'package:flutter_rekord_app/widgtes/track/TrackCarousel/TrackCarouselWidget.dart';

import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    ExploreProvider e = Provider.of<ExploreProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: BaseAppBar(
            title: 'REKORD',
          ),
        ),
        body: BaseConnectivity(
          child: BaseScaffold(
            isLoaded: e.isLoaded,
            // scrollController: scrollController,
            child: ListView.builder(
              controller: scrollController,
              itemCount: e.widgets.length,
              itemBuilder: (context, index) {
                RekordWidget widget = e.widgets[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.type == "album")
                        AlbumsWidget(
                          title: widget.title,
                          albums: widget.albums,
                        ),
                      if (widget.type == "track")
                        TrackCarouselWidget(
                            title: widget.title, tracks: widget.tracks),
                      if (widget.type == "artist")
                        ArtistWidget(
                          title: widget.title,
                          artists: widget.artists,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
