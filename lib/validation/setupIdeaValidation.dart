import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'validation_item.dart';

class SetupIdeaValidation with ChangeNotifier {
  ValidationItem _year = ValidationItem(null, null);
  ValidationItem _month = ValidationItem(null, null);
  ValidationItem _teamSize = ValidationItem(null, null);
  ValidationItem _website = ValidationItem(null, null);
  ValidationItem _about = ValidationItem(null, null);
  // ValidationItem _dob = ValidationItem(null,null);

  //Getters
  ValidationItem get year => _year;
  ValidationItem get month => _month;
  ValidationItem get teamSize => _teamSize;
  ValidationItem get website => _website;
  ValidationItem get about => _about;

  bool get isValid {
    if (_year.value != null &&
        _month.value != null &&
        _teamSize.value != null &&
        _website.value != null &&
        _about != null) {
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeYear(String value) {
    if (value.length > 0) {
      _year = ValidationItem(value, null);
    } else {
      _year = ValidationItem(null, "Must Inter Valid Year");
    }

    notifyListeners();
  }

  void changeAbout(String value) {
    if (value.length > 10) {
      _about = ValidationItem(value, null);
    } else {
      _about = ValidationItem(null, "Must Inter More detail");
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

  void changeWebsite(String value) {
    if (value.length <= 30 && isURL(value)) {
      _website = ValidationItem(value, null);
    } else {
      _website = ValidationItem(null, "Must Inter Valid Website");
    }
    notifyListeners();
  }
}
