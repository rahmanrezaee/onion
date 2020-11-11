import 'package:flutter/material.dart';
//this remove scroll glow?
//You can use it like this:
//  ScrollConfiguration(
//     behavior: MyBehavior(),
//     child: ListView(
//   ),
// )
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; 
  }
}