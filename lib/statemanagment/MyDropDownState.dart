import 'package:flutter/foundation.dart';
import 'package:onion/models/CountryDensityModel.dart';
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
  bool _analyticsSelected = false;
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

  setAnalyticsSelected() {
    _analyticsSelected = !_analyticsSelected;
    _items = !_analyticsSelected
        ? [
            CountryDensityModel('Monaco', 26337),
            CountryDensityModel('Macao', 21717),
            CountryDensityModel('Singapore', 8350),
            CountryDensityModel('Afghanistan', 8351),
            CountryDensityModel('United States of America', 8352),
          ]
        : [
            CountryDensityModel('Hong kong', 7140),
            CountryDensityModel('Gibraltar', 3369),
            CountryDensityModel('Canada', 8354),
            CountryDensityModel('Iran', 8353),
          ];
    notifyListeners();
  }

  get analyticsSelected {
    return _analyticsSelected;
  }
}
