import 'package:flutter/material.dart';
import 'package:onion/const/MyUrl.dart';
import 'package:onion/models/AnalyticsModel.dart';
import 'package:onion/models/CategoryModel.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:provider/provider.dart';

class DropdownProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<CategoryModel> idustryList = [];
  List<AnalyticsModel> typeList = [];
  List<String> countryList = [];

  String categorySelected = "";
  String idustrySelected = "";
  String typeSelected = "";

  Future<void> fetchItemsCategory() async {
    try {
      categoryList.clear();
      // addCategoryFirstElement();
      notifyListeners();

      final response = await APIRequest().get(
        myUrl: "$baseDropDownItemsUrl?type=category",
        token: null,
      );

      final extractedData = response.data;
      if (extractedData == null) {
        categoryList = [];
        return;
      }
      categorySelected = extractedData[0]['name'];

      extractedData.forEach((netItems) {
        categoryList.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });

      await fetchItemsIndustry();
    } catch (e) {
      notifyListeners();
      print("Rahaman Error $e");
    }
  }

  Future<void> fetchItemsIndustry() async {
    try {
      idustryList.clear();
      // addIndestyFirstElement();
      final response = await APIRequest().get(
          myUrl:
              "$baseDropDownItemsUrl?type=category&parent=${this.categorySelected}");

      final extractedData = response.data;
      if (extractedData == null) {
        idustryList = [];
        return;
      }
      idustrySelected = extractedData[0]['name'];
      extractedData.forEach((netItems) {
        idustryList.add(
          CategoryModel(
            id: netItems['_id'],
            name: netItems['name'],
            createdAt: netItems['createdAt'],
            parent: netItems['parent'],
          ),
        );
      });
      await fetchItemsType();
    } catch (e) {
      notifyListeners();
      print("Rahman Fetch Error $e");
    }
  }

  Future<bool> fetchItemsType() async {
    try {
      typeList.clear();
      addTypeFirstElement();
      typeSelected = typeList[0].title;
      notifyListeners();
      final response = await APIRequest().get(
          myUrl:
              "$getAnalysis?category=$categorySelected&industry=$idustrySelected");

      final extractedData = response.data;

      if (extractedData == null) {
        typeList = [];
        return false;
      }
     

      extractedData.forEach((netItems) {
        var am = AnalyticsModel(
          id: netItems['_id'],
          title: netItems['title'],
          category: netItems['category'],
          industry: netItems['industry'],
          regions: netItems['regions'],
        );

        typeList.add(am);
      });

      notifyListeners();

      print("list show true");
      return true;
    } catch (e) {
      notifyListeners();
      print("Mahdi Error $e");
    }
  }

  Future<void> fetchCountryType(BuildContext context) async {
    var analysis = Provider.of<AnalysisProvider>(context);

    analysis.cleanCountryMerged();

    typeList.forEach((element) {
      element.regions.forEach((registion) {
        print("list : $registion");
        analysis.country.forEach((countryCovid) {
          if (registion == countryCovid.country) {
            analysis.addCountryMerged(countryCovid);
          }
        });
      });
    });

    // analysis.changeCountryColors(analysis.countryInList[0]);

    notifyListeners();
  }

  void changCategory(value) {
    categorySelected = value;

    fetchItemsIndustry();
  }

  void addCategoryFirstElement() {
    categoryList.add(CategoryModel(id: null, name: "Select Item", parent: "0"));
  }

  void addIndestyFirstElement() {
    this
        .idustryList
        .add(CategoryModel(id: null, name: "Select Item", parent: "0"));
  }

  void addTypeFirstElement() {
    this.typeList.add(AnalyticsModel(
          id: null,
          title: "Select Item",
          regions: [],
          category: "null",
          industry: "",
        ));
  }
}
