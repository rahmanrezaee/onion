import 'package:flutter/material.dart';

Widget showSnackbar(
    {String text, Icon icon, Color color, Duration duration, margin}) {
  return new SnackBar(
    // behavior: SnackBarBehavior.floating,
    // margin: margin,
    backgroundColor: color,
    content: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: new Text(
            text,
            style: TextStyle(fontFamily: "Vazir"),
            overflow: TextOverflow.visible,
          ),
        ),
        icon
      ],
    ),
    duration: duration == null ? Duration(seconds: 2) : duration,
  );
}
