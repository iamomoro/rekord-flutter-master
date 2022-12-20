import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rekord_app/config/AppConfig.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:http/http.dart' as http;

class TrackProvider extends ChangeNotifier {
  String keyword;
  List<Track> _tracks = <Track>[];
  List<dynamic> jsonItems;

  List<Track> get tracks => _tracks;

  Album searchPlaylist;
  bool isLoaded = true;
  bool isLoadedSearch = false;

  Offset offset;
  setOffset(Offset v) {
    offset = v;
    notifyListeners();
  }

  searchData(s) async {
    isLoaded = false;
    notifyListeners();

    String url = AppConfig.API_URL + '/tracks?q=$s';

    clearList();

    http.Response response = await http.get(Uri.parse(url)).whenComplete(() {
      isLoadedSearch = false;
      notifyListeners();
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      jsonItems = jsonMap["data"];

      jsonItems.forEach((item) {
        var newItem = new Track.fromJson(item);
        _tracks.add(newItem);
      });
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }

    isLoaded = true;
    notifyListeners();
  }

  setTitle(q) {
    tracks.clear();
    searchData(q);

    notifyListeners();
  }

  clearList() {
    tracks.clear();
    notifyListeners();
  }
}
