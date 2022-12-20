import 'package:flutter_rekord_app/config/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider extends ChangeNotifier {
  bool isServerDown = false;

  String token;
  bool isLoaded = false;
  bool isLoadingMoreInProgress = false;

  int _total = 0;
  int get total => _total;

  String url;

  getToken() async {
    final _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
  }

  Future<List> fetch(route, params) async {
    var url =
        Uri.http(AppConfig.API_BASE, '${AppConfig.API_PATH}/$route/', params);
    print(url);
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      List<dynamic> jsonItems = jsonMap["data"];
      if (jsonItems.length == 0) {
        isLoadingMoreInProgress = false;
        isLoaded = true;
        notifyListeners();
        return [];
      }
      return jsonItems;
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future post(route, formData) async {
    await getToken();
    if (token != null) formData['jwt'] = token;
    formData['AUTH_KEY'] = AppConfig.API_AUTH_KEY;
    return await http.post(Uri.parse('${AppConfig.API_URL}/$route/'),
        body: formData,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).catchError((e) {
      print(e);
    });
  }
}
