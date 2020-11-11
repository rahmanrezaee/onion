import 'package:flutter/material.dart';

import 'package:onion/const/color.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';

class MyLittleAppbar extends StatelessWidget {
  final String myTitle;
  const MyLittleAppbar({
    Key key, this.myTitle,
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
      actions: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: MyAlertIcon(num: 3),
        ),
      ],
    );
  }
}
