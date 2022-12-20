import 'package:flutter_rekord_app/providers/AlbumProvider.dart';
import 'package:flutter_rekord_app/providers/ArtistProvider.dart';
import 'package:flutter_rekord_app/providers/AuthProvider.dart';
import 'package:flutter_rekord_app/providers/DownloadProvider.dart';
import 'package:flutter_rekord_app/providers/ExploreProvider.dart';
import 'package:flutter_rekord_app/providers/PodcastProvider.dart';
import 'package:flutter_rekord_app/providers/PostProvider.dart';
import 'package:flutter_rekord_app/providers/TrackProvider.dart';
import 'package:flutter_rekord_app/providers/UsersProvider.dart';
import 'package:flutter_rekord_app/providers/ThemeProvider.dart';
import 'package:flutter_rekord_app/providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_rekord_app/providers/PlayerProvider.dart';

/*
 *  Providers
 * 
 *  List of provider that we want to init on app start
 *  you can add or remove provider according to your 
 *  requirments. Or you can use provider on any build
 *  widget. Please check providers docs for more details
 *   
 *  https://pub.dev/packages/provider
 */

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider<PlayerProvider>(
      create: (_) => PlayerProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<AlbumProvider>(
      create: (context) => AlbumProvider(),
    ),
    ChangeNotifierProvider<TrackProvider>(
      create: (context) => TrackProvider(),
    ),
    ChangeNotifierProvider<ExploreProvider>(
      create: (context) => ExploreProvider(),
    ),
    ChangeNotifierProvider<ArtistProvider>(
      create: (context) => ArtistProvider(),
    ),
    ChangeNotifierProvider<UsersProvider>(
      create: (context) => UsersProvider(),
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(),
    ),
    ChangeNotifierProvider<DownloadProvider>(
      create: (context) => DownloadProvider(),
    ),
    ChangeNotifierProvider<PodcastProvider>(
      create: (context) => PodcastProvider(),
    ),
    ChangeNotifierProvider<PostProvider>(
      create: (context) => PostProvider(),
    ),
  ];
}
