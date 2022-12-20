import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Post.dart';
import 'package:flutter_rekord_app/providers/PostProvider.dart';
import 'package:flutter_rekord_app/screens/post/partials/AuthorTile.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseConnectivity.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';
import 'package:flutter_rekord_app/widgtes/Common/BasePagination.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseScaffold.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatelessWidget with BaseMixins {
  final ScrollController scrollController = new ScrollController();

  _buildGridItem(BuildContext context, Post post) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.post,
            arguments: post,
          );
        },
        child: Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthorTile(post: post),
                  if (post.media != null)
                    BaseImage(
                      imageUrl: post.media.medium,
                      radius: 0,
                      height: 200,
                      // heroId: item.id.toString(),
                    ),
                  ListTile(
                      title: Text(post.title, style: TextStyle(height: 1.5)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.comment, size: 10),
                          SizedBox(width: 5),
                          Text(
                            '${post.commentCount} Comments',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    PostProvider p = Provider.of<PostProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Posts'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: BaseConnectivity(
          child: BaseScaffold(
            isLoaded: p.isLoaded,
            child: BasePagination(
              scrollController: scrollController,
              method: p.fetchposts,
              loading: p.isLoadingMoreInProgress,
              child: ListView.builder(
                shrinkWrap: false,
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: p.posts.length,
                itemBuilder: (context, index) {
                  return _buildGridItem(context, p.posts[index]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
