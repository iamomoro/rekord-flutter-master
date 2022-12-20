import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/screens/Auth/UserAccountPage.dart';
import 'package:flutter_rekord_app/screens/Favourites/FavouritesScreen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/screens/podcast/PodcastScreen.dart';
import 'album/AlbumsScreen.dart';
import 'ExploreScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).colorScheme.surface,
        child: TabBar(
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontSize: 12),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon: Icon(Octicons.telescope),
              ),
              Tab(
                icon: Icon(SimpleLineIcons.book_open),
              ),
              Tab(
                icon: Icon(Zocial.podcast),
              ),
              Tab(
                icon: Icon(AntDesign.hearto),
              ),
              Tab(
                icon: Icon(Octicons.settings),
              ),
            ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  ExploreScreen(),
                  AlbumsScreen(),
                  PodcastScreen(),
                  FavouritesScreen(),
                  UserAccountPage(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
