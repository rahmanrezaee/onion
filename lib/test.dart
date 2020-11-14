import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MyTestPage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  const MyTestPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyTestPage> {
  List<Model> data;
  MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior();
    data = <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          '       New\nSouth Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Colors.red.withOpacity(0.85),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 520,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: SfMaps(
              title: const MapTitle(text: 'Australia map'),
              layers: <MapShapeLayer>[
                MapShapeLayer(
                  zoomPanBehavior: _zoomPanBehavior,
                  delegate: MapShapeLayerDelegate(
                    shapeFile: 'assets/australia.json',
                    shapeDataField: 'STATE_NAME',
                    dataCount: data.length,
                    primaryValueMapper: (int index) => data[index].state,
                    dataLabelMapper: (int index) => data[index].stateCode,
                    shapeColorValueMapper: (int index) => data[index].color,
                    shapeTooltipTextMapper: (int index) =>
                        data[index].stateCode,
                  ),
                  showDataLabels: true,
                  // showLegend: true,
                  enableShapeTooltip: true,
                  tooltipSettings: MapTooltipSettings(
                    color: Colors.grey[700],
                    strokeColor: Colors.white,
                    strokeWidth: 2,
                  ),
                  strokeColor: Colors.white,
                  strokeWidth: 0.5,
                  dataLabelSettings: MapDataLabelSettings(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.caption.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Model {
  Model(this.state, this.color, this.stateCode);

  String state;
  Color color;
  String stateCode;
}
