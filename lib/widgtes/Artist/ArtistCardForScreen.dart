import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Artist.dart';

import 'package:flutter_rekord_app/screens/Artist/ArtistDetailScreen.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';

class ArtistCard extends StatelessWidget {
  final int index;
  final Artist artist;
  ArtistCard({this.index, this.artist});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArtistDetailScreen(
                          artist: artist,
                        )));
          },
          title: Text(
            artist.name,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          subtitle: Text(
            artist.designation,
            style:
                TextStyle(color: Theme.of(context).colorScheme.primaryVariant),
          ),
          leading: BaseImage(
            heroId: artist.id,
            imageUrl: artist.media.thumbnail,
            height: 60,
            width: 60,
            radius: 50,
          ),
          trailing: DropdownButton<String>(
            underline: Text(''),
            icon: Icon(Icons.more_vert),
            items: <String>['View Artist'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          )),
    );
  }
}
