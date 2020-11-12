import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:provider/provider.dart';

import '../../const/MyUrl.dart';
import '../../myHttpGlobal/MyHttpGlobal.dart';
import './CategoryProvider.dart';

class IndustryProvider with ChangeNotifier {
  List<CategoryModel> _items = [];
  String dropDownFilter;
  AnalyticsProvider analyticsProvider;

  boolDropDownFilter(String nameParam) {
    dropDownFilter = nameParam;
  }

  updateIndustryItem(String name, BuildContext context) {
    CategoryModel categoryModel =
        _items.firstWhere((element) => element.name == name);
    analyticsProvider.clearDate();
    analyticsProvider.fetchItems(
      name: categoryModel.name,
      context: context,
    );
    notifyListeners();
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

      // print("Mahdi: title ${loadedProducts[0].name}");

      // for (int i = 1; i < 6; i++) {
      //   loadedProducts.add(CategoryModel(id: i, val: extractedData['$i']));
      // }

      _items = loadedProducts;
      Provider.of<AnalyticsProvider>(context, listen: false).fetchItems(
        name: _items[0].name,
        context: context,
      );
      notifyListeners();
      // print("Mahdi: ${_items[1].name}: 5h");
    } catch (e) {
      print("Mahdi Error $e");
    }
  }

  void clearDate() {
    _items = [];
    notifyListeners();
  }
}