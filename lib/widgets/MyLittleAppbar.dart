import 'package:flutter/material.dart';

import 'package:onion/const/color.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';

class MyLittleAppbar extends StatelessWidget {
  final String myTitle;
  final bool hasDrawer;
  final Function openDrawer;

  const MyLittleAppbar({
    Key key,
    this.myTitle,
    this.hasDrawer = false,
    this.openDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        myTitle,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[firstPurple, thirdPurple],
          ),
        ),
      ),
      centerTitle: true,
      leading: hasDrawer
          ? IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              color: Colors.white,
              onPressed: openDrawer,
            )
          : IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      actions: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: MyAlertIcon(num: 3),
        ),
      ],
    );
  }
}
