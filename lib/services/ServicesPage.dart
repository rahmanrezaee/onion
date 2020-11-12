import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';

class ServicesHttp{
  getSliders()async{
    Response result = await APIRequest().get(myUrl: "$baseUrl/public/services");
    List<String> imageList = [];
    print("the real image list ${result.data}");
    result.data.forEach((e){
      print(e);
      imageList.add(e["image"]);
    });
    print("image list $imageList");
    return imageList;
  }
  Future getServicesList() async {
    Response result = await APIRequest().get(myUrl: "$baseUrl/public/services");
    return result.data;
  }
  getTrendingIdeas(){

  }
}