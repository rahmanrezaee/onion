import 'package:flutter/foundation.dart';

class MyDropDownState extends ChangeNotifier {
  bool _analyticsSelected = false;
  bool _categorySelected = false;
  bool _industrySelected = false;

  setIndustrySelected(bool flag) {
    _industrySelected = flag;
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

  setAnalyticsSelected(bool flag) {
    _analyticsSelected = flag;
  }

  get analyticsSelected {
    return _analyticsSelected;
  }
}
