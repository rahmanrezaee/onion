import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/pages/Home.dart';
import 'package:onion/pages/MainScreen.dart';

class DrawerScaffold with ChangeNotifier {
  String scaffoldType = MainScreen.routeName;

  scaffoldFunc({String mScaffoldType}) {
    scaffoldType = mScaffoldType;
    print("Mahdi: $mScaffoldType");
    notifyListeners();
  }
}
