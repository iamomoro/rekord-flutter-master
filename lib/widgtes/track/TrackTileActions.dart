import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/providers/DownloadProvider.dart';
import 'package:flutter_rekord_app/screens/Track/TrackDetailsScreen.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

class TrackTileActions extends StatelessWidget with BaseMixins {
  final bool isRemove;
  final Track track;
  final String title;

  final Widget child;
  TrackTileActions({
    Key key,
    this.child,
    this.isRemove,
    this.title,
    this.track,
  });

  @override
  Widget build(BuildContext context) {
    DownloadProvider downloadProvider = Provider.of<DownloadProvider>(context);
    GlobalConfiguration cfg = new GlobalConfiguration();

    return PopupMenuButton<String>(
      child: child,
      onSelected: (String value) {
        if (value == 'details') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  TrackDetailsScreen(track: track),
            ),
          );
        }
        if (value == 'download') {
          downloadProvider.downloadAudio(track, context);
        }
        if (value == 'remove') {
          downloadProvider.removeSong(track);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'details',
          child: Text('$title'),
        ),
        cfg.getValue("allowDownload")
            ? downloadProvider.isDownloadSong(track)
                ? PopupMenuItem<String>(
                    value: 'remove',
                    child: Text($t(context, 'remove')),
                  )
                : PopupMenuItem<String>(
                    value: 'download',
                    child: Text($t(context, 'downloading')),
                  )
            : null
      ],
    );
  }
}
