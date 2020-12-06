import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/statemanagment/auth_provider.dart';

class FranchiesProvider with ChangeNotifier {
  List<FranchiesModel> _items;

  Dio dio = new Dio();
  Auth auth;
  FranchiesProvider(this.auth);

  List<FranchiesModel> get items {
    return _items != null ? _items : null;
  }

  // Future<void> deleteAnalysis({
  //   String id,
  // }) async {
  //   try {
  //     final response = await dio.post(

  //       myBody: null,
  //       myHeaders: {"token": this.auth.token},
  //     );
  //     print("MLenght: ${_items.length}");
  //     _items.removeWhere((element) {
  //       print("Mmahdi: ${element.id} == $id");
  //       return element.id == id;
  //     });
  //     print("MLenght: ${_items.length}");

  //     notifyListeners();
  //     print("Mahdi Deleted: $response");
  //   } catch (e) {
  //     print("Mahdi Error $e");
  //   }
  // }

  // Future<bool> saveAnalysis(analysisId, region) async {
  //   try {
  //     print("token ${auth.token}");
  //     final response = await APIRequest().post(
  //       myUrl: saveAnalysisUrl,
  //       myBody: {
  //         "analysisId": analysisId,
  //         "region": region,
  //       },
  //       myHeaders: {
  //         "token": auth.token,
  //         "Content-Type": "application/json",
  //       },
  //     );

  //     final extractedData = response.data["data"];
  //     print(extractedData);
  //     _items.add(SaveAnalModel(
  //       id: extractedData['_id'],
  //       region: extractedData['region'],
  //       title: extractedData['analysisData']['title'],
  //       category: extractedData['analysisData']['category'],
  //       industry: extractedData['analysisData']['industry'],
  //     ));

  //     notifyListeners();
  //     return true;
  //   } on DioError catch (e) {
  //     print("Mahdi Error: ${e.response}");
  //   }
  // }

  // bool isDeprecated = false;

  // void isDerecatedOrNot(country) {
  //   isDeprecated = false;
  //   notifyListeners();
  //   if (_items.isNotEmpty) {
  //     _items.forEach((element) {
  //       if (element.region == country) {
  //         isDeprecated = true;
  //       }
  //     });
  //   } else {
  //     isDeprecated = false;
  //   }

  //   notifyListeners();
  // }

  Future<bool> getFranchies() async {
    try {
      final StringBuffer url = new StringBuffer("$BASE_URL/franchies/list");

      dio.options.headers = {
        "token": auth.token,
      };
      final result = await dio.get(url.toString());

      print("Mahdi an $result");
      final extractedData = result.data;
      if (extractedData == null) {
        _items = [];
        return false;
      }
      final List<FranchiesModel> loadedProducts = [];

      extractedData.forEach((tableData) {
        loadedProducts.add(FranchiesModel.toJson(tableData));
      });

      _items = loadedProducts;

      notifyListeners();
      return true;
    } on DioError catch (e) {

      print("Mahdi: Error ${e.response}");
      
    }
  }
}
