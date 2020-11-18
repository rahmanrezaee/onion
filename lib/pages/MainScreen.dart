import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onion/GeoJson.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/Home.dart';
import 'package:onion/pages/Idea/setupIdea.dart';
import 'package:onion/pages/MyMessagePage.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/pages/underDevelopment.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/Home/MyPopup.dart';
import 'package:onion/widgets/MyAppBar.dart';
import 'package:onion/widgets/MyAppBarContainer.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:onion/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  Function openDrawer;

  MainScreen({this.openDrawer});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;
    List<Widget> list = [
      HomePage(
        openDrawer: widget.openDrawer,
      ),
      MyMessagePage(),
      UnderDevelopment(),
      UnderDevelopment(),
    ];

    return Scaffold(
      body: list[_index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: middlePurple,
        itemTitles: [
          Text("Home",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 10)),
          Text("Message",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 10)),
          Text("Analytics",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 10)),
          Text("P.Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 10)),
          Text("Search",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 10)),
        ],
        titleMarginBottom: 10,
        items: <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.pie_chart, color: Colors.white),
          Icon(Icons.dashboard, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
          // if (index == 0) {
          //   setState(() {
          //     _indext = HomePage();
          //   });
          // } else if (index == 1) {
          //   setState(() {
          //     _page = MyMessagePage();
          //   });
          // } else {
          //   setState(() {
          //     _page = UnderDevelopment();
          //   });
          // }
        },
      ),
    );
  }
}
