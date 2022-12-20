/*
 * AppRoutes
 * 
 * Define all routes for our app. We can access route
 * name as [AppRoutes.myRouteName]  anywhere in our app
 * Add or remove routes according to your requiremnts
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/screens/Artist/ArtistDetailScreen.dart';
import 'package:flutter_rekord_app/screens/Artist/ArtistsScreen.dart';
import 'package:flutter_rekord_app/screens/Auth/ConfirmationScreen.dart';
import 'package:flutter_rekord_app/screens/Auth/LoginScreen.dart';
import 'package:flutter_rekord_app/screens/Auth/ProfileEditScreen.dart';
import 'package:flutter_rekord_app/screens/Auth/RegisterScreen.dart';
import 'package:flutter_rekord_app/screens/DownloadScreen.dart';
import 'package:flutter_rekord_app/screens/HomeScreen.dart';
import 'package:flutter_rekord_app/screens/album/AlbumDetailScreen.dart';
import 'package:flutter_rekord_app/screens/album/AlbumsScreen.dart';
import 'package:flutter_rekord_app/screens/PlayerScreen.dart';
import 'package:flutter_rekord_app/screens/post/PostDetailsScreen.dart';
import 'package:flutter_rekord_app/screens/post/PostsScreen.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseAuthCheck.dart';

class AppRoutes {
  static const home = '/home';
  static const albums = '/albums';
  static const albumDetail = '/album';
  static const post = '/post';
  static const posts = '/posts';
  static const podcasts = '/podcasts';
  static const artists = '/artists';
  static const artist = '/artist';
  static const player = '/player';
  static const loginRoute = '/loginRoute';
  static const registerRoute = '/registerRoute';
  static const profileEditRoute = '/profileEditRoute';
  static const confirmScreenRoute = '/confirmScreenRoute';
  static const downloadScreenRoute = '/downloadScreenRoute';

  Map<String, WidgetBuilder> routes() {
    return {
      home: (context) => HomeScreen(),
      albums: (context) => AlbumsScreen(),
      albumDetail: (context) => AlbumDetailScreen(),
      player: (context) => PlayerScreen(),
      artists: (context) => ArtistsScreen(),
      artist: (context) => ArtistDetailScreen(),
      post: (context) => PostDetailsScreen(),
      posts: (context) => PostsScreen(),
      loginRoute: (context) => BaseAuthCheck(
            redirect: HomeScreen(),
            child: LoginScreen(),
          ),
      registerRoute: (context) => BaseAuthCheck(
            redirect: HomeScreen(),
            child: RegisterScreen(),
          ),
      profileEditRoute: (context) => ProfileEditPage(),
      confirmScreenRoute: (context) => ConfirmationScreen(),
      downloadScreenRoute: (context) => DownloadScreen()
    };
  }
}
