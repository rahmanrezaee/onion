/// Dart imports
import 'dart:async';
import 'dart:math';

/// Package import
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:provider/provider.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:onion/models/sample_view.dart';

/// Renders the defaul spline chart sample.
class SplineDefault extends SampleView {
  /// Creates the defaul spline chart Series.
  const SplineDefault(Key key) : super(key: key);

  @override
  _SplineDefaultState createState() => _SplineDefaultState();
}

/// State class of the default spline chart.
class _SplineDefaultState extends SampleViewState {
  _SplineDefaultState();

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(
      builder: (BuildContext context, value, Widget child) {
        return value.getDefaultSplineSeriesList != null
            ? SfCartesianChart(
                plotAreaBorderWidth: 0,
                legend: Legend(isVisible: !isCardView),
                primaryXAxis: CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    labelPlacement: LabelPlacement.onTicks),
                primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    labelFormat: '{value}',
                    majorTickLines: MajorTickLines(size: 0)),
                series: value.getDefaultSplineSeriesList,
                tooltipBehavior: TooltipBehavior(enable: true),
              )
            : FutureBuilder(
              
                future: value.getMonthlyReport(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Center(child: CircularProgressIndicator());
                },
              );
      },
    );
  }

//

}
