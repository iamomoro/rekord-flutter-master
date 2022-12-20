import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Post.dart';
import 'package:flutter_rekord_app/screens/post/partials/AuthorTile.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseConnectivity.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseImage.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PostDetailsScreen extends StatefulWidget {
  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> with BaseMixins {
  double heightScreen;
  double paddingBottom;
  double width;

  _buildContent(Post post) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BaseImage(
            imageUrl: post.media.large,
            height: heightScreen,
            width: width,
            radius: 0,
            overlay: true,
            overlayOpacity: 0.1,
            overlayStops: [0.3, 0.8],
          ),
          Positioned(
            top: heightScreen / 3.5,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                AuthorTile(post: post),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          post.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    heightScreen = mediaQueryData.size.height;
    paddingBottom = mediaQueryData.padding.bottom;
    width = mediaQueryData.size.width;

    Post post = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: BaseConnectivity(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: heightScreen / 2.0,
              pinned: true,
              floating: false,
              elevation: 1,
              snap: false,
              actions: <Widget>[],
              flexibleSpace: new FlexibleSpaceBar(
                background: _buildContent(post),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: HtmlWidget(
                      post.content,
                      textStyle: TextStyle(
                          fontSize: 12,
                          height: 1.7,
                          color: Colors.grey.shade300),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
