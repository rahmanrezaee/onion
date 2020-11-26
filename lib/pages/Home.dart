import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/MyDropDownState.dart';
import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

import '../widgets/Home/MyAutoTextSize.dart';
import '../widgets/Home/MyCardListItem.dart';
import '../widgets/Home/MyGoogleMap.dart';
import '../GeoJson.dart';
import './Idea/setupIdea.dart';
import './authentication/Login.dart';
import '../statemanagment/auth_provider.dart';
import '../statemanagment/dropDownItem/IndustryProvider.dart';
import '../widgets/Home/MyPopup.dart';
import '../widgets/Snanckbar.dart';
import '../const/Size.dart';
import '../const/color.dart';
import '../statemanagment/dropDownItem/CategoryProvider.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../widgets/MyAppBar.dart';
import '../widgets/MyAppBarContainer.dart';

class HomePage extends StatefulWidget {
  static const routeName = "home_page";
  final Function openDrawer;

  const HomePage({Key key, this.openDrawer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAuth;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for (var i = 0; i < GeoJson.IN.length; i++) {
    //   // var ltlng = LatLng(GeoJson.IN[i][1], GeoJson.IN[i][0]);
    // }
    AnalyticsProvider analyticsProvider = Provider.of<AnalyticsProvider>(
      context,
      listen: false,
    );
    analyticsProvider.clearDate();
    analyticsProvider.clearCountryData();
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
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: deviceSize(context).width * 0.7,
                  child: InteractiveViewer(
                    child: MyGoogleMap(widget.key),
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
                                              Navigator.pushNamed(
                                                context,
                                                SignUp.routeName,
                                              );
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
                          : Container(width: deviceSize(context).width * 0.56),
                      Consumer4<Auth, CategoryProvider, IndustryProvider,
                          AnalyticsProvider>(
                        builder: (
                          consumerContext,
                          authVal,
                          catVal,
                          inVal,
                          analVal,
                          child,
                        ) {
                          return Expanded(
                            child: RaisedButton(
                              color: middlePurple,
                              child: Text("See Analysis"),
                              textColor: Colors.white,
                              onPressed: () => authVal.isAuth().then(
                                    (token) => token
                                        ? (catVal.items.isEmpty ||
                                                inVal.items.isEmpty ||
                                                analVal.items.isEmpty ||
                                                analVal.countryItems.isEmpty)
                                            ? showMyDialog(context: context)
                                            : Navigator.pushNamed(
                                                context,
                                                Analysis.routeName,
                                              )
                                        : Navigator.pushNamed(
                                            context,
                                            Login.routeName,
                                          ),
                                  ),
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
