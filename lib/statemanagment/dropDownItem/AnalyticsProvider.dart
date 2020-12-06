import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/models/CountryDensityModel.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:onion/statemanagment/dropDownItem/BigDropDownPro.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

import './CategoryProvider.dart';

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
  bool _myBigDropSelected = false;
  List<CountryDensityModel> _countryItems = [];
  String _getAnalId;
  String _getCountryId;
  String _singleCountry;

  String get singleCountry {
    return _singleCountry;
  }

  String get getCountryId {
    return _getCountryId;
  }

  String get getAnalId {
    return _getAnalId;
  }

  void setCountryId({String countryName}) {
    CountryDensityModel getById = _countryItems.firstWhere(
      (element) => element.countryName == countryName,
    );
    _getCountryId = getById.countryName;
    print("Mahdi:: $_getCountryId");
    notifyListeners();
  }

  void setAnalysisId({String analysisName}) {
    AnalyticsModel getById = _items.firstWhere(
      (element) => element.title == analysisName,
    );
    _getAnalId = getById.id;
    print("Mahdi:: $_getAnalId");
    notifyListeners();
  }

  void clearCountryData() {
    _countryItems.clear();
    notifyListeners();
  }

  List<CountryDensityModel> get countryItems {
    return _countryItems;
  }

  bool get myBigDropSelected {
    return _myBigDropSelected;
  }

  void setBigDropSelected(bool setFlag) {
    _myBigDropSelected = setFlag;
    notifyListeners();
  }

  void selectSingle({String name}) {
    _myBigDropSelected = true;
    List<CountryDensityModel> temp = [];
    for (int i = 0; i < _countryItems.length; i++) {
      if (_countryItems[i].countryName == name) {
        temp.add(
          CountryDensityModel("${_countryItems[i].countryName}", 26337),
        );
        _singleCountry = name;
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
      print("Mahdi: List ${loadedProducts[0].id}");

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
      _myBigDropSelected = false;
      notifyListeners();
      print("Mahdi Error $e");
    }
  }

  void clearDate() {
    _items = [];
    notifyListeners();
  }

  void clearBoth() {
    _items = [];
    _countryItems = [];
    notifyListeners();
  }
}
