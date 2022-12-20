import 'package:flutter_rekord_app/models/User.dart';
import 'package:flutter_rekord_app/providers/BaseProvider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider extends BaseProvider {
  bool isLoaded = true;

  Future<void> updateUser(Map<String, dynamic> formData) async {
    isLoaded = false;
    notifyListeners();

    final response = await post('user/update', formData);

    final Map<String, dynamic> jsonMap = json.decode(response.body);
    print(jsonMap);
    isLoaded = true;
    notifyListeners();
    if (response.statusCode == 200) {
      final _prefs = await SharedPreferences.getInstance();
      var user = User.fromJson(response);
      _prefs.setString('user', jsonEncode(user));
      isLoaded = true;
      notifyListeners();
    } else if (response.statusCode == 400) {}

    return response;
  }
}
