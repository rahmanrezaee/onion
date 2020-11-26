import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/CountryDensityModel.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';
import 'package:onion/models/sample_view.dart';
import 'package:onion/models/tableSatatis.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisProvider with ChangeNotifier {
  Dio dio = new Dio();
  GlobalChart gc;
  var now = DateTime.now();
  String chartTypeSelected = "pie";
  String barSelectType = "monthly";
  String pieSelectType = "total";
  List<TableSatatis> tableSatatis;
  List<Map> chartTypes = [
    {
      "display": "Pie",
      "value": "pie",
    },
    {
      "display": "Table",
      "value": "table",
    },
    {
      "display": "Line",
      "value": "line",
    },
    {
      "display": "Date",
      "value": "date",
    },
  ];
  List<Map> barType = [
    {
      "display": "Monthly",
      "value": "monthly",
    },
    {
      "display": "Daily",
      "value": "daily",
    },
  ];
  List<Map> pieType = [
    {
      "display": "Total",
      "value": "total",
    },
    {
      "display": "Newest",
      "value": "newest",
    },
  ];
  List<CircularChart> country;
  List<CircularChart> monthlyDate;
  CircularChart selectedCountry;
  List<CountryDensityModel> worldPopulationDensityDetails;
  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeriesList;


   final display = createDisplay(
    length: 3,
    decimal: 0,
  );


  
  void setchartType(String value) {
    this.chartTypeSelected = value;
    getDefaultSplineSeriesList = null;
    notifyListeners();
  }

  void setbarChartType(String value) {
    getDefaultSplineSeriesList = null;
    this.barSelectType = value;
    notifyListeners();
  }

  void setpieChartType(String value) {
    this.pieSelectType = value;
    notifyListeners();
  }

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
    getDefaultSplineSeriesList = null;
    tableSatatis = null;
    notifyListeners();
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
    getMonthlyReport();
    getTableDailyReport();
  }

  Future getMonthlyReport() async {
    final List<ChartSampleData> chartData = <ChartSampleData>[];
    String url = this.barSelectType == "monthly"
        ? "https://api.covid19api.com/country/${selectedCountry.country}?from=${Jiffy(Jiffy(now).subtract(months: 6)).format("yyy-MM")}-30T00:00:00Z&to=${Jiffy(now).format("yyy-MM")}-01T00:00:00Z"
        : "https://api.covid19api.com/country/${selectedCountry.country}?from=${Jiffy(Jiffy(now).subtract(days: 6)).format("yyy-MM-d")}T00:00:00Z&to=${Jiffy(now).format("yyy-MM-d")}T00:00:00Z";
    try {
      Response state = await dio.get(url.toString());
      print("line $url");
      List data = state.data;

      for (int i = 0; i < data.length; i++) {
        if (chartData.length > 0) {
          if (this.barSelectType == "monthly") {
            if (Jiffy(chartData.elementAt(chartData.length - 1).x).MMM ==
                Jiffy(data[i]["Date"]).MMM) {
              ChartSampleData curr = chartData.elementAt(chartData.length - 1);

              chartData.elementAt(chartData.length - 1).y += curr.y;
              chartData.elementAt(chartData.length - 1).secondSeriesYValue +=
                  curr.secondSeriesYValue;
              chartData.elementAt(chartData.length - 1).thirdSeriesYValue +=
                  curr.thirdSeriesYValue;
              chartData.elementAt(chartData.length - 1).fourthSeriesYValue +=
                  curr.fourthSeriesYValue;
            } else {
              chartData.add(
                ChartSampleData(
                  x: data[i]["Date"],
                  y: data[i]["Confirmed"],
                  secondSeriesYValue: data[i]["Active"],
                  thirdSeriesYValue: data[i]["Recovered"],
                  fourthSeriesYValue: data[i]["Deaths"],
                ),
              );
            }
          } else {

            if (Jiffy(chartData.elementAt(chartData.length - 1).x).MMMd ==
                Jiffy(data[i]["Date"]).MMMd) {
              ChartSampleData curr = chartData.elementAt(chartData.length - 1);

              chartData.elementAt(chartData.length - 1).y += curr.y;
              chartData.elementAt(chartData.length - 1).secondSeriesYValue +=
                  curr.secondSeriesYValue;
              chartData.elementAt(chartData.length - 1).thirdSeriesYValue +=
                  curr.thirdSeriesYValue;
              chartData.elementAt(chartData.length - 1).fourthSeriesYValue +=
                  curr.fourthSeriesYValue;
            } else {
              chartData.add(
                ChartSampleData(
                  x: data[i]["Date"],
                  y: data[i]["Confirmed"],
                  secondSeriesYValue: data[i]["Active"],
                  thirdSeriesYValue: data[i]["Recovered"],
                  fourthSeriesYValue: data[i]["Deaths"],
                ),
              );
            }
           
          }
        } else {
          chartData.add(
            ChartSampleData(
              x: data[i]["Date"],
              y: data[i]["Confirmed"],
              secondSeriesYValue: data[i]["Active"],
              thirdSeriesYValue: data[i]["Recovered"],
              fourthSeriesYValue: data[i]["Deaths"],
            ),
          );
        }
      }
      getDefaultSplineSeriesList = <SplineSeries<ChartSampleData, String>>[
        SplineSeries<ChartSampleData, String>(
          dataSource: chartData,
          color: Color(0xff0000),
          xValueMapper: (ChartSampleData sales, _) =>
              (this.barSelectType == "monthly")
                  ? Jiffy(sales.x).MMM
                  : Jiffy(sales.x).MMMd,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          markerSettings: MarkerSettings(isVisible: true),
          name: 'Confirmed',
        ),
        SplineSeries<ChartSampleData, String>(
          dataSource: chartData,
          name: 'Actived',
          color: Color(0x0088f8),
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (ChartSampleData sales, _) =>
              (this.barSelectType == "monthly")
                  ? Jiffy(sales.x).MMM
                  : Jiffy(sales.x).MMMd,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        ),
        SplineSeries<ChartSampleData, String>(
          dataSource: chartData,
          name: 'Recovered',
          color: Color(0x00e58c),
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (ChartSampleData sales, _) =>
              (this.barSelectType == "monthly")
                  ? Jiffy(sales.x).MMM
                  : Jiffy(sales.x).MMMd,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
        ),
        SplineSeries<ChartSampleData, String>(
          dataSource: chartData,
          name: 'Deaths',
          color: Color(0x030301),
          markerSettings: MarkerSettings(isVisible: true),
          xValueMapper: (ChartSampleData sales, _) =>
              (this.barSelectType == "monthly")
                  ? Jiffy(sales.x).MMM
                  : Jiffy(sales.x).MMMd,
          yValueMapper: (ChartSampleData sales, _) => sales.fourthSeriesYValue,
        )
      ];
      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("errors");
      print(e.response);
    }
  }

  Future getTableDailyReport() async {
    tableSatatis = List<TableSatatis>();
    String url =
        "https://api.covid19api.com/country/${selectedCountry.country}?from=${Jiffy(Jiffy(now).subtract(days: 6)).format("yyy-MM-dd")}T00:00:00Z&to=${Jiffy(now).format("yyy-MM-dd")}T00:00:00Z";
    try {
      print("print $url");
      Response state = await dio.get(url.toString());
      List data = state.data;
      print("list of $data");
      for (int i = 0; i < data.length; i++) {
        if (tableSatatis.length > 0 &&
            tableSatatis.elementAt(tableSatatis.length - 1).date ==
                data[i]["Date"]) {
          var last = tableSatatis.elementAt(tableSatatis.length - 1);
          print(last);
          last.actived = last.actived + data[i]["Active"];
          last.actived = last.confiromed + data[i]["Confirmed"];
          last.actived = last.death + data[i]["Deaths"];
          last.actived = last.recovered + data[i]["Recovered"];
        } else {
          tableSatatis.add(TableSatatis(
              actived: data[i]["Active"],
              confiromed: data[i]["Confirmed"],
              death: data[i]["Deaths"],
              recovered: data[i]["Recovered"],
              date: data[i]["Date"]));
        }
      }
      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("errors");
      print(e.response);
    }
  }
}
