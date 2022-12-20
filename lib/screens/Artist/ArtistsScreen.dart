import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/providers/ArtistProvider.dart';
import 'package:flutter_rekord_app/widgtes/Artist/ArtistCardForScreen.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseAppBar.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseScreenHeading.dart';
import 'package:flutter_rekord_app/widgtes/Common/CustomCircularProgressIndicator.dart';
import 'package:provider/provider.dart';

class ArtistsScreen extends StatelessWidget with BaseMixins {
  const ArtistsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var artistProvider = Provider.of<ArtistProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: BaseAppBar(),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseScreenHeading(title: $t(context, 'artists')),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: artistProvider.isLoaded
                    ? ListView.builder(
                        itemCount: artistProvider.artists.length,
                        itemBuilder: (context, index) {
                          return ArtistCard(
                            index: index,
                            artist: artistProvider.artists[index],
                          );
                        },
                      )
                    : CustomCircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
