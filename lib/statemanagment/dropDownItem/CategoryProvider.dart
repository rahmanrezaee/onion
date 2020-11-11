import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';

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

  List<CategoryModel> get items {
    return _items;
  }

  List<CategoryModel> filterItems({String parentName}) {
    return _items.where((element) => element.parent == parentName).toList();
  }

  Future<void> fetchItems() async {
    try {
      // final response = await http.get(testUrl);
      final response = await APIRequest().get(myUrl: "${baseDropDownItemsUrl}0");
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      final List<CategoryModel> loadedProducts = [];
      print("Mahdi: title $extractedData");
      //
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
      notifyListeners();
      // print("Mahdi: ${_items[1].name}: 5h");
    } catch (e) {
      print("Mahdi Error $e");
    }
  }
}
