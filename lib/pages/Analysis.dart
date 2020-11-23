// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_inner_drawer/inner_drawer.dart';
// import 'package:number_display/number_display.dart';
// import 'package:onion/models/circularChart.dart';
// import 'package:onion/models/globalChart.dart';
// import 'package:onion/statemanagment/analysis_provider.dart';
// // import 'package:onion/widgets/Home/MyGoogleMap.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';

// import '../widgets/MyAppBarContainer.dart';
// import '../widgets/AnalysisWidget/MyAlert.dart';
// import '../const/color.dart';
// import '../const/Size.dart';

// import 'package:onion/models/circularChart.dart';

// ///Map import
// import 'package:syncfusion_flutter_maps/maps.dart';

// ///Core theme import
// import 'package:syncfusion_flutter_core/theme.dart';

// class Analysis extends StatefulWidget {
//   static const routeName = "analysis";
//   // final Function openDrawer;

//   const Analysis({Key key});

//   @override
//   _AnalysisState createState() => _AnalysisState();
// }

// class _AnalysisState extends State<Analysis> {
//   Future getData;
//   GlobalChart globalChart;
//   CircularChart selectedCC;
//   List<CircularChart> lc;
//   List<_CountryDensityModel> _worldPopulationDensityDetails;

//   getInitData() {
//     getData = AnalysisProvider().getAnalysisData().then((value) {
//       setState(() {
//         GlobalChart gc = value[0];

//         selectedCC = CircularChart(
//             country: "All",
//             newConfirmed: gc.newConfirmed,
//             totalConfirmed: gc.totalConfirmed,
//             newDeaths: gc.newDeaths,
//             newRecovered: gc.newRecovered,
//             totalDeaths: gc.totalDeaths,
//             totalRecovered: gc.totalRecovered,
//             countryCode: "ALL",
//             slug: "ALL");

//         lc = value[1];
//       });
//       loadData();
//     });
//   }

//   loadData() {
//     setState(() {
//       print("country select: " + selectedCC.country);
//       if (selectedCC != null) {
//         _worldPopulationDensityDetails = lc.map((ele) {
//           if (selectedCC.country == "All Country") {
//             return _CountryDensityModel(
//                 ele.country, ele.totalConfirmed.toDouble());
//           } else {
//             if (ele.country == selectedCC.country) {
//               return _CountryDensityModel(ele.country, 1000000);
//             } else {
//               return _CountryDensityModel(ele.country, 0);
//             }
//           }
//         }).toList();
//       } else {
//         _worldPopulationDensityDetails = lc.map((ele) {
//           return _CountryDensityModel(
//               ele.country, ele.totalConfirmed.toDouble());
//         }).toList();
//       }
//     });
//   }

//   @override
//   void initState() {
//     getInitData();
//     super.initState();
//   }

//   final display = createDisplay(
//     length: 3,
//     decimal: 0,
//   );

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             "Analysis",
//             textAlign: TextAlign.center,
//             textScaleFactor: 1.2,
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.all(15.0),
//               child: MyAlertIcon(num: 3),
//             ),
//           ],
//         ),
//         // drawer: MyDrawer(),
//         bottomNavigationBar: Container(
//           padding: EdgeInsets.only(
//             right: deviceSize(context).width * 0.04,
//             left: deviceSize(context).width * 0.04,
//             bottom: deviceSize(context).height * 0.01,
//           ),
//           width: deviceSize(context).width,
//           child: RaisedButton(
//             elevation: 0,
//             color: middlePurple,
//             child: Text(
//               "Open Saved Analysis",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {},
//           ),
//         ),
//         body: FutureBuilder(
//           future: getData,
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.done:
//                 return ListView(
//                   children: [
//                     MyAppBarContainer(
//                       countyList: lc,
//                       selectedItem: selectedCC,
//                       onChanged: (value) {
//                         lc.forEach((element) {
//                           if (element.countryCode == value)
//                             setState(() {
//                               selectedCC = element;
//                               loadData();
//                             });
//                         });
//                       },
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                           vertical: deviceSize(context).height * 0.01),
//                       height: deviceSize(context).height,
//                       child: Column(
//                         children: [
//                           Container(
//                             color: Colors.white,
//                             child: Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 10, bottom: 5),
//                                 child: SfMapsTheme(
//                                   data: SfMapsThemeData(
//                                     shapeHoverColor:
//                                         Color.fromRGBO(176, 237, 131, 1),
//                                   ),
//                                   child: SfMaps(
//                                     layers: <MapLayer>[
//                                       MapShapeLayer(
//                                         showBubbles: false,
//                                         showDataLabels: false,
//                                         delegate: MapShapeLayerDelegate(
//                                           shapeFile: 'assets/australia.json',

//                                           shapeDataField: 'name',

//                                           dataCount:
//                                               _worldPopulationDensityDetails
//                                                   .length,
//                                           primaryValueMapper: (int index) =>
//                                               _worldPopulationDensityDetails[
//                                                       index]
//                                                   .countryName,

//                                           shapeColorValueMapper: (int index) {
//                                             if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 100000)
//                                               return Color.fromRGBO(
//                                                   0, 18, 102, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 50000)
//                                               return Color.fromRGBO(
//                                                   0, 32, 128, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 20000)
//                                               return Color.fromRGBO(
//                                                   0, 45, 153, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 10000)
//                                               return Color.fromRGBO(
//                                                   0, 60, 179, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 5000)
//                                               return Color.fromRGBO(
//                                                   0, 80, 204, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 1000)
//                                               return Color.fromRGBO(
//                                                   0, 105, 230, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 500)
//                                               return Color.fromRGBO(
//                                                   51, 120, 255, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 100)
//                                               return Color.fromRGBO(
//                                                   128, 159, 255, 1);
//                                             else if (_worldPopulationDensityDetails[
//                                                         index]
//                                                     .density >
//                                                 50)
//                                               return Color.fromRGBO(
//                                                   200, 159, 255, 1);
//                                           },

//                                           shapeTooltipTextMapper: (int index) {
//                                             lc.forEach((element) {
//                                               if (element.country ==
//                                                   _worldPopulationDensityDetails[
//                                                           index]
//                                                       .countryName)
//                                                 setState(() {
//                                                   selectedCC = element;
//                                                 });
//                                             });

//                                             loadData();

//                                             return _worldPopulationDensityDetails[
//                                                         index]
//                                                     .countryName +
//                                                 ' ';
//                                           },
//                                           // Group and differentiate the shapes using the color
//                                           // based on [MapColorMapper.from] and
//                                           //[MapColorMapper.to] value.
//                                           //
//                                           // The value of the [MapColorMapper.from] and
//                                           // [MapColorMapper.to] will be compared with the value
//                                           // returned in the [shapeColorValueMapper] and
//                                           // the respective [MapColorMapper.color] will be applied
//                                           // to the shape.
//                                           //
//                                           // [MapColorMapper.text] which is used for the text of
//                                           // legend item and [MapColorMapper.color] will be used for
//                                           // the color of the legend icon respectively.
//                                           shapeColorMappers: const <
//                                               MapColorMapper>[
//                                             MapColorMapper(
//                                                 from: 0,
//                                                 to: 50,
//                                                 color: Color.fromRGBO(
//                                                     128, 159, 255, 1),
//                                                 text: '<50'),
//                                             MapColorMapper(
//                                                 from: 50,
//                                                 to: 100,
//                                                 color: Color.fromRGBO(
//                                                     51, 102, 255, 1),
//                                                 text: '50 - 100'),
//                                             MapColorMapper(
//                                                 from: 100,
//                                                 to: 250,
//                                                 color: Color.fromRGBO(
//                                                     0, 57, 230, 1),
//                                                 text: '100 - 250'),
//                                             MapColorMapper(
//                                                 from: 250,
//                                                 to: 500,
//                                                 color: Color.fromRGBO(
//                                                     0, 51, 204, 1),
//                                                 text: '250 - 500'),
//                                             MapColorMapper(
//                                                 from: 500,
//                                                 to: 1000,
//                                                 color: Color.fromRGBO(
//                                                     0, 45, 179, 1),
//                                                 text: '500 - 1k'),
//                                             MapColorMapper(
//                                                 from: 1000,
//                                                 to: 5000,
//                                                 color: Color.fromRGBO(
//                                                     0, 38, 153, 1),
//                                                 text: '1k - 5k'),
//                                             MapColorMapper(
//                                                 from: 5000,
//                                                 to: 10000,
//                                                 color: Color.fromRGBO(
//                                                     0, 32, 128, 1),
//                                                 text: '5k - 10k'),
//                                             MapColorMapper(
//                                                 from: 10000,
//                                                 to: 50000,
//                                                 color: Color.fromRGBO(
//                                                     0, 26, 102, 1),
//                                                 text: '10k - 30k'),
//                                           ],
//                                         ),
//                                         enableShapeTooltip: true,
//                                         // legendSource: MapElement.shape,
//                                         strokeColor: Colors.white30,
//                                         // legendSettings: const MapLegendSettings(
//                                         //     position: MapLegendPosition.bottom,
//                                         //     iconType: MapIconType.square,
//                                         //     overflowMode: MapLegendOverflowMode.wrap,
//                                         //     padding: EdgeInsets.only(top: 15)),
//                                         tooltipSettings: MapTooltipSettings(
//                                           color: const Color.fromRGBO(
//                                               20, 20, 20, 1),
//                                           //     model.themeData.brightness == Brightness.light
//                                           //         ? const Color.fromRGBO(0, 32, 128, 1)
//                                           //         : const Color.fromRGBO(226, 233, 255, 1),
//                                           // strokeColor:
//                                           //     model.themeData.brightness == Brightness.light
//                                           //         ? Colors.white
//                                           //         : Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // MyGoogleMap(
//                           //   key: widget.key,
//                           //    countyList: lc,
//                           //    selectedCountry:selectedCC,

//                           //   ontapToMap: (index) {
//                           //     print("index map $index");
//                           //   },
//                           // ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Card(
//                                   elevation: 8,
//                                   margin: EdgeInsets.only(
//                                       left: 20, bottom: 10, right: 5),
//                                   child: Container(
//                                     padding: EdgeInsets.all(15),
//                                     child: new CircularPercentIndicator(
//                                       radius: 120.0,
//                                       lineWidth: 13.0,
//                                       animation: true,
//                                       percent: 1,
//                                       center: Container(
//                                         height: 50,
//                                         width: 50,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red[50],
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(width / 2))),
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: new Text(
//                                             "${100}%",
//                                             style: new TextStyle(
//                                                 color: Colors.red[600],
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13.0),
//                                           ),
//                                         ),
//                                       ),
//                                       footer: new Text(
//                                         "Confirmed - ${display(selectedCC.totalConfirmed)}",
//                                         style: new TextStyle(
//                                             fontWeight: FontWeight.w300,
//                                             fontSize: 15.0),
//                                       ),
//                                       circularStrokeCap:
//                                           CircularStrokeCap.round,
//                                       progressColor: Colors.purple,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Card(
//                                   elevation: 8,
//                                   margin: EdgeInsets.only(
//                                       left: 5, bottom: 10, right: 20),
//                                   child: Container(
//                                     padding: EdgeInsets.all(15),
//                                     child: new CircularPercentIndicator(
//                                       radius: 120.0,
//                                       lineWidth: 13.0,
//                                       animation: true,
//                                       percent: double.parse(((selectedCC
//                                                       .totalConfirmed -
//                                                   selectedCC.totalDeaths -
//                                                   selectedCC.totalRecovered) /
//                                               selectedCC.totalConfirmed)
//                                           .toStringAsFixed(2)),
//                                       center: Container(
//                                         height: 50,
//                                         width: 50,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red[50],
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(width / 2))),
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: new Text(
//                                             "${display(100 * (selectedCC.totalConfirmed - selectedCC.totalDeaths - selectedCC.totalRecovered) / selectedCC.totalConfirmed)}%",
//                                             style: new TextStyle(
//                                                 color: Colors.red[600],
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13.0),
//                                           ),
//                                         ),
//                                       ),
//                                       footer: new Text(
//                                         "Actived - ${display(selectedCC.totalConfirmed - selectedCC.totalDeaths - selectedCC.totalRecovered)}",
//                                         style: new TextStyle(
//                                             fontWeight: FontWeight.w300,
//                                             fontSize: 15.0),
//                                       ),
//                                       circularStrokeCap:
//                                           CircularStrokeCap.round,
//                                       progressColor: Colors.purple,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Card(
//                                   elevation: 8,
//                                   margin: EdgeInsets.only(
//                                       left: 20, bottom: 10, right: 5),
//                                   child: Container(
//                                     padding: EdgeInsets.all(15),
//                                     child: new CircularPercentIndicator(
//                                       radius: 120.0,
//                                       lineWidth: 13.0,
//                                       animation: true,
//                                       percent: double.parse(
//                                           (selectedCC.totalRecovered /
//                                                   selectedCC.totalConfirmed)
//                                               .toStringAsFixed(2)),
//                                       center: Container(
//                                         height: 50,
//                                         width: 50,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red[50],
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(width / 2))),
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: new Text(
//                                             "${(100 * (selectedCC.totalRecovered) / selectedCC.totalConfirmed).toStringAsFixed(2)}%",
//                                             style: new TextStyle(
//                                                 color: Colors.red[600],
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13.0),
//                                           ),
//                                         ),
//                                       ),
//                                       footer: new Text(
//                                         "Recovered - ${display(selectedCC.totalRecovered)}",
//                                         style: new TextStyle(
//                                             fontWeight: FontWeight.w300,
//                                             fontSize: 15.0),
//                                       ),
//                                       circularStrokeCap:
//                                           CircularStrokeCap.round,
//                                       progressColor: Colors.purple,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Card(
//                                   elevation: 8,
//                                   margin: EdgeInsets.only(
//                                       left: 5, bottom: 10, right: 20),
//                                   child: Container(
//                                     padding: EdgeInsets.all(15),
//                                     child: new CircularPercentIndicator(
//                                       radius: 120.0,
//                                       lineWidth: 13.0,
//                                       animation: true,
//                                       percent: double.parse(
//                                           ((selectedCC.totalDeaths) /
//                                                   selectedCC.totalConfirmed)
//                                               .toStringAsFixed(2)),
//                                       center: Container(
//                                         height: 50,
//                                         width: 50,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red[50],
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(width / 2))),
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: new Text(
//                                             "${(100 * (selectedCC.totalDeaths) / selectedCC.totalConfirmed).toStringAsFixed(2)}%",
//                                             style: new TextStyle(
//                                                 color: Colors.red[600],
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13.0),
//                                           ),
//                                         ),
//                                       ),
//                                       footer: new Text(
//                                         "Deaths - ${display(selectedCC.totalDeaths)}",
//                                         style: new TextStyle(
//                                             fontWeight: FontWeight.w300,
//                                             fontSize: 15.0),
//                                       ),
//                                       circularStrokeCap:
//                                           CircularStrokeCap.round,
//                                       progressColor: Colors.purple,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );

//               case ConnectionState.waiting:
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );

//               case ConnectionState.none:
//                 return Text("Problem occur in fetch data");

//               case ConnectionState.active:
//                 break;
//             }
//           },
//         ));
//   }
// }

// // Row(
// //   children: <Widget>[
// //     Text(
// //       "Select Region",
// //       textScaleFactor: 1.4,
// //       style: TextStyle(
// //         color: Colors.white,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     IconButton(
// //       icon: Icon(
// //         Icons.arrow_drop_down,
// //         color: Colors.white,
// //       ),
// //       onPressed: null,
// //     )
// //   ],
// // ),

// // Padding(
// //   padding: EdgeInsets.only(
// //     top: deviceSize(context).height * 0.03,
// //     right: deviceSize(context).width * 0.02,
// //     left: deviceSize(context).width * 0.02,
// //     bottom: deviceSize(context).height * 0.03,
// //   ),
// //   child: Row(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     mainAxisAlignment: MainAxisAlignment.center,
// //     children: <Widget>[
// //       Expanded(
// //         child: Text(
// //           "Analysis",
// //           textAlign: TextAlign.center,
// //           textScaleFactor: 1.4,
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //     ],
// //   ),
// // ),

// class _CountryDensityModel {
//   _CountryDensityModel(this.countryName, this.density);

//   final String countryName;
//   final double density;
// }
