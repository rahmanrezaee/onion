import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PieChartAnalysisWidget extends StatelessWidget {
  AnalysisProvider analysisValue;
  PieChartAnalysisWidget(this.analysisValue);
  final display = createDisplay(
    length: 3,
    decimal: 0,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.only(left: 20, bottom: 10, right: 5),
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
                                BorderRadius.all(Radius.circular(width / 2))),
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
                        "Confirmed - ${display(analysisValue.selectedCountry.totalConfirmed)}",
                        style: new TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.only(left: 5, bottom: 10, right: 20),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: double.parse(((analysisValue
                                      .selectedCountry.totalConfirmed -
                                  analysisValue.selectedCountry.totalDeaths -
                                  analysisValue
                                      .selectedCountry.totalRecovered) /
                              analysisValue.selectedCountry.totalConfirmed)
                          .toStringAsFixed(2)),
                      center: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius:
                                BorderRadius.all(Radius.circular(width / 2))),
                        child: Align(
                          alignment: Alignment.center,
                          child: new Text(
                            "${display(100 * (analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered) / analysisValue.selectedCountry.totalConfirmed)}%",
                            style: new TextStyle(
                                color: Colors.red[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      footer: new Text(
                        "Actived - ${display(analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered)}",
                        style: new TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
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
                  margin: EdgeInsets.only(left: 20, bottom: 10, right: 5),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: double.parse(
                          (analysisValue.selectedCountry.totalRecovered /
                                  analysisValue.selectedCountry.totalConfirmed)
                              .toStringAsFixed(2)),
                      center: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius:
                                BorderRadius.all(Radius.circular(width / 2))),
                        child: Align(
                          alignment: Alignment.center,
                          child: new Text(
                            "${(100 * (analysisValue.selectedCountry.totalRecovered) / analysisValue.selectedCountry.totalConfirmed).toStringAsFixed(2)}%",
                            style: new TextStyle(
                                color: Colors.red[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      footer: new Text(
                        "Recovered - ${display(analysisValue.selectedCountry.totalRecovered)}",
                        style: new TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.only(left: 5, bottom: 10, right: 20),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: new CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: double.parse(
                          ((analysisValue.selectedCountry.totalDeaths) /
                                  analysisValue.selectedCountry.totalConfirmed)
                              .toStringAsFixed(2)),
                      center: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius:
                                BorderRadius.all(Radius.circular(width / 2))),
                        child: Align(
                          alignment: Alignment.center,
                          child: new Text(
                            "${(100 * (analysisValue.selectedCountry.totalDeaths) / analysisValue.selectedCountry.totalConfirmed).toStringAsFixed(2)}%",
                            style: new TextStyle(
                                color: Colors.red[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      footer: new Text(
                        "Deaths - ${display(analysisValue.selectedCountry.totalDeaths)}",
                        style: new TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
