import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/CountryDensityModel.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';

class AnalysisProvider with ChangeNotifier {
  Dio dio = new Dio();
  GlobalChart gc;
  List<CircularChart> country;
  CircularChart selectedCountry;
  List<CountryDensityModel> worldPopulationDensityDetails;

  Future getAnalysisData() async {
    try {
      final StringBuffer url =
          new StringBuffer("https://api.covid19api.com/summary");
      Response state = await dio.get(url.toString());

      Map data = state.data;

      GlobalChart gc = GlobalChart.toJson(data['Global']);
      print(data['Global']);

      country = new List<CircularChart>();

      CircularChart all = CircularChart(
        newConfirmed: gc.newConfirmed,
        newDeaths: gc.newDeaths,
        newRecovered: gc.newRecovered,
        country: "All Country",
        slug: "All Country",
        countryCode: "ALL",
        totalConfirmed: gc.totalConfirmed,
        totalDeaths: gc.totalDeaths,
        totalRecovered: gc.totalRecovered,
        active: gc.totalConfirmed - gc.totalDeaths,
      );
      print("done first stap");
      country.add(all);

      for (var item in data['Countries']) {
        country.add(CircularChart.toJson(item));
      }
      print("done second stap");

      changeCountryColors(all);
    } on DioError catch (e) {
      print("errors");
      print(e.response);
    }
  }

  void changeCountryColors(CircularChart selected) {
    selectedCountry = selected;

    worldPopulationDensityDetails = country.map((ele) {
      if (selectedCountry.country == "All Country") {
        return CountryDensityModel(ele.country, ele.totalConfirmed.toDouble());
      } else {
        if (ele.country == selectedCountry.country) {
          return CountryDensityModel(ele.country, 1000000);
        } else {
          return CountryDensityModel(ele.country, 100);
        }
      }
    }).toList();

    print("all done");
    notifyListeners();
  }
}
