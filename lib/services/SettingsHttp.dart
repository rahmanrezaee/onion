import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
class SettingsHttp {
  getDefaultSettings(token) async {
    Response result = await APIRequest().get(myUrl: "$baseUrl/user/me", token: token);
    print("me: ${result.data}");
    return result.data;
  }
  Future setSettings({@required sms,@required email,@required profileType,@required update,@required website,@required token}) async {
    print("This is SMS " + sms.toString());
    Response response = await APIRequest().post(myUrl: "$baseUrl/user/settings", myBody: {
    "sms": sms.toString(),
    "email": email.toString(),
    "profile_type": profileType.toString(),
    "update": update.toString(),
    "website": website.toString()
    }, myHeaders: {"token": "$token"});
    print("Response: ${response.data}");
  }
}
