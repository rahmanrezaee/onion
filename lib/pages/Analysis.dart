import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';
import 'package:onion/models/sample_view.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/LineDefault.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/AnimationSplineDefault.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../widgets/MyAppBarContainer.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../const/color.dart';
import '../const/Size.dart';

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

class Analysis extends StatefulWidget {
  static const routeName = "analysis";
  // final Function openDrawer;

  const Analysis({Key key});

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  void initState() {
    super.initState();
  }

  final display = createDisplay(
    length: 3,
    decimal: 0,
  );

  

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
        // drawer: MyDrawer(),

        body: FutureBuilder(
          future: Provider.of<AnalysisProvider>(context, listen: false)
              .getAnalysisData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MyAppBarContainer(),
                      Consumer<AnalysisProvider>(
                        builder: (BuildContext context, analysisValue,
                            Widget child) {
                          return Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                MyGoogleMap(
                                  key: widget.key,
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
                                            left: 20, bottom: 10, right: 5),
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
                                            left: 5, bottom: 10, right: 20),
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
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    right: deviceSize(context).width * 0.04,
                                    left: deviceSize(context).width * 0.04,
                                    bottom: deviceSize(context).height * 0.01,
                                  ),
                                  width: deviceSize(context).width,
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: middlePurple,
                                    child: Text(
                                      "Open Saved Analysis",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );

              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.none:
                return Text("Problem occur in fetch data");

              case ConnectionState.active:
                break;
            }
          },
        ));
  }
}

// Row(
//   children: <Widget>[
//     Text(
//       "Select Region",
//       textScaleFactor: 1.4,
//       style: TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     IconButton(
//       icon: Icon(
//         Icons.arrow_drop_down,
//         color: Colors.white,
//       ),
//       onPressed: null,
//     )
//   ],
// ),

// Padding(
//   padding: EdgeInsets.only(
//     top: deviceSize(context).height * 0.03,
//     right: deviceSize(context).width * 0.02,
//     left: deviceSize(context).width * 0.02,
//     bottom: deviceSize(context).height * 0.03,
//   ),
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Analysis",
//           textAlign: TextAlign.center,
//           textScaleFactor: 1.4,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
