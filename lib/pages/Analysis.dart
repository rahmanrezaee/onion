import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import '../widgets/MyAppBarContainer.dart';
import '../widgets/AnalysisWidget/Drawer.dart';
import '../widgets/AnalysisWidget/MyBigDropDown.dart';
import '../widgets/AnalysisWidget/MyWebView.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../const/color.dart';
import '../widgets/AnalysisWidget/MySmallDropdown.dart';
import '../const/Size.dart';

class Analysis extends StatelessWidget {
  static const routerName = "analysis";
  final Function openDrawer;

  const Analysis({Key key, this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Analysis",
          textAlign: TextAlign.center,
          textScaleFactor: 1.2,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   color: Colors.white,
        //   onPressed: openDrawer,
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: MyAlertIcon(num: 3),
          ),
        ],
      ),
      // drawer: MyDrawer(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          right: deviceSize(context).width * 0.04,
          left: deviceSize(context).width * 0.04,
          bottom: deviceSize(context).height * 0.01,
        ),
        width: deviceSize(context).width,
        child: RaisedButton(
          elevation: 0,
          color: middlePurple,
          child: Text(
            "Open Saved Analysis",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
      body: ListView(
        children: [
          MyAppBarContainer(),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: deviceSize(context).height * 0.01),
            height: deviceSize(context).height,
            child: MyWebView(),
          ),
        ],
      ),
    );
  }
}

// Row(
//   children: <Widget>[
//     Text(
//       "Select Region",
//       textScaleFactor: 1.4,
//       style: TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     IconButton(
//       icon: Icon(
//         Icons.arrow_drop_down,
//         color: Colors.white,
//       ),
//       onPressed: null,
//     )
//   ],
// ),

// Padding(
//   padding: EdgeInsets.only(
//     top: deviceSize(context).height * 0.03,
//     right: deviceSize(context).width * 0.02,
//     left: deviceSize(context).width * 0.02,
//     bottom: deviceSize(context).height * 0.03,
//   ),
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Analysis",
//           textAlign: TextAlign.center,
//           textScaleFactor: 1.4,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
