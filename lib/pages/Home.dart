import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:onion/pages/Idea/setupIdea.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/dropDownItem/IndustryProvider.dart';
import 'package:onion/widgets/Home/MyPopup.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:onion/widgets/Snanckbar.dart';

import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:provider/provider.dart';

import '../statemanagment/dropDownItem/CategoryProvider.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../widgets/MyAppBar.dart';
import '../widgets/MyAppBarContainer.dart';

class Model {
  const Model(this.country, this.count);

  final String country;
  final double count;
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

  // Future<void> categoryProvider;
  List<Model> data;
  MapZoomPanBehavior _zoomPanBehavior;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  __isAuth() async {
    _isAuth = await Auth().isAuth();
    setState(() {});
    print("_isAuth $_isAuth");
  }

  List<Map<String, Object>> _data1 = [
    {'name': 'Please wait', 'value': 0}
  ];

  getData1() async {
    await Future.delayed(Duration(seconds: 4));

    const dataObj = [
      {
        'name': 'Jan',
        'value': 8726.2453,
      },
      {
        'name': 'Feb',
        'value': 2445.2453,
      },
      {
        'name': 'Mar',
        'value': 6636.2400,
      },
      {
        'name': 'Apr',
        'value': 4774.2453,
      },
      {
        'name': 'May',
        'value': 1066.2453,
      },
      {
        'name': 'Jun',
        'value': 4576.9932,
      },
      {
        'name': 'Jul',
        'value': 8926.9823,
      }
    ];

    this.setState(() {
      this._data1 = dataObj;
    });
  }

  @override
  void initState() {
    __isAuth();
    // TODO: implement initState
    _zoomPanBehavior = MapZoomPanBehavior();
    data = <Model>[
      Model('India', 280),
      Model('United States of America', 190),
      Model('Kazakhstan', 37),
    ];
    super.initState();
    this.getData1();
    // categoryProvider = Provider.of<CategoryProvider>(context, listen: false)
    //     .fetchCategoryItem();
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
          // return Text(value.items[2].val);
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
            child: Column(
              children: [
                // EChartMap(),
                Container(
                  width: double.infinity,
                  height: deviceSize(context).width * 0.5,
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
                            primaryValueMapper: (int index) =>
                                data[index].country,
                            // dataLabelMapper: (int index) =>
                            //     data[index].stateCode,
                            shapeColorValueMapper: (int index) =>
                                data[index].count,
                            // shapeTooltipTextMapper: (int index) =>
                            //     data[index].stateCode,
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
                              fontSize:
                                  Theme.of(context).textTheme.caption.fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceSize(context).width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isAuth == false
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
                                              print('You clicked on me!');
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
                      Consumer<Auth>(
                        builder: (consumerContext, val, child) {
                          return RaisedButton(
                            color: middlePurple,
                            child: Text("See Analysis"),
                            textColor: Colors.white,
                            onPressed: () => val.isAuth().then(
                                  (token) => token
                                      ? showMyDialog(context: context)
                                      : Navigator.pushNamed(
                                          context, Login.routeName),
                                ),
                          );
                        },
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
            ),
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
