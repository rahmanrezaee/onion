import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './IndustryProvider.dart';
import '../../const/MyUrl.dart';
import '../../myHttpGlobal/MyHttpGlobal.dart';

class CategoryModel {
  final String id;
  final String name;
  final String createdAt;
  final String parent;

  CategoryModel({
    this.id,
    this.name,
    this.createdAt,
    this.parent,
  });
}

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _items = [];
  String dropDownFilter;
  IndustryProvider industryProvider;
  bool isLoading = true;
  String _catName;

  get catName {
    return _catName;
  }

  void setCatName(String catName) {
    _catName = catName;
    notifyListeners();
  }

  bool catIsLoading() {
    return isLoading;
  }

  List<CategoryModel> get items {
    return _items;
  }

  Future<void> fetchItems(BuildContext context) async {
    try {
      // final response = await http.get("${baseDropDownItemsUrl}0");
      isLoading = false;

      final response = await APIRequest().get(
        myUrl: "$baseDropDownItemsUrl?type=category",
        token: null,
      );
      // final response = await http.get(
      //   "http://3.138.186.196:3000/public/categories/?type=category",
      // );
      print("Mahdi: ${response.data}");

      final extractedData = response.data;
      if (extractedData == null) {
        _items = [];
        return;
      }
      final List<CategoryModel> loadedProducts = [];
      print("Mahdi: title $extractedData");

      final lastExtract = extractedData;

      // loadedProducts.add(extractedData.forEach());

      lastExtract.forEach((netItems) {
        loadedProducts.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });

      _items = [];
      _items = loadedProducts;
      isLoading = true;
      notifyListeners();

      await Provider.of<IndustryProvider>(context, listen: false).fetchItems(
        name: _items[0].name,
        context: context,
      );
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
// updateIndustryItem(String name, BuildContext context) {
//   // CategoryModel categoryModel = _items.firstWhere((element) => element.name == name);
//   industryProvider = Provider.of<IndustryProvider>(context, listen: false);
//
//   // industryProvider.clearDate();
//   industryProvider.fetchItems(name: name, context: context);
//   notifyListeners();
// }

// boolDropDownFilter(String nameParam) {
//   dropDownFilter = nameParam;
// }
// CategoryModel filterItems({String id}) {
//   return _items.firstWhere((element) => element.id == id);
// }

// CategoryModel get firstItem {
//   if (_items.isNotEmpty) {
//     notifyListeners();
//     return _items[0];
//   } else {
//     notifyListeners();
//     return null;
//   }
// }


// for (int i = 1; i < 6; i++) {
//   loadedProducts.add(CategoryModel(id: i, val: extractedData['$i']));
// }
