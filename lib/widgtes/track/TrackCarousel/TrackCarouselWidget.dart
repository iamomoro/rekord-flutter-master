import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseOverlay.dart';
import 'package:flutter_rekord_app/widgtes/track/TrackCarousel/TrackCarouselTile.dart';

class TrackCarouselWidget extends StatefulWidget {
  final List<Track> tracks;
  final title;
  TrackCarouselWidget({this.tracks, this.title});

  @override
  _TrackCarouselWidgetState createState() => _TrackCarouselWidgetState();
}

class _TrackCarouselWidgetState extends State<TrackCarouselWidget> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int currentImage;

  _buildSliderItem(Track track, index, tracks) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(),
            child: BaseOverlay(
              child: track.media != null
                  ? BaseImage(
                      radius: 3,
                      overlay: false,
                      imageUrl: track.media.cover != null
                          ? track.media.cover
                          : track.media.thumbnail,
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.surface,
                    ),
            )),
        SizedBox(height: 30),
        TrackCarouselTile(
          track: track,
          tracks: tracks,
          index: index,
          title: widget.title,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: false,
            initialPage: 0,
            height: 178,
            onPageChanged: (index, reason) {
              setState(() {
                currentImage = index;
              });
            },
          ),
          itemCount: widget.tracks.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
              Container(
            child: _buildSliderItem(widget.tracks[index], index, widget.tracks),
          ),
        ),

        //indicators

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: map<Widget>(widget.tracks, (index, track) {
            return Container(
              width: currentImage == index ? 40 : 20.0,
              height: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentImage == index
                    ? Theme.of(context).primaryColor
                    : Colors.blueGrey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
