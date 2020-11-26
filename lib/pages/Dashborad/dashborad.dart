import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';
import 'package:onion/models/sample_view.dart';
import 'package:onion/models/tableSatatis.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/LineDefault.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/AnimationSplineDefault.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'package:onion/models/circularChart.dart';

///Map import
import 'package:syncfusion_flutter_maps/maps.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

class SalesData {
  SalesData(
      this.date, this.year, this.sales, this.sales1, this.sales2, this.sales3);
  int date;
  final double year;
  final double sales;
  final double sales1;
  final double sales2;
  final double sales3;
}

class Dashboard extends StatefulWidget {
  static const routeName = "analysis";
  // final Function openDrawer;

  const Dashboard({Key key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  final display = createDisplay(
    length: 3,
    decimal: 0,
  );
  final displayDigitOnly = new NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Analysis",
          textAlign: TextAlign.center,
          textScaleFactor: 1.2,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: MyAlertIcon(num: 3),
          ),
        ],
      ),
      body: Consumer<AnalysisProvider>(
        builder: (BuildContext context, analysisValue, Widget child) {
          return analysisValue.country != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      MyGoogleMap(
                        key: widget.key,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "View By:",
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18.0),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DropDownFormField(
                                    onChanged: (value) {
                                      analysisValue.setchartType(value);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                    value: analysisValue.chartTypeSelected,
                                    dataSource: analysisValue.chartTypes,
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Visibility(
                                  visible:
                                      analysisValue.chartTypeSelected == "line",
                                  child: Expanded(
                                    child: DropDownFormField(
                                      onChanged: (value) {
                                        analysisValue.setbarChartType(value);
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      },
                                      value: analysisValue.barSelectType,
                                      dataSource: analysisValue.barType,
                                      textField: 'display',
                                      valueField: 'value',
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      analysisValue.chartTypeSelected == "pie",
                                  child: Expanded(
                                    child: DropDownFormField(
                                      onChanged: (value) {
                                        analysisValue.setpieChartType(value);
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      },
                                      value: analysisValue.pieSelectType,
                                      dataSource: analysisValue.pieType,
                                      textField: 'display',
                                      valueField: 'value',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    color: middlePurple,
                                    child: Text(
                                      "Save Data",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "pie",
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                        left: 20, bottom: 10, right: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: new CircularPercentIndicator(
                                        radius: 120.0,
                                        lineWidth: 13.0,
                                        animation: true,
                                        percent: 1,
                                        center: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.red[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(width / 2))),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: new Text(
                                              "${100}%",
                                              style: new TextStyle(
                                                  color: Colors.red[600],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                        footer: new Text(
                                          "Confirmed - ${display(analysisValue.pieSelectType == "total" ? analysisValue.selectedCountry.totalConfirmed : analysisValue.selectedCountry.newConfirmed)}",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                        left: 5, bottom: 10, right: 20),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: new CircularPercentIndicator(
                                        radius: 120.0,
                                        lineWidth: 13.0,
                                        animation: true,
                                        percent: double.parse(analysisValue.pieSelectType == "total"
                                            ? ((analysisValue.selectedCountry.totalConfirmed -
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalDeaths -
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalRecovered) /
                                                    analysisValue
                                                        .selectedCountry
                                                        .totalConfirmed)
                                                .toStringAsFixed(2)
                                            : ((analysisValue.selectedCountry.newConfirmed -
                                                        analysisValue
                                                            .selectedCountry
                                                            .newDeaths -
                                                        analysisValue
                                                            .selectedCountry
                                                            .newRecovered) /
                                                    analysisValue
                                                        .selectedCountry
                                                        .newConfirmed)
                                                .toStringAsFixed(2)),
                                        center: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.red[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(width / 2))),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: new Text(
                                              "${display(100 * (analysisValue.pieSelectType == "total" ? ((analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered) / analysisValue.selectedCountry.totalConfirmed) : ((analysisValue.selectedCountry.newConfirmed - analysisValue.selectedCountry.newDeaths - analysisValue.selectedCountry.newRecovered) / analysisValue.selectedCountry.newConfirmed)))}%",
                                              style: new TextStyle(
                                                  color: Colors.red[600],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                        footer: new Text(
                                          "Actived - ${display(analysisValue.pieSelectType == "total" ? (analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered) : (analysisValue.selectedCountry.newConfirmed - analysisValue.selectedCountry.newDeaths - analysisValue.selectedCountry.newRecovered))}",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                        left: 20, bottom: 0, right: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: new CircularPercentIndicator(
                                        radius: 120.0,
                                        lineWidth: 13.0,
                                        animation: true,
                                        percent: double.parse(
                                            analysisValue.pieSelectType ==
                                                    "total"
                                                ? (analysisValue.selectedCountry
                                                            .totalRecovered /
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalConfirmed)
                                                    .toStringAsFixed(2)
                                                : (analysisValue.selectedCountry
                                                            .newRecovered /
                                                        analysisValue
                                                            .selectedCountry
                                                            .newConfirmed)
                                                    .toStringAsFixed(2)),
                                        center: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.red[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(width / 2))),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: new Text(
                                              "${analysisValue.pieSelectType == "total" ? (100 * (analysisValue.selectedCountry.totalRecovered) / analysisValue.selectedCountry.totalConfirmed).toStringAsFixed(2) : (100 * (analysisValue.selectedCountry.newRecovered) / analysisValue.selectedCountry.newConfirmed).toStringAsFixed(2)}%",
                                              style: new TextStyle(
                                                  color: Colors.red[600],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                        footer: new Text(
                                          "Recovered - ${display(analysisValue.pieSelectType == "total" ? analysisValue.selectedCountry.totalRecovered : analysisValue.selectedCountry.newRecovered)}",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                        left: 5, bottom: 0, right: 20),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: new CircularPercentIndicator(
                                        radius: 120.0,
                                        lineWidth: 13.0,
                                        animation: true,
                                        percent: double.parse(
                                            analysisValue.pieSelectType ==
                                                    "total"
                                                ? ((analysisValue
                                                            .selectedCountry
                                                            .totalDeaths) /
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalConfirmed)
                                                    .toStringAsFixed(2)
                                                : ((analysisValue
                                                            .selectedCountry
                                                            .newDeaths) /
                                                        analysisValue
                                                            .selectedCountry
                                                            .newConfirmed)
                                                    .toStringAsFixed(2)),
                                        center: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.red[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(width / 2))),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: new Text(
                                              "${  analysisValue.pieSelectType == "total" ?  (100 * (analysisValue.selectedCountry.totalDeaths) / analysisValue.selectedCountry.totalConfirmed).toStringAsFixed(2) : (100 * (analysisValue.selectedCountry.newDeaths) / analysisValue.selectedCountry.newConfirmed).toStringAsFixed(2)}%",
                                              style: new TextStyle(
                                                  color: Colors.red[600],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                        footer: new Text(
                                          "Deaths - ${display( analysisValue.pieSelectType == "total" ?  analysisValue.selectedCountry.totalDeaths : analysisValue.selectedCountry.newDeaths)}",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "line",
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              analysisValue.selectedCountry.countryCode != "ALL"
                                  ? SplineDefault(widget.key)
                                  : Text("Please Select A country to analysis"),
                        ),
                      ),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "table",
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                        left: 20, bottom: 10, right: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "confirmed",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                display(analysisValue.selectedCountry.totalConfirmed),
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up),
                                                  Text(display(analysisValue.selectedCountry.newConfirmed))
                                                ],
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.network(
                                              "https://icon-library.com/images/d171e3cc9e.png",
                                              height: 90,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                        left: 5, bottom: 10, right: 20),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Active",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                display(analysisValue.selectedCountry.active),
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up),
                                                  Text("18")
                                                ],
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.network(
                                              "https://icon-library.com/images/d171e3cc9e.png",
                                              height: 90,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                       left: 20, bottom: 10, right: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Recovered",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                display(analysisValue.selectedCountry.totalRecovered),
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up),
                                                  Text(display(analysisValue.selectedCountry.newRecovered))
                                                ],
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.network(
                                              "https://icon-library.com/images/d171e3cc9e.png",
                                              height: 90,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 8,
                                    margin: EdgeInsets.only(
                                       left: 5, bottom: 10, right: 20),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Death",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                display(analysisValue.selectedCountry.totalDeaths),
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up),
                                                  Text(display(analysisValue.selectedCountry.newDeaths))
                                                ],
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.network(
                                              "https://icon-library.com/images/d171e3cc9e.png",
                                              height: 90,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "date",
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Conformed",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalConfirmed)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red[400],
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Active",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Recoverd",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalRecovered)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Deaths",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalDeaths)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(20.0),
                        child:
                            analysisValue.selectedCountry.countryCode != "ALL"
                                ? analysisValue.tableSatatis != null
                                    ? TableRows(analysisValue.tableSatatis)
                                    : FutureBuilder(
                                        future: Provider.of<AnalysisProvider>(
                                                context,
                                                listen: false)
                                            .getTableDailyReport(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      )
                                : Text("Please Select A country to analysis"),
                      )
                    ],
                  ),
                )
              : FutureBuilder(
                  future: Provider.of<AnalysisProvider>(context, listen: false)
                      .getAnalysisData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget TableRows(List<TableSatatis> value) {
    return Table(
      border: TableBorder.all(color: Colors.transparent),
      children: [
        TableRow(children: [
          Card(
              elevation: 0,
              child: Text(
                'Days/per',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'C',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'A',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'R',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'D',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ]),
        for (var item in value)
          TableRow(children: [
            Card(
                elevation: 0,
                child: Text(
                  Jiffy(DateTime.parse(item.date)).MMMd,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.confiromed.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.actived.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.recovered.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.death.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ]),
      ],
    );
  }
}
