import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';

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

  List<SaveAnalModel> get items {
    return _items;
  }

  Future<void> deleteAnalysis({
    String token,
    String id,
  }) async {
    print("Mahdi Clicked $token");
    print("Mahdi Clicked $id");
    try {
      final response = await APIRequest().post(
        myUrl: "$deleteAnalysisUrl?id=$id",
        myBody: null,
        myHeaders: {"token": token},
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

  Future<void> saveAnalysis({
    String token,
    String analysisId,
    String region,
  }) async {
    try {
      print("Mahdi Clicked $token");
      print("Mahdi Clicked $analysisId");
      print("Mahdi Clicked $region");
      final response = await http.post(
        saveAnalysisUrl,
        body: json.encode({
          "analysisId": analysisId,
          "region": region,
        }),
        headers: {
          "token": token,
          "Content-Type": "application/json",
        },
      );
      final extractedData = json.decode(response.body);
      print("$extractedData");
    } catch (e) {
      print("Mahdi Error: $e");
    }
  }

  Future<void> getAnalysis({String token}) async {
    print("Mahdi: an $token");
    try {
      final result = await APIRequest()
          .get(myUrl: "http://3.138.186.196:3000/analysis/list", token: token);

      print("Mahdi an $result");
      final extractedData = result.data;
      if (extractedData == null) {
        return null;
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
      print("Mahdi: $_items");
      print("Mahdi: ${_items[0].title}");

      notifyListeners();
    } catch (e) {
      print("Mahdi: Error $e");
    }
  }
}