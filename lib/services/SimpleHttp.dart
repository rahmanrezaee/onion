import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';

class SimpleHttp{
  getFandQ()async{
    Response result = await APIRequest().get(myUrl: "$baseUrl/faqs");

  
    print(result.data);
    return result.data;
  }
}