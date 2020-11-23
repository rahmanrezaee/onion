import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';

class AnalysisProvider with ChangeNotifier {
  Dio dio = new Dio();
  // GlobalChart gc;
  // List<CircularChart> country;

  Future getAnalysisData() async {
    try {
      final StringBuffer url =
          new StringBuffer("https://api.covid19api.com/summary");
      Response state = await dio.get(url.toString());

      Map data = state.data;

      GlobalChart gc = GlobalChart.toJson(data['Global']);

      print(data['Global']);

      List<CircularChart> country = new List<CircularChart>();
      country.add(
        CircularChart(
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
        ),
      );
      for (var item in data['Countries']) {
        country.add(CircularChart.toJson(item));
      }

      return [gc, country];
    } on DioError catch (e) {
      print("errors");
      print(e.response);
      // throw UploadException(e.response.data["message"]);
    }
  }
}
