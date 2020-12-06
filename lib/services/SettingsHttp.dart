import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SettingsHttp {
  Future getDefaultSettings(token) async {
    print("token $token");
    Response result =  await APIRequest().get(myUrl: "$baseUrl/user/me", token: token);

    print("$baseUrl/user/me");
    return result.data['settings'] != null && result.data['settings'].length > 0
        ? result.data['settings']
        : null;
  }

  Future setSettings(
      {@required sms,
      @required email,
      @required profileType,
      @required update,
      @required website,
      @required token}) async {
    try {

       print("token $token");
      Response response =
          await APIRequest().post(myUrl: "$baseUrl/user/settings", myBody: {
        "sms": sms.toString(),
        "email": email.toString(),
        "profile_type": profileType.toString(),
        "update": update.toString(),
        "website": website.toString()
      }, myHeaders: {
        "token": "$token"
      });
      print("Response: ${response.data}");
    } on DioError catch (e) {
      print("errors");
      print(e.response.data["message"]);
    }
  }
}
