import 'package:flutter/cupertino.dart';

class User {
  String id;
  String name;
  String email;
  String username;
  String phone;
  String password;
  String occupation;
  String interst;
  String country;
  String state;
  String profile;

  Map<String, String> toMap() {
    return {
      'username': name != null ? '$name' : null,
      'email': email != null ? '$email' : null,
      'phone': phone != null ? '$phone' : null,
      'password': password != null ? '$password' : null,
      'occupation': occupation != null ? '$occupation' : null,
      'interestedin': interst != null ? '$interst' : null,
      'country': country != null ? '$country' : null,
      'state': state != null ? '$state' : null,
      'avatar': profile != null ? '$profile' : null,
    };
  }
}
