/// Package import
import 'package:flutter/material.dart';

/// Local import
import 'model.dart';

/// Base class of the sample's stateful widget class
abstract class SampleView extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
  const SampleView({Key key}) : super(key: key);
}

/// Base class of the sample's state class
abstract class SampleViewState extends State<SampleView> {
  /// Holds the SampleModel information
  SampleModel model;

  /// Holds the information of current page is card view or not
  bool isCardView;

  @override
  void initState() {
    model = SampleModel.instance;
    isCardView = model.isCardView && !model.isWeb;
    super.initState();
  }

  @override

  /// Must call super.
  void dispose() {
    model.isCardView = true;
    super.dispose();
  }

  /// Get the settings panel content.
  Widget buildSettings(BuildContext context) {
    return null;
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.fourthSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
   num y;

  /// Holds x value of the datapoint
   dynamic xValue;

  /// Holds y value of the datapoint
   num yValue;

  /// Holds y value of the datapoint(for 2nd series)
   num secondSeriesYValue;
   num fourthSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
   num thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color pointColor;

  /// Holds size of the datapoint
  final num size;

  /// Holds datalabel/text value mapper of the datapoint
  final String text;

  /// Holds open value of the datapoint
  final num open;

  /// Holds close value of the datapoint
  final num close;

  /// Holds low value of the datapoint
  final num low;

  /// Holds high value of the datapoint
  final num high;

  /// Holds open value of the datapoint
  final num volume;
}
