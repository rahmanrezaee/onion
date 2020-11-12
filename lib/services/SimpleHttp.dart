import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';

class SimpleHttp{
  getFandQ()async{
    Response result = await APIRequest().get(myUrl: "$baseUrl/faqs");
    return result.data;
  }
  getTandC()async{
    Response result = await APIRequest().get(myUrl: "$baseUrl/public/pages/tandc");
    return result.data;
  }
}