import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../GeoJson.dart';
import './Idea/setupIdea.dart';
import './authentication/Login.dart';
import '../statemanagment/auth_provider.dart';
import '../statemanagment/dropDownItem/IndustryProvider.dart';
import '../widgets/Home/MyPopup.dart';
import '../widgets/Snanckbar.dart';
import '../const/Size.dart';
import './authentication/signup.dart';
import '../const/color.dart';
import '../statemanagment/dropDownItem/CategoryProvider.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../widgets/MyAppBar.dart';
import '../widgets/MyAppBarContainer.dart';

class Model {
  const Model(this.country, this.density);

  final String country;
  final double density;
}

class HomePage extends StatefulWidget {
  static const routeName = "home_page";
  final Function openDrawer;

  const HomePage({Key key, this.openDrawer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAuth;
  List<Model> data;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> point = List<LatLng>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.543896, 69.160652),
    zoom: 5,
  );

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  __isAuth() async {
    return await Auth().isAuth();
  }

  void addPoints() {
    // for (var i = 0; i < GeoJson.IN.length; i++) {
    // LatLng latLng = LatLng(GeoJson.IN[i][0], GeoJson.IN[i][1]);
    // print("Mahdi: GeoJson $latLng");
    // point.add(LatLng(GeoJson.IN[i][0], GeoJson.IN[i][1]));
    // }
    GeoJson.IN.forEach((element) {
      point.add(LatLng(element[0], element[1]));
    });
  }

  @override
  void initState() {
    __isAuth();
    // TODO: implement initState
    super.initState();
  }

  Set<Polygon> myPolygon() {
    addPoints();

    Set<Polygon> polygonSet = new Set();
    polygonSet.add(
      Polygon(
        polygonId: PolygonId('test'),
        points: point,
        consumeTapEvents: true,
        strokeWidth: 1,
        fillColor: Colors.redAccent,
      ),
    );

    print("Mahdi: polygonSet ${polygonSet.first.points.first}");

    return polygonSet;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(title: "Home", openDrawer: widget.openDrawer),
      body: ListView(
        children: [
          MyAppBarContainer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize(context).width * 0.06,
              vertical: deviceSize(context).height * 0.02,
            ),
            child: Text(
              "Choose Region on the Map",
              textScaleFactor: 1.2,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: deviceSize(context).width * 0.06,
              vertical: deviceSize(context).height * 0.01,
            ),
            child: Consumer<Auth>(builder: (consumerContext, val, child) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: deviceSize(context).width * 0.5,
                    child: GoogleMap(
                      polygons: myPolygon(),
                      mapType: MapType.terrain,
                      // polygons: myPolygon(),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(34.543896, 69.160652),
                        zoom: 5,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      trafficEnabled: false,
                      compassEnabled: true,
                      rotateGesturesEnabled: true,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                    ),
                  ),
                  SizedBox(
                    width: deviceSize(context).width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        val.token == null
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: deviceSize(context).width * 0.56,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "Want to Subscribe to Selected options Analysis, ",
                                          ),
                                          TextSpan(
                                            text: "Sign Up",
                                            style: TextStyle(
                                              color: firstPurple,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamed(
                                                    context, SignUp.routeName);
                                              },
                                          ),
                                          TextSpan(
                                            text: " Here!",
                                          ),
                                        ],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        Expanded(
                          child: RaisedButton(
                            color: middlePurple,
                            child: Text("See Analysis"),
                            textColor: Colors.white,
                            onPressed: () => val.isAuth().then((token) => token
                                ? showMyDialog(context: context)
                                : Navigator.pushNamed(
                                    context, Login.routeName)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyCardListItem(
                    callBack: () =>
                        Navigator.pushNamed(context, SetupIdea.routeName),
                  ),
                  MyCardListItem(
                    callBack: () {
                      _scaffoldKey.currentState.showSnackBar(
                        showSnackbar(
                            "add other", Icon(Icons.alarm), Colors.green),
                      );
                    },
                  ),
                  MyCardListItem(
                    callBack: () {
                      _scaffoldKey.currentState.showSnackBar(
                        showSnackbar(
                            "add Second", Icon(Icons.alarm), Colors.green),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class MyCardListItem extends StatefulWidget {
  Function callBack;

  MyCardListItem({
    this.callBack,
    Key key,
  }) : super(key: key);

  @override
  _MyCardListItemState createState() => _MyCardListItemState();
}

class _MyCardListItemState extends State<MyCardListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: deviceSize(context).height * 0.17,
        padding: EdgeInsets.only(
          left: deviceSize(context).height * 0.014,
          right: deviceSize(context).height * 0.014,
          top: deviceSize(context).height * 0.014,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  height: deviceSize(context).width * 0.16,
                  width: deviceSize(context).width * 0.16,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      deviceSize(context).width * 0.02,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/empty_profile.jpg",
                      ),
                    ),
                  ),
                ),
                SizedBox(width: deviceSize(context).width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyAutoTextSize(
                      myTxt: "Your Ideas! Our Believe!, ",
                      myColor: Colors.black,
                    ),
                    // MyAutoTextSize(
                    //   myTxt:
                    //       "Lorem Ipsum is simply dummy Lorem Ipsum is simply dummy Lorem Ipsum is simply dummy ",
                    //   myColor: Colors.grey,
                    // ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: deviceSize(context).width * 0.1,
                        maxWidth: deviceSize(context).width * 0.6,
                        minHeight: deviceSize(context).width * 0.01,
                        maxHeight: deviceSize(context).width * 0.09,
                      ),
                      child: Text(
                        "Lorem Ipsum is simply ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: deviceSize(context).height * 0.02),
            Consumer<Auth>(
              builder: (consumerContext, val, child) {
                return Expanded(
                  child: GestureDetector(
                    child: Text(
                      "Post an Idea Now",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: firstPurple,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => val.token != null
                        ? widget.callBack()
                        : Navigator.pushNamed(context, Login.routeName),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyAutoTextSize extends StatelessWidget {
  final String myTxt;
  final Color myColor;

  const MyAutoTextSize({
    Key key,
    this.myTxt,
    this.myColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: deviceSize(context).width * 0.1,
          maxWidth: deviceSize(context).width * 0.6,
          minHeight: deviceSize(context).width * 0.01,
          maxHeight: deviceSize(context).width * 0.04,
        ),
        child: AutoSizeText(
          myTxt,
          textScaleFactor: 1.2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: myColor),
        ),
      ),
    );
  }
}
// SizedBox(
//   width: deviceSize(context).width * 0.56,
//   child: Text(
//     "Want to Subscribe to Selected options Analysis, Sign Up Here!",
//   ),
// ),

//

// return Scaffold(
//   // appBar: MyAppBar(title: "Home", openDrawer: openDrawer),
//   body: FutureBuilder(
//     future: Provider.of<DropDownProvider>(context, listen: false)
//         .fetchDropDownItem(),
//     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       } else {
//         if (snapshot.error != null) {
//           return Center(
//             child: Text("Error Occurred!"),
//           );
//         } else {
//           return ListView(
//             children: [
//               Consumer<DropDownProvider>(
//                 builder: (context, value, child) {
//                   return MyAppBarContainer(myDropDownList: value.items);
//                   // return Text(value.items[2].val);
//                 },
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: deviceSize(context).width * 0.06,
//                   vertical: deviceSize(context).height * 0.02,
//                 ),
//                 child: Text(
//                   "Choose Region on the Map",
//                   textScaleFactor: 1.2,
//                   style: TextStyle(fontWeight: FontWeight.normal),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: deviceSize(context).width * 0.06,
//                   vertical: deviceSize(context).height * 0.01,
//                 ),
//                 child: Column(
//                   children: [
//                     // EChartMap(),
//                     // Container(
//                     //   color: Colors.blue,
//                     //   width: double.infinity,
//                     //   height: deviceSize(context).width * 0.5,
//                     // ),
//                     SizedBox(
//                       width: deviceSize(context).width * 0.9,
//                       child: Row(
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: deviceSize(context).width * 0.56,
//                                 child: RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text:
//                                             "Want to Subscribe to Selected options Analysis, ",
//                                       ),
//                                       TextSpan(
//                                         text: "Sign Up",
//                                         style: TextStyle(
//                                           color: firstPurple,
//                                           decoration:
//                                               TextDecoration.underline,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             print('You clicked on me!');
//                                           },
//                                       ),
//                                       TextSpan(
//                                         text: " Here!",
//                                       ),
//                                     ],
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           RaisedButton(
//                             color: middlePurple,
//                             child: Text("See Analysis"),
//                             textColor: Colors.white,
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                     ),
//                     MyCardListItem(),
//                     MyCardListItem(),
//                     MyCardListItem(),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//       }
//     },
//   ),
// );

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: MyAppBar(title: "Home", openDrawer: openDrawer),
//     body: FutureBuilder(
//       future: Provider.of<DropDownProvider>(context, listen: false)
//           .fetchDropDownItem(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           if (snapshot.error != null) {
//             return Center(
//               child: Text("Error Occurred!"),
//             );
//           } else {
//             return ListView(
//               children: [
//                 Consumer<DropDownProvider>(
//                   builder: (context, value, child) {
//                     return MyAppBarContainer(myDropDownList: value.items);
//                     // return Text(value.items[2].val);
//                   },
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: deviceSize(context).width * 0.06,
//                     vertical: deviceSize(context).height * 0.02,
//                   ),
//                   child: Text(
//                     "Choose Region on the Map",
//                     textScaleFactor: 1.2,
//                     style: TextStyle(fontWeight: FontWeight.normal),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: deviceSize(context).width * 0.06,
//                     vertical: deviceSize(context).height * 0.01,
//                   ),
//                   child: Column(
//                     children: [
//                       // EChartMap(),
//                       Container(
//                         color: Colors.blue,
//                         width: double.infinity,
//                         height: deviceSize(context).width * 0.5,
//                       ),
//                       SizedBox(
//                         width: deviceSize(context).width * 0.9,
//                         child: Row(
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: deviceSize(context).width * 0.56,
//                                   child: RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text:
//                                               "Want to Subscribe to Selected options Analysis, ",
//                                         ),
//                                         TextSpan(
//                                           text: "Sign Up",
//                                           style: TextStyle(
//                                             color: firstPurple,
//                                             decoration:
//                                                 TextDecoration.underline,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               print('You clicked on me!');
//                                             },
//                                         ),
//                                         TextSpan(
//                                           text: " Here!",
//                                         ),
//                                       ],
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             RaisedButton(
//                               color: middlePurple,
//                               child: Text("See Analysis"),
//                               textColor: Colors.white,
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),
//                       ),
//                       MyCardListItem(),
//                       MyCardListItem(),
//                       MyCardListItem(),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//         }
//       },
//     ),
//   );
