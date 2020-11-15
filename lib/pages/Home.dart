import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:onion/statemanagment/dropDownItem/IndustryProvider.dart';
import 'package:onion/widgets/Home/MyPopup.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';

import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:provider/provider.dart';

// import 'gl_script.dart' show glScript;
import '../statemanagment/dropDownItem/CategoryProvider.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../widgets/MyAppBar.dart';
import '../widgets/MyAppBarContainer.dart';

class HomePage extends StatefulWidget {
  final Function openDrawer;

  const HomePage({Key key, this.openDrawer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<void> categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // categoryProvider = Provider.of<CategoryProvider>(context, listen: false)
    //     .fetchCategoryItem();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                  color: Colors.blue,
                  width: double.infinity,
                  height: deviceSize(context).width * 0.5,
                ),
                SizedBox(
                  width: deviceSize(context).width * 0.9,
                  child: Row(
                    children: [
                      Row(
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
                                      decoration: TextDecoration.underline,
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
                      ),
                      RaisedButton(
                        color: middlePurple,
                        child: Text("See Analysis"),
                        textColor: Colors.white,
                        onPressed: () => showMyDialog(context: context),
                      ),
                    ],
                  ),
                ),
                MyCardListItem(),
                MyCardListItem(),
                MyCardListItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCardListItem extends StatelessWidget {
  const MyCardListItem({
    Key key,
  }) : super(key: key);

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
            Expanded(
              child: InkWell(
                child: Text(
                  "Post an Idea Now",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: firstPurple,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
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
