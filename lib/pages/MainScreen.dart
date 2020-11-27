import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/Home.dart';
import 'package:onion/pages/MyMessagePage.dart';
import 'package:onion/pages/underDevelopment.dart';
import 'package:onion/widgets/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "mainScreen";
  Function openDrawer;

  MainScreen({Key key, this.openDrawer});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageWidget = [
      HomePage(openDrawer: widget.openDrawer),
      MyMessagePage(openDrawer: widget.openDrawer),
      // Analysis(openDrawer: widget.openDrawer,),
      Center(child: Text("under development")),
      Center(child: Text("under development")),
      Center(child: Text("under development"))
    ];

    return Scaffold(
      body: pageWidget[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
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
            _page = index;
          });
        },
      ),
    );
  }
}
