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
  bool isLoading = true;

  boolDropDownFilter(String nameParam) {
    dropDownFilter = nameParam;
  }

  List<CategoryModel> get items {
    return _items;
  }

  // CategoryModel get firstItem {
  //   if (_items.isNotEmpty) {
  //     notifyListeners();
  //     return _items[0];
  //   } else {
  //     notifyListeners();
  //     return null;
  //   }
  // }

  Future<void> fetchItems({@required String name, BuildContext context}) async {
    try {
      isLoading = true;
      final response = await APIRequest().get(
        myUrl: "$baseDropDownItemsUrl?type=category&parent=$name",
        token: null,
      );
      print("Mahdi: $response");

      final extractedData = response.data;

      // final extractedData = json.decode(response.body);
      if (extractedData == null) {
        _items = [];
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

      // print("Mahdi: title ${loadedProducts[0].name}");

      // for (int i = 1; i < 6; i++) {
      //   loadedProducts.add(CategoryModel(id: i, val: extractedData['$i']));
      // }
      isLoading = false;
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      _items = [];
      notifyListeners();
      print("Mahdi Error $e");
    }
  }

  void clearDate() {
    _items = [];
    notifyListeners();
  }
}
