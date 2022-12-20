import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double radius;
  final int heroId;
  final bool overlay;
  final List<double> overlayStops;
  final double overlayOpacity;
  BaseImage(
      {this.imageUrl,
      this.height,
      this.width,
      this.radius,
      this.heroId,
      overlay,
      overlayStops,
      overlayOpacity})
      : overlay = overlay ?? false,
        overlayStops = overlayStops ?? [0.1, 0.5],
        overlayOpacity = overlayOpacity ?? 0.2;

  _buildOverlay(BuildContext context) => Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Theme.of(context)
                  .scaffoldBackgroundColor
                  .withOpacity(overlayOpacity),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            stops: overlayStops,
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
          ),
        ),
      );

  _buildImage() => CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fitHeight,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(radius == null ? 5 : radius)),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        width: width,
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => Image.asset('assets/you.jpg'),
      );

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null)
      return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(radius == null ? 5 : radius)),
            color: Theme.of(context).primaryColor,
          ));
    return overlay
        ? Stack(
            children: [
              _buildImage(),
              _buildOverlay(context),
            ],
          )
        : _buildImage();
  }
}
