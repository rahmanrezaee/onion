import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/models/requestFranchiesModel.dart';
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

  Future<bool> deleteFranchies({
    String id,
  }) async {
    try {
      final StringBuffer url = new StringBuffer("$BASE_URL/franchies/$id");

      dio.options.headers = {
        "token": auth.token,
      };
      final response = await dio.delete(url.toString());

      items.removeWhere((element) {
        return element.id == id;
      });

      notifyListeners();
    } catch (e) {
      print("Mahdi Error $e");
    }
  }

  Future<bool> addFranchise(data) async {
    print("data add $data");
    try {
      final StringBuffer url = new StringBuffer("$BASE_URL/franchies/add");
      print(url.toString());
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

  Future<bool> editFranchise(FranchiesModel data) async {
    print(data);
    try {
      final StringBuffer url =
          new StringBuffer("$BASE_URL/franchies/${data.id}");

      dio.options.headers = {
        "token": auth.token,
      };
      final response = await dio.post(url.toString(), data: data.sendMap());

      items.removeWhere((element) {
        return element.id == data.id;
      });

      items.add(data);

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

  Future<bool> getFranchies({isMyList}) async {
    try {
      String url = "$BASE_URL/franchies/list";

      if (isMyList != null && isMyList) {
        url = url.toString() + "?list=my";
      }
      print(url.toString());
      dio.options.headers = {
        "token": auth.token,
      };
      final result = await dio.get(url.toString());

      print("Mahdi an $result");
      final extractedData = result.data["franchiesList"];
      print("fran $extractedData");
      if (extractedData == null) {
        items = [];
        return false;
      }
      final List<FranchiesModel> loadedProducts = [];

      extractedData.forEach((tableData) {
        loadedProducts.add(FranchiesModel.toJson(tableData));
      });

      items = loadedProducts;

      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("Mahdi: Error ${e.response}");
    }
  }

  Future<bool> addFranchiseRequest(data) async {
    print("data request add $data");
    try {
      final StringBuffer url = new StringBuffer("$BASE_URL/franchies/request");
      print(url.toString());
      dio.options.headers = {
        "token": auth.token,
      };
      final response = await dio.post(url.toString(), data: data);

      final extractedData = response.data["data"];

      // items.add(FranchiesModel.toJson(extractedData));

      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("Mahdi Error: ${e.response}");
    }
  }

  Future<List<RequestFranchiesModel>> getReqestedFrenchies(String id) async {
    try {
      final StringBuffer url =
          new StringBuffer("$BASE_URL/franchies/$id?requests=true");
      print(url.toString());
      dio.options.headers = {
        "token": auth.token,
      };
      final response = await dio.get(url.toString());

      final extractedData = response.data["requestsData"];
      print("extractedData $extractedData");
      final List<RequestFranchiesModel> loadedProducts = [];

      extractedData.forEach((tableData) {
        loadedProducts.add(RequestFranchiesModel.toJson(tableData));
      });

      return Future.value(loadedProducts);
      // return true;
    } on DioError catch (e) {
      print("Mahdi Error: ${e.response}");
    }
  }
}
