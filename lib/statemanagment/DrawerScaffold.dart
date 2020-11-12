import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/pages/Home.dart';

class DrawerScaffold with ChangeNotifier {
  String scaffoldType = "home_page";

  scaffoldFunc({String mScaffoldType}) {
    scaffoldType = mScaffoldType;
    print("Mahdi: $mScaffoldType");
    notifyListeners();
  }
}
