import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';

class IdeasServices {
  Future<bool> setupIdea(Map data, String token) async {
    try {
      Response response = await APIRequest().post(
          myUrl: "$baseUrl/innovator/idea/addsetup",
          myBody: data,
          myHeaders: {"token": "$token"});
      print("Response: ${response.data}");
      return response.data['status'];
    } on DioError catch (e) {
      print("res error ${e.response}");
    }
  }

  Future<bool> postIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/add",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("Response: ${response.data}");
    return response.data['status'];
  }
}
