import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/statemanagment/auth_provider.dart';

class FranchiesProvider with ChangeNotifier {
  List<FranchiesModel> items;

  Dio dio = new Dio();
  Auth auth;
  FranchiesProvider(this.auth);

  void clearToNullList() {
    items = null;
    notifyListeners();
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

  Future<bool> addFranchise(data, region) async {
    print(data);
    try {
      final StringBuffer url = new StringBuffer("$BASE_URL/franchies/add");

      dio.options.headers = {
        "token": auth.token,
      };
      final response = await dio.post(url.toString(), data: data);

      final extractedData = response.data["data"];
      print(extractedData);
      items.add(FranchiesModel.toJson(extractedData));

      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("Mahdi Error: ${e.response}");
    }
  }

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
      final extractedData = result.data["franchiesList"];
      if (extractedData == null) {
        items = [];
        return false;
      }
      final List<FranchiesModel> loadedProducts = [];

      extractedData.forEach((tableData) {
        loadedProducts.add(FranchiesModel.toJson(tableData));
      });

      print("fran $loadedProducts");

      items = loadedProducts;

      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("Mahdi: Error ${e.response}");
    }
  }
}
