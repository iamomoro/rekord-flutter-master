import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/providers/TrackProvider.dart';
import 'package:flutter_rekord_app/widgtes/common/CustomCircularProgressIndicator.dart';
import 'package:flutter_rekord_app/widgtes/Search/BaseMessageScreen.dart';

import 'package:flutter_rekord_app/widgtes/Search/SearchBox.dart';
import 'package:flutter_rekord_app/widgtes/track/TrackTile.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with BaseMixins {
  String searchKeyword;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TrackProvider trackProvider = Provider.of<TrackProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SearchBox(
                onSearch: (s) {
                  setState(() {
                    searchKeyword = s;
                  });
                  if (s.length > 2) trackProvider.searchData(s);
                },
              ),
              Expanded(
                flex: 2,
                child: trackProvider.isLoaded
                    ? trackProvider.tracks.length == 0
                        ? BaseMessageScreen(
                            title: searchKeyword == null
                                ? $t(context, 'search_screen_title')
                                : $t(context, 'search_screen_title_not_found'),
                            subtitle: $t(context, 'search_screen_subtitle'),
                            icon: Icons.search,
                          )
                        : ListView.builder(
                            itemCount: trackProvider.tracks.length,
                            itemBuilder: (context, index) {
                              Album album = new Album(null, 'Search', null,
                                  null, trackProvider.tracks);
                              return TrackTile(
                                track: trackProvider.tracks[index],
                                index: index,
                                album: album,
                              );
                            })
                    : CustomCircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
