import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import '../../const/MyUrl.dart';
import '../../myHttpGlobal/MyHttpGlobal.dart';
import './CategoryProvider.dart';

class IndustryProvider with ChangeNotifier {
  List<CategoryModel> _items = [];
  String dropDownFilter;
  AnalyticsProvider analyticsProvider;
  bool isLoading = true;

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
      final response = await APIRequest()
          .get(myUrl: "$baseDropDownItemsUrl?type=category&parent=$name");
      print("Mahdi: $response");

      final extractedData = response.data;

      if (extractedData == null) {
        _items = [];
        return;
      }
      final List<CategoryModel> loadedProducts = [];

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
      isLoading = false;

      notifyListeners();
      Provider.of<AnalyticsProvider>(context, listen: false).clearDate();
      await Provider.of<AnalyticsProvider>(context, listen: false).fetchItems(
        name: _items[0].name,
        context: context,
      );
      // print("Mahdi: ${_items[1].name}: 5h");
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
