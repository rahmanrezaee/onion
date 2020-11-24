import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';
import 'package:onion/models/sample_view.dart';
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
  final displayDigitOnly = createDisplay(separator: ",");

  final List<SalesData> chartData = [
    SalesData(2010, 35, 23, 45, 65, 78),
    SalesData(2011, 38, 49, 56, 7, 88),
    SalesData(2012, 34, 12, 34, 54, 6),
    SalesData(2013, 52, 33, 32, 36, 7),
    SalesData(2014, 40, 30, 90, 89, 6)
  ];

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
              ? ListView(
                  children: [
                    Container(
                      // // margin: EdgeInsets.symmetric(
                      // //     vertical: deviceSize(context).height * 0.01),
                      // height: deviceSize(context).height,
                      child: Column(
                        children: [
                          MyGoogleMap(
                            key: widget.key,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              width / 2))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: new Text(
                                                  "${100}%",
                                                  style: new TextStyle(
                                                      color: Colors.red[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0),
                                                ),
                                              ),
                                            ),
                                            footer: new Text(
                                              "Confirmed - ${display(analysisValue.selectedCountry.totalConfirmed)}",
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
                                            percent: double.parse(((analysisValue
                                                            .selectedCountry
                                                            .totalConfirmed -
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalDeaths -
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalRecovered) /
                                                    analysisValue
                                                        .selectedCountry
                                                        .totalConfirmed)
                                                .toStringAsFixed(2)),
                                            center: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[50],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              width / 2))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: new Text(
                                                  "${display(100 * (analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered) / analysisValue.selectedCountry.totalConfirmed)}%",
                                                  style: new TextStyle(
                                                      color: Colors.red[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0),
                                                ),
                                              ),
                                            ),
                                            footer: new Text(
                                              "Actived - ${display(analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered)}",
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
                                            percent: double.parse((analysisValue
                                                        .selectedCountry
                                                        .totalRecovered /
                                                    analysisValue
                                                        .selectedCountry
                                                        .totalConfirmed)
                                                .toStringAsFixed(2)),
                                            center: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[50],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              width / 2))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: new Text(
                                                  "${(100 * (analysisValue.selectedCountry.totalRecovered) / analysisValue.selectedCountry.totalConfirmed).toStringAsFixed(2)}%",
                                                  style: new TextStyle(
                                                      color: Colors.red[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0),
                                                ),
                                              ),
                                            ),
                                            footer: new Text(
                                              "Recovered - ${display(analysisValue.selectedCountry.totalRecovered)}",
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
                                                ((analysisValue.selectedCountry
                                                            .totalDeaths) /
                                                        analysisValue
                                                            .selectedCountry
                                                            .totalConfirmed)
                                                    .toStringAsFixed(2)),
                                            center: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[50],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              width / 2))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: new Text(
                                                  "${(100 * (analysisValue.selectedCountry.totalDeaths) / analysisValue.selectedCountry.totalConfirmed).toStringAsFixed(2)}%",
                                                  style: new TextStyle(
                                                      color: Colors.red[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0),
                                                ),
                                              ),
                                            ),
                                            footer: new Text(
                                              "Deaths - ${display(analysisValue.selectedCountry.totalDeaths)}",
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
                            visible: analysisValue.chartTypeSelected == "bar",
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimationSplineDefault(widget.key),
                            ),
                          ),
                          Visibility(
                              visible:
                                  analysisValue.chartTypeSelected == "table",
                              child: Text("table")),
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
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  "Conformed",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 8.0),
                                                child: Text(
                                                  "${displayDigitOnly(analysisValue.selectedCountry.totalConfirmed)}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        margin: EdgeInsets.all(10),
                                        child: Container(
                                          width: 200,
                                          child: Column(
                                            children: [
                                              Text("Active"),
                                              Text(
                                                "${displayDigitOnly(analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered)}",
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        margin: EdgeInsets.all(10),
                                        child: Container(
                                          width: 200,
                                          child: Column(
                                            children: [
                                              Text("Recovered"),
                                              Text("1,934,324")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        margin: EdgeInsets.all(10),
                                        child: Container(
                                          width: 200,
                                          child: Column(
                                            children: [
                                              Text("Deaths"),
                                              Text("1,934,324")
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
                            color: Colors.white,
                            padding: EdgeInsets.all(20.0),
                            child: Table(
                              border:
                                  TableBorder.all(color: Colors.transparent),
                              children: [
                                TableRow(children: [
                                  Card(child: centerTextAlign('State/UT')),
                                  Card(child: centerTextAlign('C')),
                                  Card(child: centerTextAlign('A')),
                                  Card(child: centerTextAlign('R')),
                                  Card(child: centerTextAlign('D')),
                                ]),
                                TableRow(children: [
                                  Card(child: centerTextAlign('Herat')),
                                  Card(child: centerTextAlign('1000')),
                                  Card(child: centerTextAlign('200')),
                                  Card(child: centerTextAlign('30')),
                                  Card(child: centerTextAlign('40')),
                                ]),
                                TableRow(children: [
                                  Card(child: centerTextAlign('Herat')),
                                  Card(child: centerTextAlign('1000')),
                                  Card(child: centerTextAlign('200')),
                                  Card(child: centerTextAlign('30')),
                                  Card(child: centerTextAlign('40')),
                                ]),
                                TableRow(children: [
                                  Card(child: centerTextAlign('Herat')),
                                  Card(child: centerTextAlign('1000')),
                                  Card(child: centerTextAlign('200')),
                                  Card(child: centerTextAlign('30')),
                                  Card(child: centerTextAlign('40')),
                                ]),
                                TableRow(children: [
                                  Card(child: centerTextAlign('Herat')),
                                  Card(child: centerTextAlign('1000')),
                                  Card(child: centerTextAlign('200')),
                                  Card(child: centerTextAlign('30')),
                                  Card(child: centerTextAlign('40')),
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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

  Widget centerTextAlign(value) {
    return Text(
      value,
      textAlign: TextAlign.center,
    );
  }
}
