import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class IdeasServices {
  Future getIdeaList(String token) async {
    Response response = await APIRequest().get(
      myUrl: "$baseUrl/innovator/idea/list",
      token: token,
    );
    print("Response: ${response.data}");
    return response.data;
  }

  Future<bool> setupIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/addsetup",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("Response: ${response.data['status']}");
    return response.data['status'];
  }

  Future<bool> postIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/add",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("This is the response: ${response.data}");
    return response.data['status'];
  }

  Future deleteIdea(String ideaId, String token) async {
    Response response = await APIRequest().delete(
        myUrl: "$baseUrl/innovator/idea/ideaid/$ideaId",
        myBody: null,
        myHeaders: {"token": "$token"});
    print("This is the response: ${response.data}");
    return response.data["status"];
  }
}
