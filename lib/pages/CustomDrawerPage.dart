import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:onion/const/values.dart';
import 'package:onion/pages/MainScreen.dart';
import 'package:onion/pages/MyMessagePage.dart';
import 'package:onion/pages/Services.dart';
import 'package:onion/pages/underDevelopment.dart';
import 'package:onion/utilities/Connectivity/MyConnectivity.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:provider/provider.dart';
import '../pages/Home.dart';
import '../statemanagment/DrawerScaffold.dart';
import '../const/color.dart';
import './Analysis.dart';
import '../widgets/AnalysisWidget/Drawer.dart';
import '../widgets/bottom_nav.dart';

class CustomDrawerPage extends StatefulWidget {
  static const routeName = "custom_drawer";
  final Key key;

  CustomDrawerPage(this.key);

  @override
  _CustomDrawerPageState createState() => _CustomDrawerPageState();
}

class _CustomDrawerPageState extends State<CustomDrawerPage> {
  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void openCustomDrawer() {
    return _innerDrawerKey.currentState.open();
  }

  Widget _page;

  initState() {
    _page = MainScreen(openDrawer: openCustomDrawer, key: widget.key);
    super.initState();
  
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {
   
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      // default false
      swipe: true,
      // default true
      colorTransitionChild: middlePurple,
      // default Color.black54
      colorTransitionScaffold: Colors.black54,
      // default Color.black54

      //When setting the vertical offset, be sure to use only top or bottom
      offset: IDOffset.only(bottom: 0.05, right: 0, left: 0.7),
      scale: IDOffset.horizontal(1),
      // set the offset in both directions

      proportionalChildArea: true,
      // default true
      // default 0
      leftAnimationType: InnerDrawerAnimation.static,
      // default static
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(color: middlePurple),
      // default  Theme.of(context).backgroundColor

      //when a pointer that is in contact with the screen and moves to the right or left
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        // return values between 1 and 0
        print(val);
        // check if the swipe is to the right or to the left
        print(direction == InnerDrawerDirection.start);
      },
      innerDrawerCallback: (a) => print(a),
      // return  true (open) or false (close)
      leftChild: MyDrawer(),
      scaffold: Scaffold(
        // bottomNavigationBar:ConnectivityWidgetWrapper(
        body: ConnectivityWidgetWrapper(
                  child: Consumer<DrawerScaffold>(
            builder: (context, value, Widget child) {
              if (value.scaffoldType == MainScreen.routeName) {
                return _page;
              } else if (value.scaffoldType == Services.routeName) {
                return Services(openDrawer: openCustomDrawer);
              } else if (value.scaffoldType == Analysis.routeName) {
                return Analysis(openDrawer: openCustomDrawer);
              }
              return null;
            },
          ),
        )
      ),
    );
  }

  void _toggle() {
    _innerDrawerKey.currentState.toggle(
      // direction is optional
      // if not set, the last direction will be used
      //InnerDrawerDirection.start OR InnerDrawerDirection.end
      direction: InnerDrawerDirection.end,
    );
  }
}
