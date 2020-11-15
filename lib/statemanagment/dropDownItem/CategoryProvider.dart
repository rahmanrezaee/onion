import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:onion/statemanagment/dropDownItem/IndustryProvider.dart';
import 'package:provider/provider.dart';

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

  updateIndustryItem(String name, BuildContext context) {
    // CategoryModel categoryModel = _items.firstWhere((element) => element.name == name);
    industryProvider = Provider.of<IndustryProvider>(context, listen: false);
    print("Mahdi: test $name");

    // industryProvider.clearDate();
    industryProvider.fetchItems(name: name, context: context);
    notifyListeners();
  }

  boolDropDownFilter(String nameParam) {
    dropDownFilter = nameParam;
  }

  List<CategoryModel> get items {
    return _items;
  }

  CategoryModel filterItems({String id}) {
    return _items.firstWhere((element) => element.id == id);
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

  Future<void> fetchItems(BuildContext context) async {
    try {
      // final response = await http.get("${baseDropDownItemsUrl}0");
      final response =
          await APIRequest().get(myUrl: "${baseDropDownItemsUrl}0");
      // print("Mahdi: ${response.body}");

      final extractedData = response.data;
      if (extractedData == null) {
        return;
      }
      final List<CategoryModel> loadedProducts = [];
      print("Mahdi: title $extractedData");

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
      Provider.of<IndustryProvider>(context, listen: false).fetchItems(
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
