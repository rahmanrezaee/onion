import 'package:flutter/foundation.dart';

class MyFlagState with ChangeNotifier {
  bool flagIndustry;
  bool flagAnalytics;
  String industryParent = null;
  String analyticsParen = null;

  bool flagIndustryFunc() {
    flagIndustry = !flagIndustry;
    return flagIndustry;
  }

  bool flagAnalyticsFunc() {
    flagAnalytics = !flagAnalytics;
    return flagAnalytics;
  }

  String industryParentFunc(String parentName) {
    industryParent = parentName;
    notifyListeners();
    return industryParent;
  }

  String analyticsParenFunc(String parentName) {
    analyticsParen = parentName;
    notifyListeners();
    return analyticsParen;
  }
}
