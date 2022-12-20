import 'dart:convert';

import 'package:flutter_rekord_app/models/User.dart';
import 'package:flutter_rekord_app/providers/BaseProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider extends BaseProvider {
  //Constructor
  AuthProvider() {
    autoAuthenticate();
  }

  // Items List

  bool isLoaded = false;
  bool _isLoggedIn = false;
  bool inputerror = false;
  String errorMsg;
  bool check = true;

  bool get isLoggedIn => _isLoggedIn;

  User _user;
  User get user => _user;

  /*
  * Sign in Wiht Email
  * Add your http code here and save user profile.
  */
  Future<String> singInWithEmail(Map<String, dynamic> formData) async {
    check = false;
    notifyListeners();
    String error;

    final response = await post('auth', formData);

    final Map<String, dynamic> jsonMap = json.decode(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(jsonMap['data']['jwt']);

      _saveToken(jsonMap['data']);

      setUser(decodedToken['user']);
    }
    //check server side validation
    else if (response.statusCode == 400) {
      error = jsonMap['data']['message'];
    }
    //Todo: Validation error is different on email or password change..
    else if (response.statusCode == 422 || response.statusCode == 401) {
      jsonMap['errors'].forEach((key, value) {
        jsonMap['errors'][key] = value;

        error = value[0]; //string interpolation in action
      });
    }

    check = true;
    notifyListeners();

    return error;
  }

  _saveToken(response) async {
    final _prefs = await SharedPreferences.getInstance();
    if (response.containsKey('jwt')) {
      _prefs.setString('token', response['jwt']);
    }
  }

  setUser(response) async {
    final _prefs = await SharedPreferences.getInstance();
    var user = User.fromJson(response);
    _prefs.setString('user', jsonEncode(user));
    autoAuthenticate();
  }

/*
 * Auth Authenticate
 *
 * Auto authentication help to get user data from shared preferences
 * and save as user user object. which can be access anywhere
 * in the app.
 * 
 * please check page-user-account.dart for example
 * 
 */

  Future autoAuthenticate() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    String prefUser = _prefs.getString('user');
    if (prefUser != null) {
      Map userMap = jsonDecode(prefUser);
      _user = User.fromJson(userMap);
    }

    if (_user != null) {
      _isLoggedIn = true;
    }
    isLoaded = true;

    notifyListeners();
  }

  /*
  * Logout
  *
  * Clear user preference & user
  */
  void logout() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _user = null;
    _prefs.clear();
    _isLoggedIn = false;
    notifyListeners();
  }

  /*
  * Sign Up With Email
  * Add your http code here and save user profile.
  */
  Future<String> singUpWithEmail(Map<String, dynamic> formData) async {
    isLoaded = false;
    notifyListeners();
    String error;

    final response = await post('users', formData);
    final Map<String, dynamic> jsonMap = json.decode(response.body);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {
      error = jsonMap['data']['message'];
    }
    //Todo: Validation error is different on email or password change..
    else if (response.statusCode == 422 || response.statusCode == 401) {
      jsonMap['errors'].forEach((key, value) {
        jsonMap['errors'][key] = value;

        error = value[0]; //string interpolation in action
      });
    }

    isLoaded = true;
    notifyListeners();
    return error;
  }
}
