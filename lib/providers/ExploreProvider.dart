import 'package:flutter/cupertino.dart';
import 'package:flutter_rekord_app/config/AppConfig.dart';

import 'dart:convert';

import 'package:flutter_rekord_app/models/RekordWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExploreProvider extends ChangeNotifier {
  ExploreProvider() {
    fetchData();
  }
  List<RekordWidget> _widgets = <RekordWidget>[];
  List<RekordWidget> get widgets => _widgets;

  bool isLoaded = false;

  fetchData() async {
    isLoaded = false;
    notifyListeners();

    String url = AppConfig.API_URL + '/explore';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      List<dynamic> jsonItems = jsonMap["data"];

      jsonItems.forEach((item) {
        var newItem = new RekordWidget.fromJson(item);
        _widgets.add(newItem);
      });
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }

    isLoaded = true;
    notifyListeners();
  }
}
