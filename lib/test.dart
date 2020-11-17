// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:onion/GeoJson.dart';
//
// class MyTestPage extends StatefulWidget {
//   /// Initialize the instance of the [MyHomePage] class.
//   const MyTestPage({Key key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyTestPage> {
//   Set polygon = new Set();
//   GoogleMapController _controller;
//
//   List<LatLng> point = [];
//
//   @override
//   void initState() {
//     addPoints();
//     List<Polygon> addPolygon = [
//       Polygon(
//         polygonId: PolygonId('India'),
//         points: point,
//         consumeTapEvents: true,
//         strokeColor: Colors.grey,
//         strokeWidth: 1,
//         fillColor: Colors.redAccent,
//       ),
//     ];
//     polygon.addAll(addPolygon);
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return mapState();
//   }
// }
//
// class Model {
//   const Model(this.country, this.density);
//
//   final String country;
//   final double density;
// }
