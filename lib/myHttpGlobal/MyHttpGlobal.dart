import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIRequest {
  Dio dio = new Dio();
  Future get({
    @required String myUrl,
    token,
  }) {
    if(token == null){
    return dio.get(myUrl);
    }else{
    return dio.get(myUrl, options: new Options(headers: {'token': '$token'}));
    }

  }

  Future post({
    @required String myUrl,
    @required Map<String, String> myBody,
    @required Map<String, String> myHeaders,
  }) {
    dio.options.headers = myHeaders;
    return dio.post(myUrl, data: myBody);
  }

  Future put({
    @required String myUrl,
    @required Map<String, String> myBody,
    @required Map<String, String> myHeaders,
  }) {

     dio.options.headers = myHeaders;
    return dio.put(myUrl, data: myBody);
  }
}
