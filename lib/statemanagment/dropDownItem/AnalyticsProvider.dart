import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';

import './CategoryProvider.dart';

class AnalyticsProvider with ChangeNotifier {
  List<CategoryModel> _items = [];
  String dropDownFilter;

  boolDropDownFilter(String nameParam) {
    dropDownFilter = nameParam;
  }

  
  List<CategoryModel> get items {
    return _items;
  }

  CategoryModel get firstItem {
    if (_items.isNotEmpty) {
      notifyListeners();
      return _items[0];
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> fetchItems({@required String name, BuildContext context}) async {
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

  void clearDate() {
    _items = [];
    notifyListeners();
  }
}
