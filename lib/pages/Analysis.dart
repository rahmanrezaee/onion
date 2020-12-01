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
  @override
  void initState() {
    super.initState();
  }

  final display = createDisplay(
    length: 3,
    decimal: 0,
  );

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
        // drawer: MyDrawer(),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
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
        body: ListView(
          children: [
            MyAppBarContainer(),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: deviceSize(context).height * 0.01),
              height: deviceSize(context).height,
              child: Column(
                children: [
                  MyGoogleMap(
                    key: widget.key,
                  ),
                  Consumer<AnalysisProvider>(
                    builder:
                        (BuildContext context, analysisValue, Widget child) {
                      return analysisValue.country != null
                          ? PieChartAnalysisWidget(analysisValue)
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
                ],
              ),
            ),
            Container(
                // child: AnimationSplineDefault(widget.key),
                ),
          ],
        ));
  }
}
