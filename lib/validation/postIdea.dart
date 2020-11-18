import 'package:flutter/material.dart';
import './validation_item.dart';

class PostIdeaValidation with ChangeNotifier {
  ValidationItem _year = ValidationItem(null, null);
  ValidationItem _month = ValidationItem(null, null);
  ValidationItem _teamSize = ValidationItem(null, null);
  // ValidationItem _dob = ValidationItem(null,null);

  //Getters
  ValidationItem get year => _year;
  ValidationItem get month => _month;
  ValidationItem get teamSize => _teamSize;

  bool get isValid {
    if (_year.value != null && _month.value != null) {
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeYear(String value) {
    if (value.length == 4 &&
        int.parse(value) < 2500 &&
        int.parse(value) > 1950) {
      _year = ValidationItem(value, null);
    } else {
      _year = ValidationItem(null, "Must Inter Valid Year");
    }

    notifyListeners();
  }

  void changeMonth(String value) {
    if (value.length <= 2 && int.parse(value) > 0 && int.parse(value) < 13) {
      _month = ValidationItem(value, null);
    } else {
      _month = ValidationItem(null, "Must Inter Valid Month");
    }
    notifyListeners();
  }
  void changeTeamSize(String value) {
    if (value.length <= 4 && int.parse(value) > 0) {
      _teamSize = ValidationItem(value, null);
    } else {
      _teamSize = ValidationItem(null, "Must Inter Valid Team Size");
    }
    notifyListeners();
  }
}
