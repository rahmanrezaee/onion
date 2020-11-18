import 'package:flutter/material.dart';
import './validation_item.dart';

class SignupValidation with ChangeNotifier {
  ValidationItem _phone = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  // ValidationItem _dob = ValidationItem(null,null);

  //Getters
  ValidationItem get phone => _phone;
  ValidationItem get email => _email;

  bool get isValid {
    if (_phone.value != null && _email.value != null) {
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeEmail(String value) {
    if (value.length >= 7 &&  value.contains("@")) {
      
      _email = ValidationItem(value, null);
    } else {
      _email = ValidationItem(null, "Must Inter Valid Email");
    }

    notifyListeners();
  }

  void changePhone(String value) {
    if (value.length >= 9) {
      _phone = ValidationItem(value, null);
    } else {
      _phone = ValidationItem(null, "Must be at least 9 characters");
    }
    notifyListeners();
  }

  void submitData() {
    // print("FirstName: ${firstName.value}, LastName: ${lastName.value}, ${DateTime.parse(dob.value)}");
  }
}
