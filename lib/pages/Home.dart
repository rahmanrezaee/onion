import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

import '../widgets/Home/MyCardListItem.dart';
import '../widgets/Home/MyGoogleMap.dart';
import './Idea/setupIdea.dart';
import './authentication/Login.dart';
import '../statemanagment/auth_provider.dart';
import '../widgets/Home/MyPopup.dart';
import '../widgets/Snanckbar.dart';
import '../const/Size.dart';
import '../const/color.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build( context) {
   
    return Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(title: "Home", openDrawer: widget.openDrawer),
        body: ListView(children: [
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
                  child: MyGoogleMap(key: widget.key),
                ),
                SizedBox(
                  width: deviceSize(context).width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                      Consumer2<Auth, AnalysisProvider>(
                        builder:
                            (consumerContext, authVal, myDropDownVal, child) {
                          return Expanded(
                            child: RaisedButton(
                              color: middlePurple,
                              child: Text("See Analysis"),
                              textColor: Colors.white,
                              onPressed: () => authVal.token != null
                                  ? myDropDownVal.selectedCountry.country ==
                                          "All Country"
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
                        text:
                          "add other",
                          icon: Icon(Icons.alarm), color : Colors.green),
                    );
                  },
                ),
                MyCardListItem(
                  callBack: () {
                    _scaffoldKey.currentState.showSnackBar(
                      showSnackbar(
                        text: "add Second",
                        icon: Icon(Icons.alarm),
                        color: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ]));
  }
}
