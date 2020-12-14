import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/users.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart' as fi;

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class Auth with ChangeNotifier {
  Dio dio = new Dio();

  String token;
  Map userDataField;
  User currentUser = new User();

  // AuthMethods authMethods = new AuthMethods();

  Future<bool> isAuth() async {
    await tryAutoLogin();
    return token != null ? true : false;
  }

  Future registerUser({User user}) async {
    try {
      final String url = "$baseUrl/user/signup";
      print(url);
      print(user.toMap());

      var response = await dio.post(url, data: user.toMap());
      final responseData = response.data;
      // authMethods
      //     .signUpWithEmailAndPassword(user.email, user.password)
      //     .then((value) {
      //   print("Mahdi I am Firebase SignUp: $value");
      // }).catchError((e) {
      //   print("Mahdi I am Firebase SignUp: $e");
      // });

      var prefs = await SharedPreferences.getInstance();

      currentUser = user;
      userDataField = {
        'token': responseData['token'],
        'username': user.name,
        'country': user.country,
        'phone': user.phone,
        'email': user.email,
        'password': user.password,
        'profile': user.profile != null ? user.profile : "",
      };
      var userData = json.encode(userDataField);
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
    currentUser.name = extractedUserData['username'];
    currentUser.email = extractedUserData['email'];
    currentUser.profile = extractedUserData['profile'];

    notifyListeners();
    return true;
  }

  Future<String> getToken() async {
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
    final url = '$baseUrl/user/login';

    try {
      final response = await dio.post(url, data: {
        'email': username,
        'password': password,
      });

      // authMethods.signInWithEmailAndPassword(username, password).then((value) {
      //   print("Mahdi I am Firebase SignIn: $value");
      // }).catchError((e) {
      //   print("Mahdi I am Firebase SignIn: $e");
      // });

      final responseData = response.data;

      print(responseData);
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
          'profile': responseData['data']['avatar'],
        },
      );

      currentUser.name = responseData['data']['username'];
      currentUser.email = responseData['data']['email'];
      currentUser.country = responseData['data']['country'];
      currentUser.profile = responseData['data']['avatar'];

      prefs.setString('userData', userData);
      notifyListeners();
    } on DioError catch (e) {
      if (e.response == null) {
        return null;
      }

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
      var result =
          await dio.post(url, data: {"newpassword": password, "keycode": code});
    } on DioError catch (e) {
      if (e.response.data['message'] != null) {
        throw new LoginException(e.response.data['message']);
      }
    }
  }

  Future<bool> loginWithGmail(fi.User result) async {
    String email = result.email;
    print(result.uid);
    final url = '$BASE_URL/user/exits';
    try {
      Response result = await dio.post(url, data: {"email": email});
      return result.data;
    } on DioError catch (e) {
      if (e.response.data['message'] != null) {
        throw new LoginException(e.response.data['message']);
      }
    }
    // print(result);
  }

  loginWithFaceBook(fi.User result) {
    String email = result.email;
    print(result.uid);
  }

  Future<Map> uploadFile(File imageFile, String category) async {
    final StringBuffer url = new StringBuffer(BASE_URL + "/upload");
    Dio dio = new Dio();

    print(await MultipartFile.fromFile(imageFile.path));

    try {
      FormData formData = FormData.fromMap(
        {
          "uploadFile": await MultipartFile.fromFile(imageFile.path),
          "token": UNTOKEN,
          "category": category
        },
      );

      print(url.toString());
      var response = await dio.post(
        url.toString(),
        data: formData,
      );

      print("UploadResponse: ${response.data}");

      if (response.data['status']) {
        // var respon = response.data["data"]["name"];
        return response.data['data'];
      } else {
        throw UploadException(response.data["message"]);
      }
    } on DioError catch (e) {
      print("errors");
      print(e.response);
      // throw UploadException(e.response.data["message"]);
    }
  }

  Future getDataSignup() async {
    final StringBuffer url = new StringBuffer(BASE_URL + "/public/categories");
    Dio dio = new Dio();
    print(url.toString());
    try {
      Response inter = await dio
          .get(url.toString(), queryParameters: {"type": "interested"});

      print(inter.data);
      Response locat =
          await dio.get(url.toString(), queryParameters: {"type": "location"});
      List state = await getDataState(locat.data[0]['name']);

      return Future.value([inter.data, locat.data, state]);
    } on DioError catch (e) {
      print("errors");
      print(e.response);
      // throw UploadException(e.response.data["message"]);
    }
  }

  Future getDataState(parent) async {
    final StringBuffer url = new StringBuffer(BASE_URL + "/public/categories");
    Dio dio = new Dio();

    try {
      print({"type": "location", "parent": parent});
      Response state = await dio.get(url.toString(),
          queryParameters: {"type": "location", "parent": parent});

      return state.data;
    } on DioError catch (e) {
      print("errors");
      print(e.response);
      // throw UploadException(e.response.data["message"]);
    }
  }

  Future<String> loginFirebase(String idToken) async {
    final url = '$baseUrl/user/loginFirebase';

    try {
      dio.options.headers = {"firebaseToken": idToken};
      final response = await dio.post(url);

      // authMethods.signInWithEmailAndPassword(username, password).then((value) {
      //   print("Mahdi I am Firebase SignIn: $value");
      // }).catchError((e) {
      //   print("Mahdi I am Firebase SignIn: $e");
      // });

      final responseData = response.data;
      print("response firebase $responseData");
      if (responseData['message'] != null) {
        return "NEW_USER";
      } else {
        var prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': responseData['token'],
            'username': responseData['data']['username'],
            'id': responseData['data']['_id'],
            'country': responseData['data']['country'],
            'phone': responseData['data']['phone'],
            'email': responseData['data'],
            'password': "abcd123",
            'profile': responseData['data']['avatar'],
          },
        );
        token = responseData['token'];
        currentUser.name = responseData['data']['username'];
        currentUser.email = responseData['data']['email'];
        currentUser.country = responseData['data']['country'];
        currentUser.profile = responseData['data']['avatar'];

        prefs.setString('userData', userData);
        notifyListeners();
        return "EXITS";
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return null;
      }

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

  Future registerFirebaseUser({User user, String idToken}) async {
    try {
      final String url = "$baseUrl/user/signupFirebase";
      dio.options.headers = {"firebaseToken": idToken};

      print("user data ${user.toMap()}");
      var response = await dio.post(url, data: user.toMap());
      final responseData = response.data;

      var prefs = await SharedPreferences.getInstance();

      currentUser = user;
      userDataField = {
        'token': responseData['token'],
        'username': user.name,
        'country': user.country,
        'phone': user.phone,
        'email': user.email,
        'password': user.password,
        'profile': user.profile != null ? user.profile : "",
      };
      var userData = json.encode(userDataField);
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
}

class LoginException implements Exception {
  String cause;

  LoginException(this.cause);
}

class UploadException implements Exception {
  String cause;

  UploadException(this.cause);
}
