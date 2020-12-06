import 'package:connectivity/connectivity.dart';

///Flutter package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:onion/models/circularChart.dart';
import 'package:onion/models/sample_view.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:onion/utilities/Connectivity/MyConnectivity.dart';
import 'package:provider/provider.dart';

///Map import
import 'package:syncfusion_flutter_maps/maps.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Local import

/// Renders the map widget with range color mapping
class MyGoogleMap extends StatefulWidget {
  MyGoogleMap({Key key}) : super(key: key);

  @override
  _MapRangeColorMappingPageState createState() =>
      _MapRangeColorMappingPageState();
}

class _MapRangeColorMappingPageState extends State<MyGoogleMap> {
  // The format which is used for formatting the tooltip text.
  final NumberFormat _numberFormat = NumberFormat('#.#');
  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  void initState() {
    super.initState();
    // _connectivity.initialise();

    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(context) => SingleChildScrollView(child: _getMapsWidget());

  bool isLaod = false;
  Widget _getMapsWidget() => Container(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10, bottom: 5),
            child: Consumer<AnalysisProvider>(
              builder: (context, anavalue, Widget child) {
                return anavalue.country != null
                    ? anavalue.country.isEmpty
                        ? Column(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.replay), onPressed: () {}),
                              Text("not loaded Country"),
                            ],
                          )
                        : FutureBuilder<dynamic>(
                            future: Future<dynamic>.delayed(
                                Duration(milliseconds: 500), () => 'Loaded'),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              return snapshot.hasData
                                  ? SfMapsTheme(
                                      data: SfMapsThemeData(
                                        shapeHoverColor:
                                            Color.fromRGBO(176, 237, 131, 1),
                                      ),
                                      child: SfMaps(
                                        layers: <MapLayer>[
                                          MapShapeLayer(
                                            showBubbles: false,
                                            showDataLabels: false,
                                            delegate: MapShapeLayerDelegate(
                                              shapeFile:
                                                  'assets/australia.json',

                                              shapeDataField: 'name',

                                              dataCount: anavalue
                                                  .worldPopulationDensityDetails
                                                  .length,
                                              primaryValueMapper: (int index) =>
                                                  anavalue
                                                      .worldPopulationDensityDetails[
                                                          index]
                                                      .countryName,

                                              shapeColorValueMapper:
                                                  (int index) {
                                                if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    100000)
                                                  return Color.fromRGBO(
                                                      0, 18, 102, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    50000)
                                                  return Color.fromRGBO(
                                                      0, 32, 128, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    20000)
                                                  return Color.fromRGBO(
                                                      0, 45, 153, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    10000)
                                                  return Color.fromRGBO(
                                                      0, 60, 179, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    5000)
                                                  return Color.fromRGBO(
                                                      0, 80, 204, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    1000)
                                                  return Color.fromRGBO(
                                                      0, 105, 230, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    500)
                                                  return Color.fromRGBO(
                                                      51, 120, 255, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    100)
                                                  return Color.fromRGBO(
                                                      128, 159, 255, 1);
                                                else if (anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .density >
                                                    50)
                                                  return Color.fromRGBO(
                                                      200, 159, 255, 1);
                                              },

                                              shapeTooltipTextMapper:
                                                  (int index) {
                                                anavalue.country
                                                    .forEach((element) {
                                                  if (element.country ==
                                                      anavalue
                                                          .worldPopulationDensityDetails[
                                                              index]
                                                          .countryName)
                                                    anavalue
                                                        .changeCountryColors(
                                                            element);
                                                });

                                                return anavalue
                                                        .worldPopulationDensityDetails[
                                                            index]
                                                        .countryName +
                                                    ' ';
                                              },
                                              // Group and differentiate the shapes using the color
                                              // based on [MapColorMapper.from] and
                                              //[MapColorMapper.to] value.
                                              //
                                              // The value of the [MapColorMapper.from] and
                                              // [MapColorMapper.to] will be compared with the value
                                              // returned in the [shapeColorValueMapper] and
                                              // the respective [MapColorMapper.color] will be applied
                                              // to the shape.
                                              //
                                              // [MapColorMapper.text] which is used for the text of
                                              // legend item and [MapColorMapper.color] will be used for
                                              // the color of the legend icon respectively.
                                              shapeColorMappers: const <
                                                  MapColorMapper>[
                                                MapColorMapper(
                                                    from: 0,
                                                    to: 50,
                                                    color: Color.fromRGBO(
                                                        128, 159, 255, 1),
                                                    text: '<50'),
                                                MapColorMapper(
                                                    from: 50,
                                                    to: 100,
                                                    color: Color.fromRGBO(
                                                        51, 102, 255, 1),
                                                    text: '50 - 100'),
                                                MapColorMapper(
                                                    from: 100,
                                                    to: 250,
                                                    color: Color.fromRGBO(
                                                        0, 57, 230, 1),
                                                    text: '100 - 250'),
                                                MapColorMapper(
                                                    from: 250,
                                                    to: 500,
                                                    color: Color.fromRGBO(
                                                        0, 51, 204, 1),
                                                    text: '250 - 500'),
                                                MapColorMapper(
                                                    from: 500,
                                                    to: 1000,
                                                    color: Color.fromRGBO(
                                                        0, 45, 179, 1),
                                                    text: '500 - 1k'),
                                                MapColorMapper(
                                                    from: 1000,
                                                    to: 5000,
                                                    color: Color.fromRGBO(
                                                        0, 38, 153, 1),
                                                    text: '1k - 5k'),
                                                MapColorMapper(
                                                    from: 5000,
                                                    to: 10000,
                                                    color: Color.fromRGBO(
                                                        0, 32, 128, 1),
                                                    text: '5k - 10k'),
                                                MapColorMapper(
                                                    from: 10000,
                                                    to: 50000,
                                                    color: Color.fromRGBO(
                                                        0, 26, 102, 1),
                                                    text: '10k - 30k'),
                                              ],
                                            ),
                                            enableShapeTooltip: true,
                                            // legendSource: MapElement.shape,
                                            strokeColor: Colors.white30,
                                            // legendSettings: const MapLegendSettings(
                                            //     position: MapLegendPosition.bottom,
                                            //     iconType: MapIconType.square,
                                            //     overflowMode: MapLegendOverflowMode.wrap,
                                            //     padding: EdgeInsets.only(top: 15)),
                                            tooltipSettings: MapTooltipSettings(
                                              color: const Color.fromRGBO(
                                                  20, 20, 20, 1),
                                              //     model.themeData.brightness == Brightness.light
                                              //         ? const Color.fromRGBO(0, 32, 128, 1)
                                              //         : const Color.fromRGBO(226, 233, 255, 1),
                                              // strokeColor:
                                              //     model.themeData.brightness == Brightness.light
                                              //         ? Colors.white
                                              //         : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    );
                            })
                    : FutureBuilder(
                        future: anavalue.getAnalysisData(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          if (snapshot.connectionState == ConnectionState.done)
                            return Column(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.replay),
                                    onPressed: () {
                                      // droValue.categoryList = null;
                                      Provider.of<DropdownProvider>(context, listen: false)
                                          .setCategoryListToNull();
                                      // droValue.getAnalysisData();
                                      anavalue.getAnalysisData();
                                    }),
                                Center(child: Text("not loaded Country")),
                              ],
                            );
                        },
                      );
              },
            ),
          ),
        ),
      );
}

class _CountryDensityModel {
  _CountryDensityModel(this.countryName, this.density);

  final String countryName;
  final double density;
}
