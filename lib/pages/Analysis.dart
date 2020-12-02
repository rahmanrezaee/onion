import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/globalChart.dart';
import 'package:onion/models/sample_view.dart';
import 'package:onion/statemanagment/SaveAnalModel.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/LineDefault.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/AnimationSplineDefault.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/TableChart.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/pie.dart';
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
  final display = createDisplay(
    length: 3,
    decimal: 0,
  );

  bool enableAnalysisButton = true;

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
        // drawer: MyDrawer()
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBarContainer(),
              MyGoogleMap(
                key: widget.key,
              ),
              Consumer3<SaveAnalProvider, DropdownProvider, AnalysisProvider>(
                builder:
                    (consContext, consValue, drValue, analysisValue, child) {
                  return analysisValue.country != null
                      ? Column(
                          children: [
                            PieChartAnalysisWidget(analysisValue),
                            SizedBox(height: 10),
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.all(15),
                              child: analysisValue
                                          .selectedCountry.countryCode !=
                                      "ALL"
                                  ? analysisValue.tableSatatis != null
                                      ? TableChart(analysisValue.tableSatatis)
                                      : FutureBuilder(
                                          future: Provider.of<AnalysisProvider>(
                                                  context,
                                                  listen: false)
                                              .getTableDailyReport(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        )
                                  : Text("Please Select A country to analysis"),
                            ),
                            SizedBox(height: 10),
                            consValue.items != null
                                ? Container(
                                    padding: EdgeInsets.only(
                                      right: deviceSize(context).width * 0.04,
                                      left: deviceSize(context).width * 0.04,
                                      bottom: deviceSize(context).height * 0.01,
                                    ),
                                    width: deviceSize(context).width,
                                    child: saveAnalysis(
                                      consValue,
                                      drValue,
                                      analysisValue,
                                    ),
                                  )
                                : FutureBuilder(
                                    future: consValue.getAnalysis(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          height: 80,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return Container(
                                          height: 80,
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              right: deviceSize(context).width *
                                                  0.04,
                                              left: deviceSize(context).width *
                                                  0.04,
                                              bottom:
                                                  deviceSize(context).height *
                                                      0.01,
                                            ),
                                            width: deviceSize(context).width,
                                            child: RaisedButton(
                                              elevation: 0,
                                              color: middlePurple,
                                              child: Text(
                                                "Open Saved Analysis",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                          ],
                        )
                      : FutureBuilder(
                          future: Provider.of<AnalysisProvider>(context,
                                  listen: false)
                              .getAnalysisData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                },
              ),
              // Container(
              //     // child: AnimationSplineDefault(widget.key),
              //     ),
            ],
          ),
        ));
  }

  Widget saveAnalysis(SaveAnalProvider consValue,
      DropdownProvider dropdownValue, AnalysisProvider anavalue) {
        
    consValue.isDerecatedOrNot(anavalue.selectedCountry.country);

    print("is ${consValue.isDeprecated}");
    return  RaisedButton(
      elevation: 0,
      color: middlePurple,
      child: Text(
        "Open Saved Analysis",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: consValue.isDeprecated
          ? null
          : () {
              consValue.saveAnalysis(dropdownValue.typeList[1].id,
                  anavalue.selectedCountry.country);
            },
    );
  }
}
