import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/DashboardPage.dart';
import 'package:onion/pages/Dashborad/dashborad.dart';
import 'package:onion/pages/Home.dart';
import 'package:onion/pages/MyMessagePage.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/utilities/Connectivity/MyConnectivity.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:onion/widgets/bottom_nav.dart';
import 'package:onion/pages/SearchTab/SearchTab.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "mainScreen";
  Function openDrawer;

  MainScreen({Key key, this.openDrawer});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  int _index = 0;

  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageWidget = [
      HomePage(openDrawer: widget.openDrawer),
      MyMessagePage(openDrawer: widget.openDrawer),
      Analysis(),
      Dashboard(openDrawer: widget.openDrawer),
      SearchTab(openDrawer: widget.openDrawer),
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
        index: _index,
        items: <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.pie_chart, color: Colors.white),
          Icon(Icons.dashboard, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
        ],
        onTap: (index) {
          // if (index == 2 || index == 3) {

          //   setState(() {
          //     _page = _page;
          //     _index = _page;
          //   });

          //   return;
          // }

          setState(() {
            _page = index;
            _index = index;
          });
        },
      ),
    );
  }
}
