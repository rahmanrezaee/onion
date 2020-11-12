import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/models/users.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class Auth with ChangeNotifier {
  Dio dio = new Dio();

  String token;

  Future<bool> isAuth() async {
    await tryAutoLogin();
    return token != null ? true : false;
  }

  Future registerUser({User user}) async {
    try {
      final String url = "$baseUrl/user/signup";
      print(url);
      print(user.toMap());

      final response = await dio.post(url, data: user.toMap());
      final responseData = response.data;

      var prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': responseData['token'],
          'username': user.name,
          'country': user.country,
          'phone': user.phone,
          'email': user.email,
          'password': user.password,
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } on DioError catch (e) {
      if (e.response.data['errors'] != null) {
        print("error occure 1");

        return e.response.data['errors'][0]["msg"];
      }

      if (e.response.data['msg'] != null) {
        print("error occure 2");
        return e.response.data['msg'];
      }
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userData') == null) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    token = extractedUserData['token'];
    notifyListeners();
    return true;
  }

  Future<String> getToken() async {
    // final prefs = await SharedPreferences.getInstance();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('userData') == null) {
      return Future.value(null);
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    final token = extractedUserData['token'];
    return Future.value(token);
  }

  Future<void> _authenticate(String username, String password) async {
    final url = '${baseUrl}/user/login';

    try {
      final response = await dio.post(url, data: {
        'email': username,
        'password': password,
      });

      final responseData = response.data;
      print("responseData ${response.data}");
      var prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': responseData['token'],
          'username': responseData['data']['username'],
          'id': responseData['data']['_id'],
          'country': responseData['data']['country'],
          'phone': responseData['data']['phone'],
          'email': username,
          'password': password,
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } on DioError catch (e) {
      if (e.response.data['errors'] != null) {
        throw new LoginException(e.response.data['errors'][0]["msg"]);
      }
      if (e.response.data['message'] != null) {
        throw new LoginException(e.response.data['message']);
      }

      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }

  Future login(String username, String password) async {
    return _authenticate(username, password);
  }

  Future<bool> tryGetToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userData') == null) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    await login(extractedUserData['username'], extractedUserData['password']);
    return true;
  }

  Future<void> logout() async {
    token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future forgetPassword(String email) async {
    final url = '$baseUrl/user/forgetpassword';

    try {
      final response = await dio.post(url, data: {
        'email': email,
      });

      print(response);
      return response.data;
    } on DioError catch (e) {
      if (e.response.data['message'] != null) {
        throw new LoginException(e.response.data['message']);
      }
    }
  }

  Future changePassword({String email, String password, String code}) async {
    final url = '$baseUrl/user/changepasswordwithKey';
    try {
      var result = await dio.post(url, data: {"newpassword": password, "keycode": code});
      
    } on DioError catch (e) {
      if (e.response.data['message'] != null) {
        throw new LoginException(e.response.data['message']);
      }
    }
  }
}

class LoginException implements Exception {
  String cause;
  LoginException(this.cause);
}
