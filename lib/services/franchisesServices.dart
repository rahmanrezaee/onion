import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';

class FranchisesServices {
  Future<bool> addFranchise(Map data, String token) async {
    Response response = await APIRequest().post(
      myUrl: "$baseUrl/franchies/add",
      myBody: data,
      myHeaders: {"token": "$token"},
    );
    print("Response: ${response.data}");
    return response.data['status'];
  }
}
