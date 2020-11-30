import 'package:flutter/material.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';

class DropdownProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<CategoryModel> idustryList = [];
  List<CategoryModel> typeList = [];
  List<String> countryList = [];

  String categorySelected = "";
  String idustrySelected = "";
  String typeSelected = "";

  Future<void> fetchItemsCategory() async {
    try {
      final response = await APIRequest().get(
        myUrl: "$baseDropDownItemsUrl?type=category",
        token: null,
      );

      final extractedData = response.data;

      print("extractedData ${extractedData}");
      if (extractedData == null) {
        categoryList = [];
        return;
      }

      final lastExtract = extractedData;

      // loadedProducts.add(extractedData.forEach());
      categorySelected = lastExtract[0]['name'];

      lastExtract.forEach((netItems) {
        categoryList.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print("Mahdi Error $e");
    }
  }

  Future<void> fetchItemsIndustry() async {
    try {
      final response = await APIRequest().get(
        myUrl: "$baseDropDownItemsUrl?type=${this.categorySelected}",
        token: null,
      );

      final extractedData = response.data;

      print("extractedData ${extractedData}");
      if (extractedData == null) {
        idustryList = [];
        return;
      }

      final lastExtract = extractedData;

      // loadedProducts.add(extractedData.forEach());
      lastExtract.forEach((netItems) {
        idustryList.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print("Mahdi Error $e");
    }
  }

  Future<void> fetchItemsType() async {
    try {
      final response = await APIRequest().get(
        myUrl: "$baseDropDownItemsUrl?type=category",
        token: null,
      );

      final extractedData = response.data;

      print("extractedData ${extractedData}");
      if (extractedData == null) {
        categoryList = [];
        return;
      }

      final lastExtract = extractedData;

      // loadedProducts.add(extractedData.forEach());

      lastExtract.forEach((netItems) {
        categoryList.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print("Mahdi Error $e");
    }
  }

  void changCategory(value) {
    categorySelected = value;
    
    fetchItemsIndustry();


  }
}
