import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:onion/statemanagment/auth_provider.dart';

class SaveAnalModel {
  final String id;
  final String title;
  final String category;
  final String region;
  final String industry;

  SaveAnalModel({
    this.id,
    this.title,
    this.region,
    this.category,
    this.industry,
  });
}

class SaveAnalProvider extends ChangeNotifier {
  List<SaveAnalModel> _items = [];
  Auth auth;
  SaveAnalProvider(this.auth);

  List<SaveAnalModel> get items {
    return _items;
  }

  Future<void> deleteAnalysis({
    String id,
  }) async {
    try {
      final response = await APIRequest().post(
        myUrl: "$deleteAnalysisUrl?id=$id",
        myBody: null,
        myHeaders: {"token": this.auth.token},
      );
      print("MLenght: ${_items.length}");
      _items.removeWhere((element) {
        print("Mmahdi: ${element.id} == $id");
        return element.id == id;
      });
      print("MLenght: ${_items.length}");

      notifyListeners();
      print("Mahdi Deleted: $response");
    } catch (e) {
      print("Mahdi Error $e");
    }
  }

  Future<bool> saveAnalysis(analysisId, region) async {
    try {
      print("token ${auth.token}");
      final response = await APIRequest().post(
        myUrl: saveAnalysisUrl,
        myBody: {
          "analysisId": analysisId,
          "region": region,
        },
        myHeaders: {
          "token": auth.token,
          "Content-Type": "application/json",
        },
      );

      final extractedData = response.data["data"];
      print(extractedData);
      _items.add(SaveAnalModel(
        id: extractedData['_id'],
        region: extractedData['region'],
        title: extractedData['analysisData']['title'],
        category: extractedData['analysisData']['category'],
        industry: extractedData['analysisData']['industry'],
      ));

      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("Mahdi Error: ${e.response}");
    }
  }

  Future<bool> getAnalysis() async {
    try {
      final result =
          await APIRequest().get(myUrl: myAnalysisUrl, token: auth.token);

      print("Mahdi an $result");
      final extractedData = result.data;
      if (extractedData == null) {
        return false;
      }
      final List<SaveAnalModel> loadedProducts = [];

      extractedData.forEach((tableData) {
        loadedProducts.add(SaveAnalModel(
          id: tableData['_id'],
          region: tableData['region'],
          title: tableData['analysisData']['title'],
          category: tableData['analysisData']['category'],
          industry: tableData['analysisData']['industry'],
        ));
      });

      _items = loadedProducts;
      
      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("Mahdi: Error ${e.response}");
    }
  }
}
