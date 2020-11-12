import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';

import './CategoryProvider.dart';

class AnalyticsProvider with ChangeNotifier {
  List<CategoryModel> _items = [];

  
  List<CategoryModel> get items {
    return _items;
  }

  Future<void> fetchItems({@required String name}) async {
    try {
      final response =
          await APIRequest().get(myUrl: "$baseDropDownItemsUrl$name");
      print("Mahdi: $response");

      final extractedData = response.data;

      // final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      final List<CategoryModel> loadedProducts = [];
      // print("Mahdi: title $extractedData");

      // loadedProducts.add(extractedData.forEach());

      extractedData.forEach((netItems) {
        loadedProducts.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      print("Mahdi Error $e");
    }
  }

  void clearData() {
    _items = [];
    notifyListeners();
  }
}
