import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/models/Post.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';

class AuthorTile extends StatelessWidget {
  final Post post;
  const AuthorTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(children: [
        BaseImage(
          height: 35,
          width: 35,
          radius: 50,
          imageUrl: post.author.avatar,
        ),
        SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '${post.author.firstName}',
          ),
          SizedBox(height: 3),
          Text(
            '${post.date}',
            style: TextStyle(fontSize: 10),
          )
        ]),
      ]),
    );
  }
}
