import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';

class TrackDetailsScreen extends StatelessWidget {
  final Track track;
  const TrackDetailsScreen({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(track.title),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              leading: track.media != null
                  ? BaseImage(
                      imageUrl: track.media.thumbnail,
                      height: 50,
                      width: 50,
                      radius: 5,
                    )
                  : Icon(
                      Icons.library_music,
                      size: 36,
                    ),
              subtitle: Text(track.artist[0].name),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                track.content,
                style: TextStyle(height: 1.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
