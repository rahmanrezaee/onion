import 'package:flutter/foundation.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';

import 'dropDownItem/CategoryProvider.dart';

class MyDropDownState extends ChangeNotifier {
  List<CountryDensityModel> _items = [
    CountryDensityModel('Afghanistan', 26337),
    CountryDensityModel('United States of America', 26337),
    CountryDensityModel('Russia', 26337),
    CountryDensityModel('Spain', 26337),
  ];
  bool _myBigDropSelected = false;
  bool _categorySelected = false;
  bool _industrySelected = false;
  String tempItem;

  List<CountryDensityModel> get items {
    return _items;
  }

  setIndustrySelected(bool flag) {
    _industrySelected = flag;
  }

  get myBigDropSelected {
    return _myBigDropSelected;
  }

  get industrySelected {
    return _industrySelected;
  }

  setCategorySelected(bool flag) {
    _categorySelected = flag;
  }

  get myCategorySelected {
    return _categorySelected;
  }

  String selectSingle({String name}) {
    _myBigDropSelected = true;
    List<CountryDensityModel> temp = [];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].countryName == name) {
        temp.add(
          CountryDensityModel("${_items[i].countryName}", 26337),
        );
        tempItem = _items[i].countryName;
      } else {
        temp.add(
          CountryDensityModel("${_items[i].countryName}", 10),
        );
      }
    }
    _items = [];
    _items = temp;
    notifyListeners();
  }
}
