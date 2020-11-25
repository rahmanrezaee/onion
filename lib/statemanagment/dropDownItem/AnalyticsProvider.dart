import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

import './CategoryProvider.dart';

// "regions": [
// "United Arab Emirates",
// "United States of America",
// "United Kingdom",
// "Uruguay",
// "Uzbekistan",
// "Tunisia",
// "Afghanistan",
// "Albania",
// "Antigua and Barbuda",
// "Armenia",
// "Bangladesh",
// "Barbados",
// "Canada",
// "Colombia",
// "Denmark",
// "Democratic Republic of the Congo",
// "Malawi",
// "Malaysia"
// ],
// "_id": "5fbce5bcdf6d199878f648c2",
// "title": "Covid-19",
// "category": "Public and Society",
// "industry": "Health and Medical"

class AnalyticsModel {
  final String id;
  final String title;
  final String category;
  final String industry;
  final List<dynamic> regions;

  AnalyticsModel({
    this.id,
    this.title,
    this.category,
    this.industry,
    this.regions,
  });
}

class AnalyticsProvider with ChangeNotifier {
  List<AnalyticsModel> _items = [];
  String dropDownFilter;
  bool isLoading = true;
  String tempItem;
  bool _myBigDropSelected = false;
  List<CountryDensityModel> _countryItems = [];

  List<CountryDensityModel> get countryItems {
    return _countryItems;
  }

  get myBigDropSelected {
    return _myBigDropSelected;
  }

  String selectSingle({String name}) {
    _myBigDropSelected = true;
    List<CountryDensityModel> temp = [];
    for (int i = 0; i < _countryItems.length; i++) {
      if (_countryItems[i].countryName == name) {
        temp.add(
          CountryDensityModel("${_countryItems[i].countryName}", 26337),
        );
        tempItem = _countryItems[i].countryName;
      } else {
        temp.add(
          CountryDensityModel("${_countryItems[i].countryName}", 10),
        );
      }
    }
    _countryItems = [];
    _countryItems = temp;
    notifyListeners();
  }

  void setCountryItems({String title}) {
    _countryItems.clear();
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].title == title) {
        _items[i].regions.forEach(
            (e) => _countryItems.add(CountryDensityModel(e.toString(), 26337)));
      }
    }
    print(" Mahdi M$_countryItems");
    notifyListeners();
  }

  boolDropDownFilter(String nameParam) {
    dropDownFilter = nameParam;
  }

  List<AnalyticsModel> get items {
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
      String catName =
          Provider.of<CategoryProvider>(context, listen: false).catName;

      final response = await APIRequest()
          .get(myUrl: "$getAnalysis?category=$catName&industry=$name");
      print("Mahdi: $response");

      final extractedData = response.data;

      // final extractedData = json.decode(response.body);
      if (extractedData == null) {
        _items = [];
        return;
      }
      final List<AnalyticsModel> loadedProducts = [];
      // print("Mahdi: title $extractedData");

      // loadedProducts.add(extractedData.forEach());

      extractedData.forEach((netItems) {
        loadedProducts.add(
          AnalyticsModel(
            id: netItems['_id'],
            title: netItems['title'],
            category: netItems['category'],
            industry: netItems['industry'],
            regions: netItems['regions'],
          ),
        );
      });

      print("Mahdi: List ${loadedProducts[0].regions}");

      // print("Mahdi: title ${loadedProducts[0].name}");

      // for (int i = 1; i < 6; i++) {
      //   loadedProducts.add(CategoryModel(id: i, val: extractedData['$i']));
      // }
      isLoading = false;
      _items = loadedProducts;
      print("Mahdi: ListL ${loadedProducts[0].regions}");
      loadedProducts[0].regions.forEach(
            (e) => _countryItems.add(
              CountryDensityModel(e.toString(), 26337),
            ),
          );
      print("Mahdi: ListL $_countryItems");

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
